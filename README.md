# AST-Based Sentiment and Emotion Analyzer

**Explainable Rule-Based Sentiment Analysis Using Compiler AST Semantic Propagation**

An academic Compiler Design web application demonstrating how classical compilation phases—**Lexical Analysis**, **Syntax Analysis**, **Abstract Syntax Tree (AST) Construction**, and **Semantic Analysis with Bottom-Up Attribute Propagation**—evaluate sentence structure, resolve modifier nesting, detect domain aspects, identify discrete emotions, and compute sentiment without external AI APIs or black-box libraries.

---

## 1. Compiler Design Architecture

```
User Input Text
      │
      ▼
[Phase 1: Lexical Analysis (lexer.js)]
      ├── Tokenizer (contractions, smart apostrophes, multi-word modifiers, words, punctuation)
      └── Token Classification & Sentiment Lexicon Lookup
      │
      ▼
[Phase 2: Syntax Analysis (parser.js)]
      ├── Clause Partitioning (Contrast Conjunctions, e.g. "but", and Terminal Punctuation)
      └── Hierarchical AST Construction (Sentence -> Clause -> Modifiers -> Sentiment Word)
      │
      ▼
[Phase 3: Semantic Analysis (semanticAnalyzer.js)]
      ├── Bottom-Up Post-Order AST Traversal & Attribute Propagation
      ├── Multiplier Application (Intensifier ×1.5, Diminisher ×0.5)
      ├── Polarity Inversion (Negation -1.0×)
      └── Range Clamping to [-1.0, +1.0]
      │
      ▼
[Phase 4: Discrete Emotion Detection (emotionAnalyzer.js)]
      └── Context-aware affect identification (Happiness, Sadness, Anger, Fear, Disgust, Surprise, Disappointment)
      │
      ▼
[Phase 5: Aspect-Based & Mixed Sentiment (aspectAnalyzer.js)]
      ├── Domain aspect extraction (Camera, Battery, Display, Service, Price, etc.)
      └── Multi-Aspect Conflict Resolution (Mixed Sentiment)
      │
      ▼
[Phase 6: Explanation Engine (explanationEngine.js)]
      └── Natural language audit derivation & step-by-step mathematical trace
```

---

## 2. Explicit Scoring & Semantic Propagation Policy

1. **Score Range:** Strictly bounded to `[-1.0, +1.0]`.
2. **Base Polarity:** Evaluative lexicon entries provide initial base scores (e.g., `good` = $+0.7$, `bad` = $-0.8$, `excellent` = $+1.0$, `terrible` = $-1.0$).
3. **Intensifiers:** Multiplies child expression score by `INTENSIFIER_MULTIPLIER` (default $1.5\times$), clamped to `[-1.0, +1.0]`.
4. **Diminishers:** Multiplies child expression score by `DIMINISHER_MULTIPLIER` (default $0.5\times$), clamped to `[-1.0, +1.0]`.
5. **Negations:** Reverses the polarity ($-1.0\times$) within its syntactic AST scope, clamped to `[-1.0, +1.0]`.
6. **Order of Operations:** In `"The camera is not very good."`:
   - Leaf: `good` = $+0.7$
   - Intensifier: `very` $\times 1.5 = +1.05 \rightarrow \text{clamped to } +1.00$
   - Negation: `not` inverts $+1.00 \rightarrow -1.00$
   - Result: $-1.00$ (**Negative**).
7. **Litotes Inversion:** In `"The battery is not bad."`:
   - Leaf: `bad` = $-0.8$
   - Negation: `not` inverts $-0.80 \rightarrow +0.80$
   - Result: $+0.80$ (**Positive**).
8. **Emotion Decoupling:** General evaluative words like `good` or `terrible` carry sentiment scores but are decoupled from discrete human emotions. An emotion is only attributed if genuine affective keywords (e.g. `disappointed`, `happy`, `furious`) are present.
9. **Decision Thresholds:**
   - Score $> +0.1 \implies$ **Positive**
   - Score $< -0.1 \implies$ **Negative**
   - $-0.1 \le \text{Score} \le +0.1 \implies$ **Neutral**
   - Opposing positive and negative aspects $\implies$ **Mixed**

---

## 3. Compiler Stage Color Conventions

| Stage | Color | Hex Code |
| :--- | :--- | :--- |
| **Lexical Analysis** | Pink | `#E91E63` / `#FCE4EC` |
| **Syntax Analysis & AST** | Blue | `#1976D2` / `#E3F2FD` |
| **Semantic Analysis** | Green | `#2E7D32` / `#E8F5E9` |
| **Sentiment & Emotion Analysis** | Orange | `#EF6C00` / `#FFF3E0` |
| **Explanation Engine & Dashboard** | Purple | `#7B1FA2` / `#F3E5F5` |

