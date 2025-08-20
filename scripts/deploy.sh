#!/bin/bash
set -e
echo "Deploying SAM application..."
sam build
sam deploy --guided