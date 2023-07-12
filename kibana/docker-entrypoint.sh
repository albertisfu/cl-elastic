#!/bin/bash
set -e

echo "Fetching certificate..."
aws secretsmanager get-secret-value --secret-id dev/certs/ca-cert --query SecretString --output text > /usr/share/kibana/config/certs/ca.crt

# Start Kibana
exec /usr/local/bin/kibana-docker