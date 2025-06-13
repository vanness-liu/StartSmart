import google.generativeai as genai
import os
from dotenv import load_dotenv

load_dotenv()  # Load .env file

# Initialize client (from .env)
client = genai.configure(api_key=os.getenv("GEMINI_API_KEY"))  


def call_gemini(question: str) -> str:
    try:
        model = genai.GenerativeModel("gemini-1.5-flash")
        response = model.generate_content(question)
        return response.text
    except Exception as e:
        print(f"Gemini error: {e}")
        return "Error: Could not get response from Gemini."