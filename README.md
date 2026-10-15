# ReviewIQ AI — AI-Based Product Review Analysis Using NLP

> **Subtitle:** Aspect-Based Sentiment Analysis of Customer Reviews  
> **Tagline:** *Turn Customer Opinions into Actionable Intelligence.*

---

## 1. Project Overview

**ReviewIQ AI** is a production-grade, college-level full-stack AI/ML application that solves a fundamental limitation of traditional sentiment analysis.

Standard sentiment analysis models classify an entire review as either strictly **Positive**, **Negative**, or **Neutral**. For example, in a review such as:
> *"The camera is excellent and the display looks beautiful, but the battery drains quickly and the price is too high."*

A traditional model assigns a single conflicting score, losing critical product intelligence. **ReviewIQ AI** decomposes customer reviews into individual aspects:
- **Camera:** Positive
- **Display:** Positive
- **Battery:** Negative
- **Price:** Negative
- **Overall Sentiment:** Mixed

This allows product managers, hardware engineers, and prospective buyers to pinpoint exact feature praise and critical complaints without manually reading hundreds of reviews.

---

## 2. Key Capabilities & Modules

1. **Review Analyzer:** Real-time single review analysis with clause segmentation, aspect extraction, confidence scores, and explainable evidence.
2. **Bulk CSV Analysis:** High-throughput processing of CSV files containing customer feedback, with interactive summaries and downloadable aspect-level CSV exports.
3. **Product Catalog & Detail View:** Comprehensive catalog of 5 fictional smartphone devices with aggregated aspect sentiment scores.
4. **Aspect Analytics:** In-depth metrics across 12 canonical hardware/software aspects, with sentiment distributions and representative customer quotes.
5. **Product Comparison Matrix:** Side-by-side multi-device comparison with aspect satisfaction radar/bar charts.
6. **Complaint Discovery Engine:** Automated triage of negative customer experiences, grouped by aspect and device.
7. **Model Evaluation:** Genuine scikit-learn statistical evaluation (Accuracy, Macro Precision, Recall, F1-Score, and Confusion Matrix) on a held-out test split.
8. **Dataset Management & Provenance:** Full disclosure and provenance of synthetic demo data (`source_type = "synthetic_demo"`), review counts per product, and custom dataset importing.
9. **Authentication & History Isolation:** Secure registration, bcrypt password hashing, JWT bearer tokens, and private user analysis history.
10. **Liquid Glass UI & Dual Theme:** Glassmorphism aesthetic with Dark Mode, Light Mode, and System Default, with mobile/tablet responsive navigation.

---

## 3. Technology Stack

### Frontend
- **Framework:** React 18, Vite, TypeScript
- **Styling:** Tailwind CSS with Liquid Glass design tokens
- **Data Visualizations:** Recharts (Bar Charts, Donut Charts, Stacked Comparisons)
- **Icons:** Lucide React
- **Routing:** React Router v6
- **HTTP Client:** Axios with JWT request interceptors

### Backend & Database
- **API Framework:** Python 3.11, FastAPI
- **ORM & Data Modeling:** SQLAlchemy 2.0
- **Database:** SQLite (default with zero-configuration file `reviewiq.db`) / PostgreSQL compatible
- **Authentication:** Bcrypt password hashing, PyJWT / Python-Jose (HS256)
- **Server:** Uvicorn ASGI

### AI, Machine Learning & NLP
- **Text Preprocessing:** Regular expression clause segmentation, contraction expansion, tokenization, negation scope detection.
- **Aspect Extraction:** Canonical rule-augmented lexicon supporting 12 aspects with phrase patterns.
- **Classification:** Scikit-Learn TF-IDF N-gram feature extraction (1-2 ngrams, sublinear TF) + Calibrated Logistic Regression with class balancing.
- **Data Manipulation:** NumPy, pandas
- **Model Serialization:** Joblib

### Testing
- **Test Framework:** Pytest with FastAPI TestClient and in-memory SQLite (`StaticPool`)

---

## 4. NLP Methodology & Aspect Extraction Pipeline

```
[Raw Customer Review]
         │
         ▼
[1. Text Sanitization & Contraction Expansion] ("didn't" -> "did not", etc.)
         │
         ▼
[2. Contrastive Clause Segmentation] (Splits on "but", "however", "although", ";")
         │
         ├─── Clause 1: "The camera is excellent and display looks beautiful"
         │       ├─ Matched Aspects: Camera, Display
         │       ├─ Sentiment Keywords: "excellent", "beautiful"
         │       └─ Classification: Camera (Positive), Display (Positive)
         │
         └─── Clause 2: "the battery drains quickly and price is too high"
                 ├─ Matched Aspects: Battery, Price
                 ├─ Sentiment Keywords: "drains", "too high"
                 └─ Classification: Battery (Negative), Price (Negative)
         │
         ▼
[3. Negation Resolution] ("not bad" -> Positive/Neutral; "fails to" -> Negative)
         │
         ▼
[4. Model Confidence Calibration] (Platt scaling & class probability)
         │
         ▼
[5. Multi-Aspect Aggregation] (Positive + Negative -> "Mixed" Overall Sentiment)
```

