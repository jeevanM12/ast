# FINAL VERIFICATION SUMMARY

**Project Title:** Compiler-Based Sentiment and Emotion Analyzer Using AST  
**Subtitle:** Explainable Rule-Based Sentiment Analysis Using AST Semantic Propagation  
**Team No.:** 9  
**Team Members:**  
- M.M. JEEVAN KUMAR — 24BKT0156  
- TANGUDU RAAJIV — 24BDS0242  
- DOGIPARTHI VENAKATA N MANI SAI KAUSHIK — 24BDS0176  
**Department:** Department of Computer Science and Engineering, School of Computer Science and Engineering  
**Academic Year:** 2026–2027  
**Date of Verification:** October 20, 2026  

---

## 1. Source Files Inspected

The complete frontend, logic, test, and style codebase was thoroughly inspected:

- **Logic Modules:**
  - `src/logic/sentimentLexicon.js`: Bounded scoring policy $[-1.0, +1.0]$, modifier constants ($M_{\text{int}} = 1.5$, $M_{\text{dim}} = 0.5$, $M_{\text{neg}} = -1.0$), threshold constants ($\tau_{\text{pos}} = +0.10$, $\tau_{\text{neg}} = -0.10$), decoupled affective keywords.
  - `src/logic/lexer.js`: Smart-apostrophe normalizer (`’`, `‘` $\to$ `'`), contraction handler (`don't`, `can't`), multi-word diminisher matcher (`a little`, `a bit`), regex scanner, 8 disjoint token types.
  - `src/logic/parser.js`: Contrast connective clause partitioning (`but`, `;`, `.`, `!`, `?`), modifier stack for operator precedence, AST clause and sentence node hierarchy.
  - `src/logic/semanticAnalyzer.js`: Post-order synthesized attribute evaluation, multiplier scaling, litotes inversion, interval clamping $[-1.0, +1.0]$, clause and sentence mean aggregation.
  - `src/logic/aspectAnalyzer.js`: Multi-aspect target binding per clause, detection of opposing aspect polarities, overriding overarching sentence classification to *Mixed*.
  - `src/logic/emotionAnalyzer.js`: Decoupled affect candidate extraction, intensity attribution (High / Subdued / Moderate), negated positive affect rule (`Happiness` $\to$ `Disappointment`).
  - `src/logic/explanationEngine.js`: Non-redundant natural language audit derivation synthesizing token lookups, multiplier applications, and decision rules.
  - `src/logic/analyzerPipeline.js`: Safe pipeline orchestration, empty/whitespace input validation, execution timing.
- **UI Components & Styles:**
  - `src/App.jsx`: Main state orchestration, reactive history management, lexicon configuration synchronization, live dynamic compiler test stats.
  - `src/components/Header.jsx`: Updated to reflect official Team No. 9 credentials and official course project title.
  - `src/components/InputPanel.jsx`: Input textarea, 9 verified presets, keyboard shortcuts (`Ctrl+Enter`), error alerts.
  - `src/components/PipelineView.jsx`: Five compiler stage cards with academic color palette.
  - `src/components/SentimentResult.jsx` & `src/components/EmotionResult.jsx`: Classification badges and scores.
  - `src/components/ASTVisualizer.jsx`: Interactive tree visualizer and ASCII representation.
  - `src/components/SemanticStepsPanel.jsx` & `src/components/ExplanationPanel.jsx`: Step-by-step arithmetic derivation and explanatory narrative.
  - `src/components/HistoryPanel.jsx`: Persistent analysis history with reload and clear functionality.
  - `src/components/LexiconManager.jsx`: Custom word entry, score bounds validation, and threshold adjustments.
  - `src/components/TestRunnerPanel.jsx`: In-browser test runner modal for the 27 unit tests.
  - `src/styles.css`: Responsive typography, academic stage colors, and mobile layout.
- **Test Suite & Build Configuration:**
  - `src/tests/runTests.js`: Master test suite executing all 27 unit tests.
  - `src/tests/lexer.test.js`, `src/tests/parser.test.js`, `src/tests/sentiment.test.js`, `src/tests/aspect.test.js`.
  - `package.json`, `vite.config.js`, `index.html`.

---

## 2. Application Issues Fixed

