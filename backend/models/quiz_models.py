from pydantic import BaseModel
from typing import List

# Quiz Request Models
class QuizAnswer(BaseModel):
    """Represents a single answer from the frontend."""
    question_id: int
    answer: str  # "Yes", "No", "Not Sure"

class QuizEvaluationRequest(BaseModel):
    """The request body for the quiz evaluation endpoint."""
    answers: List[QuizAnswer]


# Quiz Response Models
class QuizEvaluationResponse(BaseModel):
    """The response body sent back to the frontend after evaluation."""
    title: str
    score: int
    done_well: List[str]
    areas_to_improve: List[str]