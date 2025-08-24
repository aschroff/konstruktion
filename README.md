# Konstruktion

A **FastAPI-based project** demonstrating a modular DDD-style architecture with SQLAlchemy, Pydantic, Alembic migrations, PyTorch computation, and PostgreSQL running in Docker.

The project is structured to support **multiple domains**, **context boundaries**, and **service orchestration**, making it easy to extend and maintain.


## ⚙ Technologies Used


- **FastAPI** – REST API framework  
- **Pydantic** – Data validation and serialization  
- **SQLAlchemy** – ORM for database modeling  
- **PostgreSQL** – Relational database (via Docker)  
- **Alembic** – Database migrations  
- **PyTorch** – GPU/CPU computations  
- **pytest** – Unit and integration testing  
- **Just** – Task runner for testing, migrations, and more  

---

## 🚀 Installation

1. **Clone the repository**

```bash
git clone https://github.com/<your-username>/konstruktion.git
cd konstruktion
```

2. **Create Python virtual environment**

```bash
python3 -m venv .venv
source .venv/bin/activate
```


3. **Install dependencies**

```bash
uv install -e .[dev]
```

4. **Start PostgreSQL with Docker**

```bash
docker compose up -d
```

5. **Create database tables**

```bash
just migrate-up
```

---