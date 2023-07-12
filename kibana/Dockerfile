# Pull the base image
FROM kibana:8.8.1

# Install AWS CLI.
USER root
# Update and install dependencies
RUN apt-get update && apt-get install -y wget unzip curl

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Create the directory for the certificates
RUN mkdir -p /usr/share/kibana/config/certs \
    && chown -R kibana:kibana /usr/share/kibana/config/certs/


# Add configuration file
COPY ./config/kibana.yml /usr/share/kibana/config/


# Add and set execute permissions on entrypoint script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Switch back to elasticsearch user
USER kibana

# Set entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]