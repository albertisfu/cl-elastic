#!/bin/bash
set -e

echo "Fetching certificates..."
aws secretsmanager get-secret-value --secret-id dev/certs/cl-es-node-key --query SecretString --output text > /usr/share/elasticsearch/config/certs/cl-es-node.key
aws secretsmanager get-secret-value --secret-id dev/certs/cl-es-node-crt --query SecretString --output text > /usr/share/elasticsearch/config/certs/cl-es-node.crt
aws secretsmanager get-secret-value --secret-id dev/certs/ca-cert --query SecretString --output text > /usr/share/elasticsearch/config/certs/ca.crt

# Start Elasticsearch as elasticsearch user
echo "Starting Elasticsearch..."
exec /usr/share/elasticsearch/bin/elasticsearch