### Supported Aspects (12 Canonical Categories)
1. **Camera** (optics, zoom, night mode, selfies, portrait, sensors, video recording)
2. **Battery** (battery life, endurance, backup, SOT, screen-on-time, drain)
3. **Display** (OLED, AMOLED, refresh rate, 120Hz, brightness, colors, resolution)
4. **Performance** (speed, lag, processor, chipset, gaming, multitasking, thermals)
5. **Price** (cost, expensive, overpriced, affordable, value for money, budget)
6. **Design** (look and feel, aesthetics, slim, form factor, ergonomics, styling)
7. **Build Quality** (materials, titanium, aluminum, craftsmanship, rigidity, frame)
8. **Audio and Speakers** (stereo speakers, volume, sound, clarity, microphone, Dolby)
9. **Software and User Interface** (OS, clean UI, bloatware, updates, bugs, skin)
10. **Connectivity** (Wi-Fi, 5G, Bluetooth range, cellular reception, GPS)
11. **Charging** (fast charging, 120W, charger in box, wireless charging, charge speed)
12. **Durability** (water resistance, IP68, drop protection, scratch resistance, Gorilla Glass)

---

## 5. Dataset Provenance & Demonstration Products

The demonstration dataset located at `data/sample_reviews.csv` contains **120 distinct reviews** (24 reviews per device) across 5 fictional smartphone models:

1. **Nova X Pro** (Flagship Smartphone)
2. **PixelWave 9** (AI Camera Phone)
3. **GalaxySphere S25** (Productivity Flagship)
4. **iFruit 17** (Luxury Flagship)
5. **OneMax Ultra** (Performance Flagship)

> **Ethical AI Notice:** All demonstration reviews are synthetically generated for academic demonstration and tagged with `source_type = "synthetic_demo"`. They do not represent real-world customer opinions or commercial trademarks.

---

## 6. Project Directory Structure

```
nlp mini/
├── backend/
│   ├── app/
│   │   ├── api/             # REST endpoints (auth, products, analyze, analytics, dataset, model)
│   │   ├── core/            # Config, security, JWT, bcrypt
│   │   ├── database/        # SQLAlchemy engine, sessionmaker, Base
│   │   ├── models/          # Entities (User, Product, Review, ReviewAnalysis, AspectResult)
│   │   ├── schemas/         # Pydantic v2 schemas
│   │   ├── nlp/             # Preprocessor, AspectExtractor, SentimentClassifier, NLPPipeline, Evaluator
│   │   └── main.py          # FastAPI application entrypoint & CORS
│   ├── scripts/
│   │   ├── generate_datasets.py  # Generates 120 reviews CSV & training data
│   │   └── seed_database.py      # Idempotent database seeder with live NLP analysis
│   ├── tests/               # 19 automated pytest tests (auth, nlp, dataset, analytics)
│   └── requirements.txt     # Python backend dependencies
├── frontend/
│   ├── src/
│   │   ├── components/      # GlassCard, SentimentBadge, StatCard, Modal, Navbar, Sidebar, Footer
│   │   ├── context/         # AuthContext, ThemeContext
│   │   ├── pages/           # 13 application views (Dashboard, Analyzer, Bulk, Products, etc.)
│   │   ├── services/        # Axios API client with bearer token interceptor
│   │   ├── types/           # TypeScript domain interfaces
│   │   ├── index.css        # Liquid glass design system & Tailwind layers
│   │   ├── App.tsx          # Router configuration
│   │   └── main.tsx         # React entrypoint
│   ├── package.json         # React 18, Vite, Tailwind, Recharts, Lucide
│   └── vite.config.ts       # Vite configuration with proxy to FastAPI
├── data/
│   ├── sample_reviews.csv   # 120 synthetic smartphone reviews
│   └── training/
│       └── aspect_sentiment_train.csv  # Labeled aspect training clauses
├── run_backend.bat          # 1-click Windows runner for FastAPI backend
├── run_frontend.bat         # 1-click Windows runner for Vite frontend
├── seed_data.bat            # 1-click Windows database seeder
├── run_tests.bat            # 1-click Windows automated test runner
├── .env.example             # Sample configuration
└── README.md                # Comprehensive documentation
```

---

## 7. Windows Setup & Run Instructions

### Prerequisites
1. **Python 3.11** (Installed and accessible)
2. **Node.js v18+ and npm** (Installed and accessible)

### Step 1: Install Backend Dependencies
Open PowerShell or Command Prompt in the project root:
```powershell
pip install -r backend/requirements.txt
```

### Step 2: Seed the Database
Run the idempotent database seeder to populate the 5 sample products, 120 reviews, and analyze all reviews with the NLP engine:
```powershell
python backend/scripts/seed_database.py
```
*(Or double-click `seed_data.bat` on Windows)*

### Step 3: Install Frontend Dependencies
```powershell
cd frontend
npm install
cd ..
```

