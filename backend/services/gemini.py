from google import genai
import os
from dotenv import load_dotenv

load_dotenv()  # Load .env file

# Initialize client (from .env)
client = genai.Client(api_key=os.getenv("GEMINI_API_KEY"))  


def call_gemini(question: str) -> str:
    response = client.models.generate_content(
        model="gemini-2.0-flash", 
        contents=question
    )
    return response.text
