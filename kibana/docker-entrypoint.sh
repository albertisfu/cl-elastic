#!/bin/bash
set -e

echo "Fetching certificate..."
aws secretsmanager get-secret-value --secret-id dev/certs/ca-cert --query SecretString --output text > /usr/share/kibana/config/certs/ca.crt
aws secretsmanager get-secret-value --secret-id dev/certs/cl-kibana-key --query SecretString --output text > /usr/share/kibana/config/certs/cl-kibana.key
aws secretsmanager get-secret-value --secret-id dev/certs/cl-kibana-crt --query SecretString --output text > /usr/share/kibana/config/certs/cl-kibana.crt

# Start Kibana
exec /usr/local/bin/kibana-docker