### Sentiment Categories (Always shown with written text labels)
- **Positive:** Green `#2E7D32`
- **Negative:** Red `#C62828`
- **Neutral:** Grey `#616161`
- **Mixed:** Orange `#EF6C00`

### Discrete Emotion Categories
- **Happiness:** Yellow `#F9A825`
- **Sadness:** Blue `#1565C0`
- **Anger:** Dark Red `#B71C1C`
- **Fear:** Purple `#6A1B9A`
- **Disgust:** Olive Green `#558B2F`
- **Surprise:** Teal `#00838F`
- **Disappointment:** Slate Blue-Grey `#546E7A`

---

## 4. Automated Compiler Verification Suite (27/27 Tests)

Run the test suite with:
```bash
npm test
```

### Coverage Highlights:
- **Phase 1 (Lexical):** Token boundaries, contractions with smart apostrophes (`don’t`, `can’t`), multi-word diminishers (`a little`), uppercase normalization, ordinary word filtering.
- **Phase 2 (Syntax):** Hierarchical AST nesting (`Negation -> Intensifier -> SentimentWord`), contrast conjunction splitting (`but`, `however`), terminal punctuation boundaries, multi-aspect clause retention.
- **Phase 3 (Semantic):**
  - Empty and whitespace-only input handling
  - Clearly positive sentence (`"I love this phone."` $\implies +1.0$)
  - Clearly negative sentence (`"The product is terrible."` $\implies -1.0$)
  - Neutral sentence without sentiment terms (`"The product arrived yesterday."` $\implies 0.0$)
  - `"The camera is not good."` $\implies -0.7$
  - `"The camera is not very good."` $\implies -1.0$ (with intensifier clamping)
  - `"The camera is very good."` $\implies +1.0$
  - `"The camera is slightly disappointing."` $\implies -0.25$
  - `"The battery is not bad."` $\implies +0.8$
  - Uppercase & punctuation variations (`"THE CAMERA IS EXCELLENT!!!"`)
  - Negation scope limits (unaffected words outside scope)
- **Phase 4 & 5 (Aspect & Emotion):**
  - Opposing aspects classify overall sentiment as Mixed (`"The camera is excellent, but the battery is disappointing."`)
  - Multiple aspect targets in one clause (`"The camera and battery are great."`)
  - Sentences without recognized domain aspects
  - Discrete emotion detection with intensity (`"I am extremely disappointed with this service."` $\implies$ Disappointment [High])
  - Honest neutral emotion state on evaluative sentences (`"The camera is not very good."` $\implies$ No specific emotion detected)
  - Full consistency between scores, labels, AST data, aspects, and explanations.

---

## 5. Local Setup & Execution

### Prerequisites
Node.js (v18+) and npm.

### Commands

1. **Install Dependencies:**
   ```bash
   npm install
   ```

2. **Run Compiler Unit Tests:**
   ```bash
   npm test
   ```

3. **Start Development Server:**
   ```bash
   npm run dev
   ```
   *Serves application locally at `http://127.0.0.1:3000/`.*

4. **Production Build:**
   ```bash
   npm run build
   ```

---

## 6. Viva Demonstration Guide

When presenting the project to examiners:
1. **Pipeline Execution Flow:** Point to the top tracker showing all 10 stages in a responsive, wrapped grid.
2. **AST Modifier Hierarchy:** Enter `"The camera is not very good."` and inspect the Visual AST:
   - Root `SENTENCE` $\rightarrow$ `CLAUSE` $\rightarrow$ `NEGATION: not` $\rightarrow$ `INTENSIFIER: very` $\rightarrow$ `SENTIMENT_WORD: good (+0.7)`.
   - Switch to the **ASCII Tree** view and demonstrate parent-child indentation.
3. **Semantic Propagation Audit:** Show the Step-by-Step panel:
   - Base score: $\text{good} = +0.7$
   - Intensifier: $+0.7 \times 1.5 = +1.05 \rightarrow \text{Clamped to } +1.00$
   - Negation: $-(+1.00) = -1.00$
   - Final Classification: **Negative**.
4. **Mixed Sentiment Handling:** Load Example 4 (`"The camera is excellent, but the battery is disappointing."`). Show how the contrast conjunction `but` creates 2 independent clauses, linking `Camera` to $+1.0$ (Positive) and `Battery` to $-0.5$ (Negative), classifying the overall result as **Mixed**.
5. **Decoupled Emotion Classification:** Explain that evaluative quality words (`good`, `bad`, `slow`) do not invent false emotions, while affective words (`disappointed`, `happy`, `furious`) trigger discrete emotions with evidence and intensity.
6. **Live Test Suite:** Click **"Compiler Tests (27/27)"** in the header to demonstrate live pass results across all compiler phases.
