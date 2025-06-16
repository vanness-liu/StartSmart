# services/nlp.py
from sentence_transformers import SentenceTransformer, util
from .knowledge_base import STRATEGIC_KB, PROCEDURAL_KB

model = SentenceTransformer('BAAI/bge-small-en-v1.5')

# Instruction prompt for BGE-style models
def format_input(text: str) -> str:
    return f"Represent this sentence for semantic similarity: {text}"

# Create embeddings for both KBs
strategic_if_conditions = [format_input(rule['if']) for rule in STRATEGIC_KB]
procedural_if_conditions = [format_input(rule['if']) for rule in PROCEDURAL_KB]

strategic_embeddings = model.encode(strategic_if_conditions, convert_to_tensor=True, normalize_embeddings=True)
procedural_embeddings = model.encode(procedural_if_conditions, convert_to_tensor=True, normalize_embeddings=True)

print("Strategic and Procedural KB embeddings loaded.")

def find_top_matches(question: str) -> dict:
    """
    Finds the single best match from BOTH the strategic and procedural KBs
    and returns them along with their scores for routing.
    """
    if not question.strip():
        return {}

    # Format the question for the model
    formatted_question = format_input(question)
    question_embedding = model.encode(formatted_question, convert_to_tensor=True, normalize_embeddings=True)

    # Search Strategic KB
    strategic_scores = util.cos_sim(question_embedding, strategic_embeddings)[0]
    top_strategic_idx = strategic_scores.argmax().item()
    top_strategic_score = strategic_scores[top_strategic_idx].item()
    top_strategic_rule = STRATEGIC_KB[top_strategic_idx]

    # Search Procedural KB
    procedural_scores = util.cos_sim(question_embedding, procedural_embeddings)[0]
    top_procedural_idx = procedural_scores.argmax().item()
    top_procedural_score = procedural_scores[top_procedural_idx].item()
    top_procedural_rule = PROCEDURAL_KB[top_procedural_idx]

    return {
        'strategic': {'rule': top_strategic_rule, 'score': top_strategic_score},
        'procedural': {'rule': top_procedural_rule, 'score': top_procedural_score}
    }

def find_strategic_rules(question: str, top_k: int = 2, min_score: float = 0.45):
    """
    Finds the top_k rules specifically from the STRATEGIC_KB.
    Used after decomposition in the strategic path.
    """
    if not question.strip():
        return []
    
    formatted_question = format_input(question)
    question_embedding = model.encode(formatted_question, convert_to_tensor=True, normalize_embeddings=True)

    # Compute cosine similarity scores
    scores = util.cos_sim(question_embedding, strategic_embeddings)[0]
    top_results = scores.topk(min(top_k, len(STRATEGIC_KB)))

    matched_rules = []
    for i in range(len(top_results.values)):
        score = top_results.values[i].item()
        if score >= min_score:
            rule_index = top_results.indices[i].item()
            matched_rule = STRATEGIC_KB[rule_index]
            matched_rule['score'] = score 
            matched_rules.append(matched_rule)
    
    return matched_rules