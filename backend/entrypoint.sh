#!/bin/sh

# Exit immediately if a command exits with a non-zero status
set -e

echo "Waiting for database to be ready..."
python -c "
import time, socket, os
host = os.environ.get('DB_HOST', 'db')
port = int(os.environ.get('DB_PORT', 5432))
for _ in range(30):
    try:
        with socket.create_connection((host, port), timeout=2):
            print('Database is ready!')
            break
    except OSError:
        time.sleep(1)
"

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

if [ "$LOAD_SEED_DATA" = "true" ]; then
    echo "Loading database seed data..."
    python manage.py loaddata /app/db_seed.json || true
fi

echo "Starting Gunicorn server..."
exec gunicorn config.wsgi:application --bind 0.0.0.0:${PORT:-8000}
