# main.py
from fastapi import FastAPI
from api import chat

app = FastAPI(
    title="StartSmart API"
)

app.include_router(chat.router, prefix="/api", tags=["Chat"])
