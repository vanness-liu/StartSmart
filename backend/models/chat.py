# models/chat.py
from pydantic import BaseModel

class ChatRequest(BaseModel):
    question: str
    industry: str 
    experience: str 
    phase: str 
    launch_time: str 
    funding: str 

class ChatResponse(BaseModel):
    answer: str
