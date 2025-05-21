# backend/main.py
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from api.v1 import api_router
from core.config import settings # We'll create this

app = FastAPI(title=settings.PROJECT_NAME, version=settings.API_VERSION)

# CORS Middleware (adjust origins as needed for development/production)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost", "http://localhost:8080"], # Add Flutter dev origins
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(api_router.router, prefix=settings.API_V1_STR)

@app.get("/")
async def root():
    return {"message": f"Welcome to {settings.PROJECT_NAME}!"}

# Initialize Firebase Admin SDK (example, adjust as per your firebase_service.py)
# import firebase_admin
# from firebase_admin import credentials
# from services.firebase_service import initialize_firebase # You'll create this
# if not firebase_admin._apps:
#     initialize_firebase()