#!/usr/bin/env bash
# ==============================================================================
# Production Deployment Script for Todolist Application
# Path on Server: /opt/todolist/deploy.sh
# ==============================================================================

set -e

PROJECT_DIR="/opt/todolist"
BACKEND_DIR="${PROJECT_DIR}/backend"

echo "=========================================="
echo "🚀 Starting Todolist Production Deployment"
echo "=========================================="

# 1. Navigate to project directory
if [ -d "$PROJECT_DIR" ]; then
    cd "$PROJECT_DIR"
else
    echo "❌ Error: Project directory $PROJECT_DIR does not exist."
    exit 1
fi

# 2. Pull latest code from git (if git repository)
if [ -d ".git" ]; then
    echo "📥 Pulling latest changes from git..."
    CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
    git pull origin "$CURRENT_BRANCH" || true
fi

# 3. Create required runtime directories
echo "📁 Ensuring static and media directories exist..."
mkdir -p "${BACKEND_DIR}/staticfiles"
mkdir -p "${BACKEND_DIR}/media"

# 4. Check for production .env file
if [ ! -f "${BACKEND_DIR}/.env.docker" ]; then
    echo "Creating ${BACKEND_DIR}/.env.docker file..."
    cat <<'EOF' > "${BACKEND_DIR}/.env.docker"
DEBUG=on
SECRET_KEY=django-insecure-prod-key-todolist-tamris-2026

# PostgreSQL Database (docker-compose)
DB_NAME=todolist_db
DB_USER=todo_user
DB_PASSWORD=todo_secure_pass
DB_HOST=db
DB_PORT=5432

DATABASE_URL=postgres://todo_user:todo_secure_pass@db:5432/todolist_db

LOAD_SEED_DATA=true
ALLOWED_HOSTS=*
EOF
fi

if [ -f "${BACKEND_DIR}/.env.docker" ]; then
    sed -i 's/ALLOWED_HOSTS=.*/ALLOWED_HOSTS=*/g' "${BACKEND_DIR}/.env.docker"
fi
if [ -f "${BACKEND_DIR}/.env" ]; then
    sed -i 's/ALLOWED_HOSTS=.*/ALLOWED_HOSTS=*/g' "${BACKEND_DIR}/.env"
fi

# 5. Build and launch Docker Compose services
echo "🐳 Building and starting Docker containers..."
docker compose up -d --build

# 6. Check container status
echo "🔍 Checking running services..."
docker compose ps

echo "=========================================="
echo "✅ Deployment completed successfully!"
echo "=========================================="
