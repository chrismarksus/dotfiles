#!/bin/bash
# Convenience script to run Docker-based dotfiles validation

set -e

echo "=== Dotfiles Docker Test ==="
echo ""

echo "Building test image..."
docker build -t dotfiles-test .

echo ""
echo "Running validation tests..."
docker run --rm dotfiles-test

echo ""
echo "=== Test complete ==="