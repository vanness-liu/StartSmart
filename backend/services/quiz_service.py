from models.quiz_models import QuizEvaluationRequest, QuizEvaluationResponse

# Business Logic Maps
QUIZ_TEXT_MAP = {
    1: {"done_well": "You have a clear problem to solve", "improve": "No clear problem identification"},
    2: {"done_well": "You've identified a target audience", "improve": "Unclear target audience"},
    3: {"done_well": "You have a unique value proposition", "improve": "Lacks a clear competitive advantage"},
    4: {"done_well": "You've considered your finances", "improve": "No clear financial planning"},
    5: {"done_well": "You've considered legalities", "improve": "Unaware of legal registration steps"},
    6: {"done_well": "You have a support team/partners", "improve": "Lacks a foundational team or partners"},
    7: {"done_well": "You're thinking about IP protection", "improve": "No plan for intellectual property"},
}

SCORING_MAP = {
    # Tier 1: Critical
    1: {"Yes": 20, "Not Sure": 8, "No": 0},
    4: {"Yes": 20, "Not Sure": 8, "No": 0},
    # Tier 2: Foundational
    2: {"Yes": 14, "Not Sure": 6, "No": 0},
    3: {"Yes": 14, "Not Sure": 6, "No": 0},
    5: {"Yes": 14, "Not Sure": 6, "No": 0},
    # Tier 3: Good Practice
    6: {"Yes": 9, "Not Sure": 4, "No": 0},
    7: {"Yes": 9, "Not Sure": 4, "No": 0},
}

def get_title_for_score(score: int) -> str:
    """Selects a motivational title based on the final score."""
    if score >= 85:
        return "Ready for liftoff! 🚀"
    elif score >= 65:
        return "Strong Foundation Here!"
    elif score >= 40:
        return "Just a bit more prep!"
    else:
        return "Start building your blueprint!"

def calculate_readiness_score(request: QuizEvaluationRequest) -> QuizEvaluationResponse:
    """
    Calculates the startup readiness score based on user answers.
    This function contains the core business logic.
    """
    total_score = 0
    done_well_list = []
    areas_to_improve_list = []

    for item in request.answers:
        question_id = item.question_id
        answer = item.answer

        if question_id in SCORING_MAP and answer in SCORING_MAP[question_id]:
            total_score += SCORING_MAP[question_id][answer]

        if answer == "Yes":
            done_well_list.append(QUIZ_TEXT_MAP[question_id]["done_well"])
        else: # "No" or "Not Sure"
            areas_to_improve_list.append(QUIZ_TEXT_MAP[question_id]["improve"])
            
    title = get_title_for_score(total_score)
    
    return QuizEvaluationResponse(
        title=title,
        score=total_score,
        done_well=done_well_list,
        areas_to_improve=areas_to_improve_list
    )