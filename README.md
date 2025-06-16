# 🚀 StartSmart

**StartSmart** is a business startup guidance expert system tailored to empower university students with entrepreneurial ideas. Many young entrepreneurs struggle with turning their ideas into viable businesses due to a lack of structured guidance, validation tools, and reliable mentorship. StartSmart aims to bridge that gap.

---

## 🧠 Problem Statement

Youths often have promising entrepreneurial ideas but lack:
- Proper guidance
- Planning and validation tools
- Mentorship on business strategy

This often leads to uninformed decisions and startup failures.

---

## 🎯 Objectives

To develop an **affordable and user-friendly rule-based expert system** that:
- Simulates the role of a business mentor
- Provides reliable, expert-level guidance for startup planning
- Helps student entrepreneurs make informed decisions on:
  - Business ideation
  - Legal structures
  - Funding options
  - Marketing strategies

---

## 💡 Key Features

1. **📚 FAQ Knowledge Bank**
   - Curated startup-related questions and answers for self-exploration.

2. **🤖 Chatbot Assistant (Core Feature)**
   - A Retrieval-Augmented Generation (RAG)-style system using rule-based logic.
   - Matches your queries to the internal knowledge base for expert-like advice.
   - Uses `BAAI/bge-small-en-v1.5` for text embedding (no OpenAI embeddings used).

3. **🧪 Startup Readiness Quiz**
   - An assessment tool to help users gauge their entrepreneurial readiness.

4. **📅 Mentor Booking System (Prototype)**
   - A prototype interface for connecting with startup mentors (development in progress).

---

## 🏗️ Project Structure

```
StartSmart/ <br>
├── backend/ # FastAPI Python backend 
│ ├── api/ # API endpoints (routers)
│ ├── core/ # Core settings, configurations
│ ├── models/ # Pydantic schemas 
│ ├── services/ # Business logic, external API integrations (Firebase, Gemini)
│ ├── .env # Local environment variables (Gitignored)
│ ├── firebase_credentials.json # Firebase Admin SDK key (Gitignored) 
│ ├── main.py # Main FastAPI application 
│ └── requirements.txt 
├── frontend/ # Flutter application 
│ ├── lib/ 
│ └── pubspec.yaml 
├── .gitignore 
└── README.md 
```


---

## 🛠️ Technologies Used

- **Backend**: Python, FastAPI
- **Frontend**: Flutter (Dart)
- **AI Services**: Google Gemini API
- **Embeddings**: [`BAAI/bge-small-en-v1.5`](https://huggingface.co/BAAI/bge-small-en-v1.5)
- **Storage**: Firebase Console

---

## 🔮 Future Improvements

- Full implementation of mentor scheduling and chat
- Integrate more dynamic feedback into the quiz module
- Support multi-language content
- Expand knowledge base with expert-verified content
- Add analytics dashboard for mentor and startup insights

---

## 🧑‍💼 Target Users

- University students with startup ideas
- First-time entrepreneurs seeking structured guidance
- Incubators or universities supporting student ventures

---

## 📌 Getting Started

Pre-requisites: Ensure that you have Flutter downloaded and Gemini API Key setup in .env of /backend!

1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/startsmart.git
   cd startsmart
2. Install dependencies:
   ```bash
   cd backend
   pip install -r requirements.txt
4. Run the app simultaneously:

   - Frontend:
  ```bash
  cd frontend
  flutter pub get
  flutter run
  ```

   - Backend:
   ```bash
   cd backend
   python3 -m venv venv
   source venv/bin/activate   # macOS/Linux
   # venv\Scripts\activate    # On Windows
   uvicorn main:app --reload
   ```

## 🤝 Contributors

Team BizMind
1. Teoh Min Zi
2. Vanness Liu Chuen Wei
3. Ong Zhao Qian
4. Tan Yi Rou
5. Lee Shin Yen
