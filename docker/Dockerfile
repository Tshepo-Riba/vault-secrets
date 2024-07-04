# Use the official HashiCorp Vault image as the base image
FROM vault:latest

# Set environment variables
ENV VAULT_ADDR=http://0.0.0.0:8200
ENV VAULT_API_ADDR=http://0.0.0.0:8200
ENV VAULT_LOCAL_CONFIG='{"backend": {"file": {"path": "/vault/file"}}, "listener": [{"tcp": {"address": "0.0.0.0:8200", "tls_disable": 1}}], "ui": true}'

# Create necessary directories and set permissions
RUN mkdir -p /vault/file /vault/logs \
    && chown -R vault:vault /vault

# Copy Vault configuration file if you have custom configurations
COPY config.hcl ./vault/config/config.hcl

# Expose the Vault port
EXPOSE 8200

# Switch to the vault user
USER vault

# Command to start Vault server
CMD ["vault", "server", "-config=/vault/config/config.hcl"]
