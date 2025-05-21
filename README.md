# StartSmart

A business startup guidance expert system, featuring a Flutter frontend and a FastAPI backend.

## Setup

### Backend
1. Navigate to `backend/`.
2. Create a virtual environment: `python3 -m venv venv`
3. Activate it: `source venv/bin/activate`
4. Install dependencies: `pip install -r requirements.txt`
5. Create a `.env` file from `.env.example` and fill in your API keys.
6. Place your `firebase_credentials.json` in the `backend/` directory.
7. Run: `uvicorn main:app --reload`

### Frontend
1. Navigate to `frontend/`.
2. Ensure Flutter SDK is installed.
3. Get dependencies: `flutter pub get`
4. Run: `flutter run`