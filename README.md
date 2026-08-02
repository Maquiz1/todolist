# ⚡ DashTodo

A premium, modern Django application for managing your **Todo List** and **Notes** with a beautiful glassmorphic dark-theme UI.

---

## 📁 Project Structure

```
todolist/
├── docker-compose.yml       # Production container orchestration
├── README.md                # Deployment and developer guidelines
└── backend/                 # Django App root directory
    ├── Dockerfile           # Backend container setup
    ├── entrypoint.sh        # Start script (migrations, statics, seeding)
    ├── .dockerignore        # Excludes development temp files
    ├── .env                 # Database & secret credentials (ignored by git)
    ├── db_seed.json         # Current data dump for production seeding
    ├── manage.py            # Django CLI management script
    ├── requirements.txt     # Python production packages
    └── config/              # Django core configuration settings
```

---

## 🚀 Local Development Setup

### Prerequisite: Python 3.10+ and virtualenv

1. **Activate the Virtual Environment**:
   ```bash
   source venv-todolist/bin/activate
   ```

2. **Navigate to the Backend Directory**:
   ```bash
   cd backend
   ```

3. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Run Local Server**:
   ```bash
   python manage.py runserver
   ```
   Access the local app at [http://127.0.0.1:8000/](http://127.0.0.1:8000/).

---

## 🐳 Production Deployment with Docker & PostgreSQL

Follow these steps to deploy to a Hostinger VPS or any Docker-enabled host:

### Step 1: Copy Project Files to VPS
Transfer the project files (including the `docker-compose.yml` and `backend/` directory) to your target deployment folder (e.g. `/opt/tamris-live`):
```bash
scp -r /path/to/local/todolist root@your_vps_ip:/opt/tamris-live
```

### Step 2: Configure Environment Variables
Inside `/opt/tamris-live/backend/`, create or update the `.env` file with production values:
```ini
DEBUG=off
SECRET_KEY=generate_a_long_random_string_here

# PostgreSQL Database
DB_NAME=todolist_db
DB_USER=postgres
DB_PASSWORD=your_secure_password
DB_HOST=db
DB_PORT=5432

DATABASE_URL=postgres://postgres:your_secure_password@db:5432/todolist_db
```

### Step 3: Run the Stack
On your VPS terminal, execute:
```bash
cd /opt/tamris-live
docker compose up -d --build
```
This builds the backend image, provisions the Postgres database, runs database migrations, compiles static assets, and automatically seeds the database with `db_seed.json` (if `LOAD_SEED_DATA` is set to `true` in `docker-compose.yml`).

### Step 4: Finalize Seeding
Once the data is populated:
1. Edit `docker-compose.yml` on the host and change `LOAD_SEED_DATA=true` to `LOAD_SEED_DATA=false`.
2. Apply changes:
   ```bash
   docker compose up -d
   ```
