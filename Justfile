# Justfile

venv := ".venv/bin"


default:
    @just --list

install:
    uv pip install -e ".[dev]"

install-torch:
    source .venv/bin/activate && pip uninstall -y torch torchvision torchaudio
    source .venv/bin/activate && pip install torch torchvision torchaudio


serve:
    {{venv}}/uvicorn app.main:app --reload

lint:
    {{venv}}/black . && {{venv}}/isort . && {{venv}}/flake8 .

typecheck:
    {{venv}}/mypy .

test:
    {{venv}}/pytest -v

# Generate a new migration (with message argument)
migrate-new MESSAGE="new migration":
    alembic revision --autogenerate -m "{{MESSAGE}}"

# Apply the latest migration
migrate-up:
    alembic upgrade head

# Downgrade one step (optional but handy)
migrate-down:
    alembic downgrade -1

# Show current migration state
migrate-current:
    alembic current

psql:
    docker compose exec db psql -U konstruktion -d konstruktion_db

