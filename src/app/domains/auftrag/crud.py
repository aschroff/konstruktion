from sqlalchemy.orm import Session

from .models import Auftrag
from .schemas import AuftragCreate


def create_auftrag(db: Session, auftrag: AuftragCreate, result: float) -> Auftrag:
    db_obj = Auftrag(name=auftrag.name, result=result)
    db.add(db_obj)
    db.commit()
    db.refresh(db_obj)
    return db_obj


def get_auftrag_by_id(db: Session, auftrag_id: int) -> Auftrag | None:
    return db.query(Auftrag).filter(Auftrag.id == auftrag_id).first()
