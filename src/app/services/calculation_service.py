import torch

def run_calculation()-> int | float | bool:
    # Example: simple GPU (or MPS) calculation
    device = torch.device("mps") if torch.backends.mps.is_available() else torch.device("cpu")
    x = torch.tensor([1.0, 2.0, 3.0], device=device)
    result = x.sum().item()
    return result
