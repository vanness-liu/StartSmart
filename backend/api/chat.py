# api/chat.py
from fastapi import APIRouter
from models.chat import ChatRequest, ChatResponse
from services.nlp import find_top_matches, find_strategic_rules
from services.gemini import decompose_query_to_questions, generate_final_response

router = APIRouter()

def build_user_context(payload: ChatRequest) -> str:
    context = []
    if payload.industry: context.append(f"Industry: {payload.industry}")
    if payload.experience: context.append(f"Experience: {payload.experience}")
    if payload.phase: context.append(f"Phase: {payload.phase}")
    if payload.launch_time: context.append(f"Launching Time: {payload.launch_time}")
    if payload.funding: context.append(f"Estimated Funding: {payload.funding}")
    return "\n".join(context)

def handle_small_talk(question: str) -> str | None:
    """Handles simple greetings and non-questions to avoid unnecessary API calls."""
    question_lower = question.lower().strip()
    word_count = len(question_lower.split())
    
    # Expanded vocabulary and better matching
    greetings = ["hello", "hi", "hey", "good morning", "good afternoon", "good evening"]
    thanks_and_positives = ["thanks", "thank you", "thx", "appreciate it", "great", "awesome", "cool", "ok", "good", "nice", "perfect", "sure", "yes", "yep", "yeah"]
    
    # Check for exact matches for single-word inputs first
    if question_lower in greetings:
        return "Hello! How can I help you with your startup idea today?"
    
    if question_lower in thanks_and_positives:
        return "You're welcome! Is there anything else I can help with?"
    
    # For short messages, allow substring match
    if word_count <= 3:
        if any(g in question_lower for g in greetings):
            return "Hello! How can I help you with your startup idea today?"
        if any(t in question_lower for t in thanks_and_positives):
            return "You're welcome! Is there anything else I can help with?"

    # For longer messages, only match if greeting/thanks is at the start
    if any(question_lower.startswith(g) for g in greetings):
        return "Hello! How can I help you with your startup idea today?"
    if any(question_lower.startswith(t) for t in thanks_and_positives):
        return "You're welcome! Is there anything else I can help with?"

    return None
        
    return None

@router.post("/chat", response_model=ChatResponse)
def chat_with_bot(payload: ChatRequest):
    # Step 1: Handle small talk
    small_talk_response = handle_small_talk(payload.question)
    if small_talk_response:
        return ChatResponse(answer=small_talk_response)

    user_context = build_user_context(payload)
    
    if len(payload.question.split()) < 3 and '?' not in payload.question:
        print(f"Question: '{payload.question}' | Identified as short input. Bypassing KB.")
        final_answer = generate_final_response(
            original_question=payload.question,
            context_rules=[], # Pass an empty list to trigger fallback
            user_profile=user_context
        )
        return ChatResponse(answer=final_answer)

    # Step 2: Single Retrieval Step - get the best match from both KBs
    top_matches = find_top_matches(payload.question)
    
    procedural_match = top_matches.get('procedural', {})
    strategic_match = top_matches.get('strategic', {})
    
    procedural_score = procedural_match.get('score', 0)
    strategic_score = strategic_match.get('score', 0)
    
    MIN_CONFIDENCE_THRESHOLD = 0.40 # Tune this value based on testing
    
    if max(procedural_score, strategic_score) < MIN_CONFIDENCE_THRESHOLD:
        print(f"Question: '{payload.question}' | Confidence too low. Bypassing KB.")
        # No relevant rule found, go directly to Gemini with a generic prompt
        final_answer = generate_final_response(
            original_question=payload.question,
            context_rules=[], # Pass an empty list
            user_profile=user_context
        )
        return ChatResponse(answer=final_answer)

    # Step 3: Intelligent Routing Logic
    # We define a threshold and a confidence margin for procedural questions
    PROCEDURAL_CONFIDENCE_THRESHOLD = 0.65
    PROCEDURAL_ROUTING_MARGIN = 0.1 

    is_procedural = (
        procedural_score > PROCEDURAL_CONFIDENCE_THRESHOLD and
        procedural_score > (strategic_score + PROCEDURAL_ROUTING_MARGIN)
    )

    aggregated_advice = set()

    if is_procedural:
        # Procedural Path
        print(f"Question: '{payload.question}' | Routed to: Procedural (Score: {procedural_score:.2f})")
        aggregated_advice.add(procedural_match['rule']['then'])
    else:
        # Strategic Path as default
        print(f"Question: '{payload.question}' | Routed to: Strategic (Score: {strategic_score:.2f})")
        # Now we decompose the query
        core_questions = decompose_query_to_questions(payload.question)
        if not core_questions: core_questions = [payload.question]
        print(f"Decomposed Strategic Questions: {core_questions}")

        # Find and aggregate advice for each sub-question from the STRATEGIC KB
        for question in core_questions:
            rules = find_strategic_rules(question, top_k=2)
            for rule in rules:
                aggregated_advice.add(rule['then'])
    
    # If no rules were found by any path, the set will be empty
    # The generate_final_response function has a fallback for this
    print(f"Aggregated Advice Context: {list(aggregated_advice)}")

    # Step 4: Generate the final response
    final_answer = generate_final_response(
        original_question=payload.question,
        context_rules=list(aggregated_advice),
        user_profile=user_context
    )

    return ChatResponse(answer=final_answer)