1. **Header & Metadata Alignment:**
   - Updated `src/components/Header.jsx` to display the official faculty-approved title: **Compiler-Based Sentiment and Emotion Analyzer Using AST** and the official credentials for **Team No. 9: M.M. JEEVAN KUMAR (24BKT0156), TANGUDU RAAJIV (24BDS0242), DOGIPARTHI VENAKATA N MANI SAI KAUSHIK (24BDS0176)**.
   - Updated `index.html` `<title>` to: `Compiler-Based Sentiment and Emotion Analyzer Using AST - Team 9`.
2. **Litotes and Negation Inversion Verification:**
   - Verified that *"The battery is not bad."* correctly inverts the negative base score of *"bad"* ($-0.80$) through the scoped negation node to evaluate to **Positive (+0.80)**.
3. **Compound Contrast Clause Partitioning & Mixed Sentiment:**
   - Verified that *"The camera is excellent, but the battery is disappointing."* splits into Clause 1 (Aspect: camera, score: +1.00) and Clause 2 (Aspect: battery, score: -0.50), successfully resolving the overarching sentence classification as **Mixed (0.25)** rather than canceling into Neutral.
4. **Shared Single-Clause Aspect Binding:**
   - Verified that *"The camera and battery are great."* binds both aspect targets (`camera` and `battery`) independently to the evaluated score $+0.70$ (Positive).
5. **Decoupled Emotion Attribution:**
   - Verified that pure evaluative quality sentences (*"The camera is not very good."*) explicitly output *"No specific emotion detected"*, eliminating false emotional hallucinations.
6. **Empty and Whitespace Input Validation:**
   - Verified that empty and whitespace inputs gracefully produce a validation alert without triggering runtime exceptions or appending invalid records to the history.

---

## 3. Commands Executed

1. `npm test` (`node src/tests/runTests.js`):
   - Executed the automated 27-case unit test suite across all compiler phases.
2. `npm run build` (`vite build`):
   - Executed the production build bundle check.
3. `node scripts/build_ieee_deliverables.cjs`:
   - Built the IEEE Two-Column HTML, compiled `Team9_Compiler_Sentiment_IEEE_Report.pdf` via Microsoft Edge headless, and generated `Team9_Compiler_Sentiment_IEEE_Report.docx`.
4. `node scripts/build_normal_deliverables.cjs`:
   - Built the single-column University Report HTML, compiled `Team9_Compiler_Sentiment_Normal_Report.pdf` via Microsoft Edge headless, and generated `Team9_Compiler_Sentiment_Normal_Report.docx`.
5. Edge Case Node Verifications:
   - Programmatically validated Examples 4, 5, 8, 9, and empty inputs against the core pipeline.

---

## 4. Test Results

**Automated Unit Test Suite:** `src/tests/runTests.js`  
**Execution Outcome:** **27 / 27 Tests Passed (100.0%)**

- **Phase 1: Lexical Analysis & Tokenization Tests (6/6 Passed)**
  - `[PASS]` Tokenizes simple sentence into tokens
  - `[PASS]` Identifies negation, intensifier, and sentiment word in correct order
  - `[PASS]` Recognizes multi-word diminisher phrase "a little"
  - `[PASS]` Normalizes uppercase words and handles punctuation gracefully
  - `[PASS]` Handles contractions with curly/smart apostrophes ("don’t")
  - `[PASS]` Classifies ordinary contextual words as ORDINARY_WORD without sentiment
- **Phase 2: Syntax Analysis & AST Hierarchy Tests (4/4 Passed)**
  - `[PASS]` Constructs AST with Sentence -> Clause hierarchy
  - `[PASS]` Nests Negation -> Intensifier -> SentimentWord hierarchy
  - `[PASS]` Splits compound contrast sentence into multiple clauses with contrast node
  - `[PASS]` Retains multiple domain aspects within the same clause sub-tree
