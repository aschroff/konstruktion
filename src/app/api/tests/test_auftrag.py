import pytest
from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)


@pytest.fixture
def auftrag_payload() -> dict[str, str]:
    return {"name": "Testauftrag"}


def test_create_and_get_auftrag(auftrag_payload: dict) -> None:
    # Create Auftrag
    response = client.post("/api/auftrag", json=auftrag_payload)
    assert response.status_code == 200, f"Create failed: {response.text}"
    data = response.json()
    assert "id" in data
    assert data["result"] is not None
    auftrag_id = data["id"]

    # Get Auftrag
    response = client.get(f"/api/auftrag/{auftrag_id}")
    assert response.status_code == 200, f"Get failed: {response.text}"
    data2 = response.json()
    assert data2["id"] == auftrag_id
    assert data2["name"] == auftrag_payload["name"]
    assert data2["result"] == data["result"]
