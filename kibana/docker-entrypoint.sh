#!/bin/bash
set -e

# Environment variables for secret ids
CA_CERT_SECRET_ID=${CA_CERT_SECRET_ID:-"dev/certs/ca-cert"}
KIBANA_KEY_SECRET_ID=${KIBANA_KEY_SECRET_ID:-"dev/certs/cl-kibana-key"}
KIBANA_CERT_SECRET_ID=${KIBANA_CERT_SECRET_ID:-"dev/certs/cl-kibana-crt"}

echo "Fetching certificates..."
aws secretsmanager get-secret-value --secret-id $CA_CERT_SECRET_ID --query SecretString --output text > /usr/share/kibana/config/certs/ca.crt
aws secretsmanager get-secret-value --secret-id $KIBANA_KEY_SECRET_ID --query SecretString --output text > /usr/share/kibana/config/certs/cl-kibana.key
aws secretsmanager get-secret-value --secret-id $KIBANA_CERT_SECRET_ID --query SecretString --output text > /usr/share/kibana/config/certs/cl-kibana.crt

# Start Kibana
exec /usr/local/bin/kibana-docker