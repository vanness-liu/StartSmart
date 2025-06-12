# main.py
from fastapi import FastAPI
from api import chat

from fastapi.middleware.cors import CORSMiddleware
from api.v1 import api_router
from core.config import settings 

app = FastAPI(
    title="StartSmart API"
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost", "http://localhost:8080", "http://localhost:8081"], # Add Flutter dev origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(chat.router, prefix="/api", tags=["Chat"])
app.include_router(api_router.router, prefix=settings.API_V1_STR)

@app.get("/")
async def root():
    return {"message": f"Welcome to {settings.PROJECT_NAME}!"}
