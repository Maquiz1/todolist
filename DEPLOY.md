Hostinger Docker Deployment Guide

Prerequisites:
- You have SSH access to the Hostinger server.
- Docker and Docker Compose are installed on the server.
- The domain todolist.tamris.or.org points to the server.

Steps:
1. Place project at `/opt/todolist` on the server.

2. Update file paths (already configured):
   - `docker-compose.yml` uses `/opt/todolist/backend` for the web service.
   - `backend/.env` contains production DB and `ALLOWED_HOSTS`.

3. Run deployment script (on server):

```bash
cd /opt/todolist
chmod +x deploy.sh
./deploy.sh
```

4. Verify containers are running:

```bash
docker ps
docker compose logs -f web
```

5. (Optional) Use a reverse proxy / SSL termination (recommended):
   - Use Nginx or Hostinger's control panel to point `todolist.tamris.or.org` to the server.
   - For automatic TLS, use Certbot + Nginx or a managed certificate through Hostinger.

Notes:
- The `entrypoint.sh` runs migrations and `collectstatic` at container start; static files are written to `/opt/todolist/backend/staticfiles` on the host.
- Database is the `db` service (Postgres) in the compose file; if you prefer an external DB, update `DATABASE_URL` in `/opt/todolist/backend/.env`.
