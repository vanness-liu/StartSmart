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

startsmart/
├── api/                  # FastAPI endpoints
│   ├── chat.py           # Chatbot endpoint logic (main feature)
│   ├── quiz.py           # Startup readiness assessment
│   └── mentor.py         # Booking prototype
├── rules/                # Strategic & Procedural rule-based KBs
├── embeddings/           # Sentence embeddings index (BAAI model)
├── frontend/             # React frontend (not detailed here)
├── utils/                # Utility functions (decomposition, routing, etc.)
└── models/               # Pydantic schemas
