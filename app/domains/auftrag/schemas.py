from pydantic import BaseModel, ConfigDict

class AuftragCreate(BaseModel):
    name: str

class AuftragRead(BaseModel):
    id: int
    name: str
    result: float

    model_config = ConfigDict(from_attributes=True)

