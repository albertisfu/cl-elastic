#!/bin/bash
set -e

# Environment variables for secret ids
ES_NODE_KEY_SECRET_ID=${ES_NODE_KEY_SECRET_ID:-"dev/certs/cl-es-node-key"}
ES_NODE_CERT_SECRET_ID=${ES_NODE_CERT_SECRET_ID:-"dev/certs/cl-es-node-crt"}
CA_CERT_SECRET_ID=${CA_CERT_SECRET_ID:-"dev/certs/ca-cert"}

echo "Fetching certificates..."
aws secretsmanager get-secret-value --secret-id $ES_NODE_KEY_SECRET_ID --query SecretString --output text > /usr/share/elasticsearch/config/certs/cl-es-node.key
aws secretsmanager get-secret-value --secret-id $ES_NODE_CERT_SECRET_ID --query SecretString --output text > /usr/share/elasticsearch/config/certs/cl-es-node.crt
aws secretsmanager get-secret-value --secret-id $CA_CERT_SECRET_ID --query SecretString --output text > /usr/share/elasticsearch/config/certs/ca.crt

# Start Elasticsearch as elasticsearch user
echo "Starting Elasticsearch..."
exec /usr/share/elasticsearch/bin/elasticsearch