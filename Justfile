venv := ".venv/bin"

default:
    @just --list

# -------------------------
# Core setup
# -------------------------

# Install project runtime dependencies
install:
    uv sync

# Install development dependencies (dev tools, testing, type checking)
install-dev:
    uv add -- ".[dev]"
    uv sync

# Install package in editable mode (live link to src/)
install-editable:
    source {{venv}}/activate
    pip install -e .

# Install PyTorch for your platform (Apple Silicon aware)
install-torch:
    @echo "Installing PyTorch for your platform..."
    source {{venv}}/activate
    if [ "$(uname -m)" = "arm64" ]; then \
        echo "Detected Apple Silicon — using MPS-compatible wheels"; \
        pip uninstall -y torch torchvision torchaudio; \
        pip install --pre torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/nightly/cpu; \
    else \
        echo "Installing standard PyTorch wheels"; \
        pip uninstall -y torch torchvision torchaudio; \
        pip install torch torchvision torchaudio; \
    fi

# -------------------------
# Developer initialization
# -------------------------

# Run all steps for a new developer
# After running this, PyCharm can immediately recognize the project
# and the virtual environment.
# Steps:
# 1. Create a virtual environment in .venv
# 2. Install runtime dependencies
# 3. Install dev dependencies
# 4. Install the project in editable mode
# 5. Install PyTorch (Apple Silicon aware)
# 6. Install pre-commit hooks (formatting, linting, type-checking)
initialize:
    @echo "Setting up development environment..."
    python -m venv .venv
    source {{venv}}/activate
    just install
    just install-dev
    just install-editable
    just install-torch
    {{venv}}/pre-commit install --hook-type pre-commit --hook-type pre-push
    @echo "✅ Done! You can now run 'just serve', 'just test', 'just lint', etc."
    @echo "ℹ️ Pre-commit hooks are installed (black, ruff, mypy, detect-secrets)."

# -------------------------
# Server & testing
# -------------------------

# Run FastAPI server in reload mode
# PyCharm tips:
# - Use Run/Debug configuration: `uvicorn app.main:app --reload`
# - Working directory: project root
# - Environment: .venv
serve:
    {{venv}}/uvicorn app.main:app --reload

# Linting and formatting
lint:
    {{venv}}/black src && {{venv}}/isort src && {{venv}}/flake8 src

# Type checking
typecheck:
    {{venv}}/mypy src

# Run all tests
test:
    {{venv}}/pytest -v

# -------------------------
# Database migrations
# -------------------------

migrate-new MESSAGE="new migration":
    alembic revision --autogenerate -m "{{MESSAGE}}"

migrate-up:
    alembic upgrade head

migrate-down:
    alembic downgrade -1

migrate-current:
    alembic current

# -------------------------
# Database access
# -------------------------

psql:
    docker compose exec db psql -U konstruktion -d konstruktion_db

# -------------------------
# Notes for PyCharm developers
# -------------------------

# 1. After `just initialize`, set the PyCharm interpreter to `.venv`.
# 2. To run FastAPI interactively:
#    - Use Run/Debug config with `uvicorn app.main:app --reload`
#    - Set breakpoints; code changes in src/ are live thanks to editable install
# 3. To run tests interactively:
#    - Click the green arrow next to a test function/class
#    - Or create a Run/Debug config pointing to pytest in .venv
# 4. Git usage:
#    - PyCharm Git integration works out-of-the-box
#    - Stage, commit, push, pull, merge, etc.
# 5. Linting/type checking:
#    - Can be run from terminal (`just lint`, `just typecheck`)
#    - Or configure as External Tools / File Watchers
