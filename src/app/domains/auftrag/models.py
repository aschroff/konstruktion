from sqlalchemy import Column, Integer, String, Float
from app.database.session import Base


class Auftrag(Base):
    __tablename__ = "auftraege"

    id = Column(Integer, primary_key=True, index=True)
    name = Column(String, nullable=False)
    result = Column(Float, nullable=True)
