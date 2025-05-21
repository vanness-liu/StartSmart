# backend/api/v1/api_router.py
from fastapi import APIRouter
# from .endpoints import chat, data # Example imports, create these files

router = APIRouter()
# router.include_router(chat.router, prefix="/chat", tags=["Chat"])
# router.include_router(data.router, prefix="/data", tags=["Data"])

@router.get("/health")
async def health_check():
    return {"status": "ok"}