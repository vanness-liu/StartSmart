# services/gemini.py
import google.generativeai as genai
import os
import json
from dotenv import load_dotenv

load_dotenv()  # Load .env file

# Initialize client (from .env)
client = genai.configure(api_key=os.getenv("GEMINI_API_KEY")) 

# Define a consistent generation config
GENERATION_CONFIG = genai.types.GenerationConfig(temperature=0.2)

def decompose_query_to_questions(query: str) -> list[str]:
    """Uses Gemini to break a complex user query into simple, distinct questions."""
    model = genai.GenerativeModel("gemini-1.5-flash")
    
    prompt = (
        f"Analyze the following user query about starting a business. "
        f"Identify the core, distinct problems or questions the user is asking. "
        f"Frame each one as a problem statement or a direct question. " 
        f"Return the output as a JSON-formatted list of strings. "
        f"If there is only one problem, return it in the list. "
        f"If the query is not a question or is just small talk, return an empty list. "
        f"Query: \"{query}\"\n\n"
        f"Example: For 'How do I register a business and get funding?', you should return: [\"how to register a business\", \"how to get funding for a startup\"]"
    )
    
    try:
        response = model.generate_content(prompt, generation_config=GENERATION_CONFIG)
        # Clean the response to extract the JSON list
        cleaned_response = response.text.strip().replace("```json", "").replace("```", "")
        questions = json.loads(cleaned_response)
        if isinstance(questions, list):
            return questions
        return [query] # Fallback if parsing fails but we have text
    except (json.JSONDecodeError, Exception) as e:
        print(f"Gemini decomposition error: {e}")
        # If decomposition fails, treat the original query as the single question
        return [query]

def generate_final_response(original_question: str, context_rules: list[str], user_profile: str) -> str:
    """Uses Gemini to synthesize advice from rules into a personalized answer."""
    model = genai.GenerativeModel("gemini-1.5-flash")
    
    formatting_instruction = (
        "Structure the response for maximum clarity and readability. "
        "Use short paragraphs and bullet points where appropriate. "
        "Do not use markdown like '#' or '*'. Instead of asterisks for bullet points, use a simple dash '-'. "
        "DO NOT USE MARKDOWN FORMATTING LIKE BOLD OR ITALICS IN THE RESPONSE ESPECIALLY NO * AT ALL"
        "Keep the overall response concise and to the point."
        "If possible, make it short and not too long to read, but still informative."
    )
    
    if not context_rules:
        # Fallback prompt if no relevant rules were found (or confidence was too low)
        prompt = (
            f"You are a startup expert chatbot. The user said something that is either off-topic or unclear. "
            f"Respond conversationally. If it seems like a question, try to provide a helpful answer. "
            f"If it's not a question, respond politely. Use their profile for context if helpful.\n\n"
            f"User's Message: \"{original_question}\"\n\n"
            f"User Profile:\n{user_profile}\n\n"
            f"Instructions: {formatting_instruction}"
        )
    else:
        # Main prompt using the retrieved rules
        advice_context = "\n- ".join(context_rules)
        prompt = (
            f"As a startup expert, use the following pieces of advice to construct a helpful, concise, and personalized answer to the user's question. "
            f"Synthesize the advice into a cohesive response, do not just list the rules.\n\n"
            f"User's Question: \"{original_question}\"\n\n"
            f"Relevant Advice to Use:\n- {advice_context}\n\n"
            f"User Profile:\n{user_profile}\n\n"
            f"Instructions: {formatting_instruction} Do not mention the user's profile in the answer, but use it to make the tone and examples more relevant."
        )

    try:
        response = model.generate_content(prompt, generation_config=GENERATION_CONFIG)
        return response.text.strip()
    except Exception as e:
        print(f"Gemini generation error: {e}")
        return "I'm having trouble formulating a response right now. Please try again. :)"
    
# def call_gemini(question: str) -> str:
#     try:
#         model = genai.GenerativeModel("gemini-1.5-flash")
#         response = model.generate_content(question)
#         return response.text
#     except Exception as e:
#         print(f"Gemini error: {e}")
#         return "Error: Could not get response from Gemini."