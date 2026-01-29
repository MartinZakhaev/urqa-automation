# Stage 1: Build Python environment
FROM python:3.11-alpine AS python-builder

# Install any Python packages you need here
RUN pip install --no-cache-dir --target=/python-packages requests

# Stage 2: n8n with Python
FROM docker.n8n.io/n8nio/n8n

USER root

# Copy Python from the builder stage
COPY --from=python:3.11-alpine /usr/local/bin/python3 /usr/local/bin/python3
COPY --from=python:3.11-alpine /usr/local/bin/python /usr/local/bin/python
COPY --from=python:3.11-alpine /usr/local/lib/python3.11 /usr/local/lib/python3.11
COPY --from=python:3.11-alpine /usr/local/bin/pip3 /usr/local/bin/pip3
COPY --from=python:3.11-alpine /usr/local/bin/pip /usr/local/bin/pip

# Copy any pre-installed Python packages
COPY --from=python-builder /python-packages /usr/local/lib/python3.11/site-packages

# Create symlinks
RUN ln -sf /usr/local/bin/python3 /usr/bin/python3 && \
    ln -sf /usr/local/bin/python3 /usr/bin/python

USER node
