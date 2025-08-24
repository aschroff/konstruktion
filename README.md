Konstruktion
A FastAPI-based project demonstrating a modular DDD-style architecture with SQLAlchemy, Pydantic, Alembic migrations, PyTorch computation, and PostgreSQL running in Docker.
The project is structured to support multiple domains, context boundaries, and service orchestration, making it easy to extend and maintain.
🏗 Project Structure
.
├── Justfile                  # Build/test/migration commands
├── alembic.ini               # Alembic configuration
├── pyproject.toml            # Python project metadata and dependencies
├── docker-compose.yml        # Docker configuration for PostgreSQL
├── app
│   ├── main.py               # FastAPI application entry point
│   ├── api
│   │   ├── endpoints         # FastAPI routers for each domain
│   │   └── tests             # API-level tests
│   ├── domains               # Domain packages
│   │   └── auftrag           # Example domain (Auftrag)
│   │       ├── context_boundary.py
│   │       ├── models.py
│   │       ├── schemas.py
│   │       ├── crud.py
│   │       └── repository.py
│   ├── database
│   │   └── session.py        # SQLAlchemy Base and DB session
│   └── services
│       └── calculation_service.py  # Domain-agnostic computation services
└── migrations                # Alembic migrations
⚙ Technologies Used
FastAPI – REST API framework
Pydantic – Data validation and serialization
SQLAlchemy – ORM for database modeling
PostgreSQL – Relational database (via Docker)
Alembic – Database migrations
PyTorch – GPU/CPU computations
pytest – Unit and integration testing
Just – Task runner for testing, migrations, and more
🚀 Installation
Clone the repository
git clone https://github.com/<your-username>/konstruktion.git
cd konstruktion
Create Python virtual environment
python3 -m venv .venv
source .venv/bin/activate
Install dependencies
uv install -e .[dev]
Start PostgreSQL with Docker
docker compose up -d
Create database tables
just migrate-up
🧪 Running Tests
Run all tests using Just:
just test
Tests cover API endpoints (via FastAPI TestClient)
Domain logic can be tested in app/domains/<domain>/tests
📝 Adding New Domains
Create a new folder in app/domains/<domain_name>
Add:
models.py – SQLAlchemy models
schemas.py – Pydantic schemas
repository.py – Data access layer
context_boundary.py – Domain logic and orchestration
Create API endpoints in app/api/endpoints
Update Alembic env.py to import new models for migrations
Generate migration:
just migrate-generate "add <domain_name>"
just migrate-up
🛠 Recommended Workflow
API calls → Context Boundary → Repository → Database
Services are stateless, orchestrate domain operations
Tests should call through context boundaries or API endpoints, not raw models