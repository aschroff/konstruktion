# Projekt Konstruktion

This is the **Konstruktion** FastAPI project. This README explains how to set up, run, and develop the project. Setup is automated using `just` and the `initialize` command.

---

## Table of Contents

- [Requirements](#requirements)
- [Project Setup](#project-setup)
- [Running the Server](#running-the-server)
- [Testing](#testing)
- [Linting and Type Checking](#linting-and-type-checking)
- [Database Migrations](#database-migrations)
- [Interactive Development in PyCharm](#interactive-development-in-pycharm)
- [Git Workflow](#git-workflow)
- [Notes](#notes)

---

## Requirements

Before setting up the project, make sure your system meets the following requirements:

- **Operating System:** macOS (Intel or Apple Silicon)
- **Python:** 3.12+  
  - Preferably installed via `pyenv` or system Python
- **Just:** [https://github.com/casey/just](https://github.com/casey/just)
- **UV (Universe):** [https://uv.dev](https://uv.dev) for dependency management
- **Docker:** for local database
  - Docker Compose should also be installed
- **Git:** for version control

---

## Project Setup

All setup steps for a new developer are automated using `just initialize`. This handles:

1. Creating a Python virtual environment in `.venv`.
2. Installing runtime dependencies.
3. Installing development dependencies (testing, linting, type checking, etc.).
4. Installing the project in **editable mode** (`pip install -e .`) so that code changes in `src/` are reflected immediately.
5. Installing PyTorch (Apple Silicon compatible if required).

### Additional Steps Before Running Tests

- Make sure Docker is running, since the project uses a local database container.
- Initialize the database and run the initial migrations (this will usually be done automatically by the first test run, but can be done manually):

```bash
# Start the database container
docker compose up -d

# Apply the initial migrations
just migrate-up
```