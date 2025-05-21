# StartSmart 🚀

A business startup guidance expert system, featuring a Flutter frontend and a FastAPI backend.
This project aims to provide aspiring entrepreneurs with intelligent tools and resources to navigate the complexities of starting and growing a business.

## ✨ Features (Planned/Included)

*   **Flutter Frontend:** Intuitive and responsive user interface for accessing guidance.
*   **FastAPI Backend:** Robust and scalable API server.
*   **Firebase Firestore Integration:** Secure and real-time data storage.
*   **Google Gemini API:** Advanced AI capabilities for expert advice and content generation.
*   **Text Embedding Models:** For semantic search, similarity analysis, and other NLP tasks.

## 🛠️ Tech Stack

*   **Frontend:** Flutter (Dart)
*   **Backend:** FastAPI (Python 3.9+)
*   **Database:** Firebase Firestore
*   **AI Services:** Google Gemini API
*   **NLP:** Text Embedding Libraries (e.g., Sentence Transformers, OpenAI Embeddings)
*   **Environment Management (Backend):** Python `venv`
*   **Version Control:** Git & GitHub

## 📂 Project Structure

This project is a monorepo containing:

StartSmart/
├── backend/ # FastAPI Python backend
│ ├── api/ # API endpoints (routers)
│ ├── core/ # Core settings, configurations
│ ├── models/ # Pydantic schemas
│ ├── services/ # Business logic, external API integrations (Firebase, Gemini)
│ ├── .env # Local environment variables (Gitignored)
│ ├── .env.example # Template for .env
│ ├── firebase_credentials.json # Firebase Admin SDK key (Gitignored)
│ ├── main.py # Main FastAPI application
│ └── requirements.txt
├── frontend/ # Flutter application
│ ├── lib/
│ └── pubspec.yaml
├── .gitignore
└── README.md

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### Prerequisites

Ensure you have the following installed on your system:

*   [Python](https://www.python.org/downloads/) (3.9+ recommended) & `pip`
*   [Flutter SDK](https://docs.flutter.dev/get-started/install) (latest stable version recommended)
*   [Git](https://git-scm.com/downloads/)
*   An IDE or Text Editor (e.g., VS Code, Android Studio, IntelliJ IDEA)

### Installation & Setup

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/StartSmart.git # Replace with your repo URL
    cd StartSmart
    ```

2.  **Backend Setup:**
    *   Navigate to the backend directory:
        ```bash
        cd backend
        ```
    *   Create and activate a Python virtual environment:
        ```bash
        python3 -m venv venv
        source venv/bin/activate   # On macOS/Linux
        # venv\Scripts\activate    # On Windows
        ```
    *   Install Python dependencies:
        ```bash
        pip install -r requirements.txt
        ```
    *   Set up environment variables:
        *   Copy the example environment file:
            ```bash
            cp .env.example .env
            ```
        *   Open `backend/.env` and fill in your actual API keys (e.g., `GEMINI_API_KEY`).
    *   Set up Firebase:
        *   Download your `firebase_credentials.json` file from your Firebase project settings (Project settings > Service accounts > Generate new private key).
        *   Place the `firebase_credentials.json` file directly into the `backend/` directory.
        *   Ensure the `FIREBASE_CREDENTIALS_PATH` in your `backend/.env` (or `backend/core/config.py`) correctly points to this file (e.g., `"firebase_credentials.json"` if it's in the same directory as `main.py`, or an absolute/relative path).

3.  **Frontend Setup:**
    *   Navigate to the frontend directory (from the project root):
        ```bash
        cd frontend
        # Or if you are in backend/: cd ../frontend
        ```
    *   Get Flutter dependencies:
        ```bash
        flutter pub get
        ```

## 💨 Running the Application

### 1. Start the Backend Server

*   Navigate to the `backend/` directory.
*   Ensure your Python virtual environment (`venv`) is activated.
*   Run the FastAPI application using Uvicorn:
    ```bash
    uvicorn main:app --reload
    ```
    The backend API will typically be available at `http://127.0.0.1:8000`. You can check `http://127.0.0.1:8000/docs` for the auto-generated API documentation.

### 2. Run the Frontend Application

*   Navigate to the `frontend/` directory.
*   Ensure you have an emulator running or a physical device connected and recognized by Flutter (`flutter devices`).
*   Run the Flutter application:
    ```bash
    flutter run
    ```
    The Flutter app will build and launch on your selected device/emulator. It should be configured to communicate with the local backend server.

## 🧑🏻‍💻 With Dedication from Team BizMind
1. Lee Shin Yen
2. Teoh Min Zi
3. Tan Yi Rou
4. Ong Zhao Qian
5. Vanness Liu Chuen Wei