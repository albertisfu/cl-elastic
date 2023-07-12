# Pull base image.
FROM elasticsearch:8.8.1

# Install EC2 discovery plugin.
RUN bin/elasticsearch-plugin install --batch discovery-ec2

# Install AWS CLI.
USER root
# Update and install dependencies
RUN apt-get update && apt-get install -y wget unzip curl

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install

# Create the directory for the certificates
RUN mkdir -p /usr/share/elasticsearch/config/certs/ \
    && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/config/certs/

# Copy the docker-entrypoint.sh file
COPY docker-entrypoint.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Add default config file
COPY ./config/elasticsearch.yml /usr/share/elasticsearch/config/
COPY stopwords_en.txt /usr/share/elasticsearch/config/
COPY synonyms_en.txt /usr/share/elasticsearch/config/

# Switch back to elasticsearch user
USER elasticsearch

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["eswrapper"]