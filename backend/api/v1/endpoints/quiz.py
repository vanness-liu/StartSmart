from fastapi import APIRouter
from models.quiz_models import QuizEvaluationRequest, QuizEvaluationResponse
from services.quiz_service import calculate_readiness_score

router = APIRouter()

@router.post(
    "/evaluate", 
    response_model=QuizEvaluationResponse, 
    tags=["Quiz"]
)
def evaluate_quiz(request: QuizEvaluationRequest):
    """
    Receives quiz answers and returns a readiness score and feedback.
    """
    # The API layer's only job is to delegate to the service layer.
    return calculate_readiness_score(request)