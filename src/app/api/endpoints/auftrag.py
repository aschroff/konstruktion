from typing import Generator

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from database.session import SessionLocal
from domains.auftrag.context_boundary import get_auftrag_by_id, AuftragCreate, AuftragRead
from services.calculation_service import run_calculation
from domains.auftrag import create_auftrag
from domains.auftrag.models import Auftrag

router = APIRouter()

# Dependency
def get_db()-> Generator[Session, None, None]:
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/auftrag", response_model=AuftragRead)
def create_endpoint(auftrag: AuftragCreate, db: Session = Depends(get_db))-> Auftrag:
    result = run_calculation()
    db_obj = create_auftrag(db, auftrag, result)
    return db_obj


@router.get("/auftrag/{auftrag_id}", response_model=AuftragRead)
def read_endpoint(auftrag_id: int, db: Session = Depends(get_db))-> Auftrag:
    db_obj = get_auftrag_by_id(db, auftrag_id)  # call via context_boundary
    if not db_obj:
        raise HTTPException(status_code=404, detail="Auftrag not found")
    return db_obj
