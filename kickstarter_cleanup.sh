#!/bin/bash

# Usage: ./kickstarter_cleanup.sh

rm docker-compose.local.yml.example
rm kickstarter.sh
rm README.md
rm -rf .git
rm $0

echo "✅ Cleanup successful! 🧹"