### Step 4: Start the Backend Server
```powershell
python -m uvicorn app.main:app --app-dir backend --host 127.0.0.1 --port 8000 --reload
```
*(Or double-click `run_backend.bat`)*  
Backend will be available at: **http://127.0.0.1:8000**  
Interactive Swagger API Docs: **http://127.0.0.1:8000/docs**

### Step 5: Start the Frontend Application
In a second terminal window:
```powershell
cd frontend
npm run dev -- --host 127.0.0.1
```
*(Or double-click `run_frontend.bat`)*  
Frontend will be available at: **http://localhost:3000** (or **http://127.0.0.1:3000**)

---

## 8. Automated Testing

To run the automated test suite covering authentication, NLP aspect detection, negation handling, dataset integrity, and dashboard calculations:
```powershell
python -m pytest backend/tests -v
```
*(Or double-click `run_tests.bat`)*

**Test Suite Results:**
- `test_analytics.py`: 4 passed (Empty DB, Seeded DB, Product Comparison, Model Evaluation)
- `test_auth.py`: 6 passed (Registration, Duplicate Email, Login, Invalid Credentials, Me Endpoint, History Isolation)
- `test_dataset.py`: 2 passed (120 Reviews Format, 20 Reviews/Product, Training Data)
- `test_nlp.py`: 7 passed (Preprocessing, Aspect Coverage, Positive, Negative, Negation, Multi-Aspect Mixed, Empty Input)
- **Total:** 19 passed (100% success rate).

---

## 9. Default Demo Account Credentials

For instant demonstration and testing of authenticated review saving and user history isolation:
- **Email:** `demo@reviewiq.ai`
- **Password:** `DemoPassword123!`

*(You can also click the quick **"⚡ Fill Demo Account Credentials"** button on the Login page, or register a new user account with unique credentials.)*

---

## 10. REST API Documentation Summary

| Method | Endpoint | Description | Auth Required |
|---|---|---|---|
| `POST` | `/api/auth/register` | Register new user account | No |
| `POST` | `/api/auth/login` | Authenticate user & return JWT token | No |
| `POST` | `/api/auth/logout` | Invalidate session | Yes |
| `GET` | `/api/auth/me` | Fetch authenticated user profile | Yes |
| `GET` | `/api/products` | List products with computed review metrics | No |
| `GET` | `/api/products/{id}` | Product details & aspect sentiment split | No |
| `POST` | `/api/products` | Add new product to catalog | No |
| `POST` | `/api/analyze` | Run real-time aspect sentiment analysis | Optional (for history) |
| `POST` | `/api/analyze/bulk` | Analyze uploaded CSV review dataset | No |
| `GET` | `/api/analyze/history`| Fetch user's private saved analyses | Yes |
| `DELETE`| `/api/analyze/{id}` | Delete saved analysis from user history | Yes |
| `GET` | `/api/analytics/dashboard`| Aggregate dashboard metrics & distributions | No |
| `GET` | `/api/analytics/aspects` | Aspect mention frequencies & quotes | No |
| `GET` | `/api/analytics/compare` | Multi-product aspect satisfaction comparison | No |
| `GET` | `/api/analytics/complaints`| Complaint discovery & problem triage | No |
| `GET` | `/api/model/info` | Architecture details & pipeline stages | No |
| `GET` | `/api/model/evaluation`| Live scikit-learn evaluation metrics | No |
| `GET` | `/api/dataset/summary` | Dataset provenance & review counts | No |
| `GET` | `/api/dataset/sample-download`| Download `sample_reviews.csv` | No |
| `POST` | `/api/dataset/upload` | Import custom CSV into database | No |

---

## 11. Academic Evaluation & Demonstration Guide

When presenting this project for an evaluation, viva, or demonstration:

1. **Demonstrate the Benchmark Review:**
   Go to the **Review Analyzer** (`/analyzer`), select the quick preset *"Mixed Flagship"*, and click **Analyze Review**. Show how the review:
   > *"The camera is excellent and the display looks beautiful, but the battery drains quickly and the price is too high."*
   is split into:
   - Camera: **Positive** (92% conf)
   - Display: **Positive** (92% conf)
   - Battery: **Negative** (92% conf)
   - Price: **Negative** (92% conf)
   - Overall: **Mixed**

2. **Demonstrate Negation Handling:**
   Select the *"Negation Handling"* preset (*"The battery backup is not bad at all..."*) to demonstrate that ReviewIQ AI avoids naive keyword matching and correctly classifies negated negative phrases as **Positive**.

3. **Demonstrate Complaint Discovery:**
   Navigate to **Complaint Discovery** (`/complaints`) to show how negative aspects across all 120 reviews are automatically filtered, surfaced, and attributed to specific devices with direct evidence citations.

4. **Demonstrate Side-by-Side Product Comparison:**
   Navigate to **Product Comparison** (`/compare`) and select Nova X Pro, PixelWave 9, and GalaxySphere S25 to see their aspect satisfaction scores (Camera, Battery, Display, Performance, etc.) contrasted on interactive charts.

5. **Demonstrate Model Evaluation:**
   Navigate to **Model Evaluation** (`/model`) to inspect the real confusion matrix and precision/recall/F1 metrics computed by scikit-learn on the held-out test split.
