# api/chat.py
from fastapi import APIRouter
from models.chat import ChatRequest, ChatResponse
from services.nlp import find_best_rule
from services.gemini import call_gemini

def build_user_context(payload):
    context = []
    if payload.industry:
        context.append(f"Industry: {payload.industry}")
    if payload.experience:
        context.append(f"Experience: {payload.experience}")
    if payload.phase:
        context.append(f"Phase: {payload.phase}")
    if payload.launch_time:
        context.append(f"Launching Time: {payload.launch_time}")
    if payload.funding:
        context.append(f"Estimated Funding: {payload.funding}")
    return "\n".join(context)

router = APIRouter()

@router.post("/chat", response_model=ChatResponse)
def chat_with_bot(payload: ChatRequest):
    rule, score = find_best_rule(payload.question)
    print(f"Question: {payload.question}, Best Rule: {rule}, Score: {score}")

    user_context = build_user_context(payload)

    if score < 0.45:
        # Fallback to Gemini with personalization
        prompt = (
            f"Write a expert advice into a short and precise, and helpful sentence for a person who want to do a startup business:\n"
            f"Question: \"{payload.question}\"\n\n"
            f"User Profile:\n{user_context}\n\n"
            "Please dont mention the user profile in the answer, just use it to personalize the answer."
            "Don't use markdown formatting in the answer."
        )
        answer = call_gemini(question=prompt)

    else:
        # Rule matched: use Gemini to rewrite and personalize
        raw_answer = rule.split("THEN")[1].strip()
        prompt = (
            f"Rewrite the following expert advice into a short and precise, and helpful sentence for a person who want to do a startup business:\n"
            f"Question: \"{payload.question}\"\n\n"
            f"Advice: \"{raw_answer}\"\n\n"
            f"User Profile:\n{user_context}\n\n"
            "Please dont mention the user profile in the answer, just use it to personalize the answer."
            "Don't use markdown formatting in the answer."
        )
        answer = call_gemini(question=prompt)

    return ChatResponse(answer=answer)
