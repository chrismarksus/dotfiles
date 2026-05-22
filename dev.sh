#!/bin/bash
# dev.sh - Convenience launcher for terminal-based Docker dev environment
# Usage: ./dev.sh [command]
# Examples:
#   ./dev.sh                    # Start container and drop into bash
#   ./dev.sh nvim               # Open nvim directly in the mounted workspace
#   ./dev.sh tmux               # Start tmux session

set -e

# Allow overriding the host projects path via env var or first arg handling
HOST_PROJECTS=${HOST_PROJECTS:-C:/Users/$USER/projects}

echo "🚀 Starting dotfiles dev container..."
echo "   Mounting: $HOST_PROJECTS → /workspace"
echo "   (Edit this path in docker-compose.yml or set HOST_PROJECTS env var)"

# Ensure docker compose is available
if ! command -v docker &> /dev/null; then
    echo "❌ Docker not found. Please install Docker Desktop."
    exit 1
fi

# Build and start in background if not running
docker compose -f docker-compose.yml build --pull
docker compose -f docker-compose.yml up -d

if [ $# -eq 0 ]; then
    echo "✅ Container ready. Attaching to bash..."
    docker compose -f docker-compose.yml exec dev bash
else
    echo "✅ Running command inside container: $*"
    docker compose -f docker-compose.yml exec dev "$@"
fi