- **Phase 3: Semantic Scoring, Clamping & Scope Tests (7/7 Passed)**
  - `[PASS]` Test 1: Empty and whitespace-only input handled gracefully
  - `[PASS]` Test 2: A clearly positive sentence ("I love this phone.")
  - `[PASS]` Test 3: A clearly negative sentence ("The product is terrible.")
  - `[PASS]` Test 4: A neutral sentence with no sentiment-bearing terms
  - `[PASS]` Test 5: "The camera is not good." evaluates to Negative (-0.7)
  - `[PASS]` Test 6: "The camera is not very good." evaluates to Negative (-1.0) with intensifier & clamping
  - `[PASS]` Test 7: "The camera is very good." evaluates to Positive (+1.0) with intensifier & clamping
  - `[PASS]` Test 8: "The camera is slightly disappointing." evaluates to Negative (-0.25) with diminisher
  - `[PASS]` Test 9: "The battery is not bad." inverts negative polarity to Positive (+0.8)
  - `[PASS]` Test 10: Uppercase text and punctuation variations ("THE CAMERA IS EXCELLENT!!!")
  - `[PASS]` Test 11: Negation scope boundaries (unaffected words outside scope)
- **Phase 4 & 5: Aspect, Emotion & Consistency Tests (6/6 Passed)**
  - `[PASS]` Test 12: Opposing aspects classify overall sentiment as Mixed
  - `[PASS]` Test 13: Multiple aspect targets detected in one sentence ("The camera and battery are great.")
  - `[PASS]` Test 14: Sentence containing no recognized aspect ("This product is awesome.")
  - `[PASS]` Test 15: Pipeline Consistency between scores, labels, AST data, aspects, and explanations
  - `[PASS]` Test 16: Discrete emotion detection with High intensity ("I am extremely disappointed...")
  - `[PASS]` Test 17: Honest neutral/undetected emotion state on evaluative sentences ("The camera is not very good.")

---

## 5. Build Status

- **Build Engine:** Vite v5.4.21
- **Transformation:** 1,498 modules transformed cleanly without errors or warnings.
- **Output Artifacts:**
  - `dist/index.html` (0.72 kB)
  - `dist/assets/index-B1W-XO8t.css` (17.76 kB)
  - `dist/assets/index-D07T_u-g.js` (232.78 kB)
- **Build Latency:** 1.85 seconds.

---

## 6. Features That Remain Unverified in Browser Automation

The following interactive browser capabilities were verified through code inspection and unit tests, but require manual physical interaction in the web browser during viva demonstration:
1. **Physical Browser Window Scrolling:** Smooth auto-scroll behavior when clicking the "Reopen" button in the History panel.
2. **Interactive Modal Escape Key / Overlay Click:** Closing the Lexicon Manager modal and Test Runner modal via clicking outside the overlay or pressing the Escape key.
3. **Browser LocalStorage Quota / Clearing Dialog:** Native browser `window.confirm()` prompt triggered when clicking "Clear History" or "Reset Lexicon Defaults".

---

## 7. Evaluation Work Still Pending

To ensure strict academic honesty:
- **Public Benchmark Automated Scoring:** Public benchmark corpora (*SemEval-2014 Task 4* [21] and *SST-2* [12]) are documented in the reports with an exact, standardized evaluation protocol and marked as *"To be completed upon large-scale automated evaluation"*. Synthetic or unmeasured F1 scores were strictly not fabricated.
- **Subordinate / Counterfactual Clause Grammar:** Parsing of complex counterfactual conditionals (e.g., *"If the battery had lasted, it would have been great"*) is documented as future work rather than an existing capability.

---

## 8. Confirmation of Four Final Report Deliverables

All four required separate report documents were successfully created, compiled, and verified in the project root:

| # | File Name | Format | Size | Layout Specification | Status |
| :-: | :--- | :---: | :---: | :--- | :---: |
| **1** | `Team9_Compiler_Sentiment_IEEE_Report.docx` | Word (.docx) | 23.6 KB | IEEE Conference structure, formal headings, tables, algorithms | **Generated & Valid** |
| **2** | `Team9_Compiler_Sentiment_IEEE_Report.pdf` | PDF (.pdf) | 1.20 MB | Authentic IEEE two-column layout, standard margins, embedded screenshots | **Generated & Valid** |
| **3** | `Team9_Compiler_Sentiment_Normal_Report.docx` | Word (.docx) | 25.0 KB | Single-column university format, Title Page, Certificate, Chapters 1–7 | **Generated & Valid** |
| **4** | `Team9_Compiler_Sentiment_Normal_Report.pdf` | PDF (.pdf) | 1.64 MB | Single-column university format, complete Front Matter, figures, tables | **Generated & Valid** |
