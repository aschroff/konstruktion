from fastapi import FastAPI
from api.endpoints import auftrag

app = FastAPI()

app.include_router(auftrag.router, prefix="/api")
