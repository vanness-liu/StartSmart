# backend/core/config.py
from pydantic_settings import BaseSettings
from dotenv import load_dotenv
import os

load_dotenv() # Load .env file

class Settings(BaseSettings):
    PROJECT_NAME: str = "StartSmart API"
    API_VERSION: str = "0.1.0"
    API_V1_STR: str = "/api/v1"

    FIREBASE_CREDENTIALS_PATH: str = os.getenv("FIREBASE_CREDENTIALS_PATH", "firebase_credentials.json")
    GEMINI_API_KEY: str = os.getenv("GEMINI_API_KEY", "YOUR_GEMINI_API_KEY")
    # Add other environment variables as needed

    class Config:
        case_sensitive = True

settings = Settings()