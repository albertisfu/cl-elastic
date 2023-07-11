# Pull base image.
FROM elasticsearch:8.8.1

# Install EC2 discovery plugin.
#RUN bin/elasticsearch-plugin install --batch discovery-ec2

# Add default config file
COPY ./config/elasticsearch.yml /usr/share/elasticsearch/config/
COPY stopwords_en.txt /usr/share/elasticsearch/config/
COPY synonyms_en.txt /usr/share/elasticsearch/config/