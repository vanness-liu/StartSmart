# backend/api/v1/api_router.py
from fastapi import APIRouter
from api.v1.endpoints import quiz

router = APIRouter()

router.include_router(quiz.router, prefix="/quiz")

@router.get("/health")
async def health_check():
    return {"status": "ok"}