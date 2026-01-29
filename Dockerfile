# Use the official n8n image as base
FROM docker.n8n.io/n8nio/n8n

# For Python support in n8n, use external task runner mode instead of internal
# The internal Python runner is only for debugging and not recommended for production
# See: https://docs.n8n.io/hosting/configuration/task-runners/#setting-up-external-mode
