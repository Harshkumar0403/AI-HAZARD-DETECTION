# Food Safety Hazard & Product Category Classification using BERT

This repository presents a complete NLP pipeline to automatically classify food safety incident reports into:

- **Product Categories** (e.g., dairy, meat, beverages, etc.)
- **Hazard Types** (e.g., biological, allergens, chemical, etc.)

The pipeline leverages state-of-the-art transformer models (BERT), includes preprocessing, data augmentation, model training, evaluation, and prediction generation.

---

## 🧾 Problem Statement

The goal is to build an automated text classification system that can extract meaningful labels from incident reports related to food safety. Given a report's `title` and `text`, the system predicts:

- **Hazard Type** – The nature of the risk involved (e.g., allergens, biological).
- **Product Category** – The category of food product associated with the hazard (e.g., meat, dairy).

This helps food regulatory agencies streamline monitoring and response.

---

## 📄 Dataset Overview

Two datasets are used:

- `final_df.csv` – Labeled training and validation dataset
- `test_df.csv` – Unlabeled test set for final predictions

Each report contains:
- `ID`
- `title`
- `text`
- `hazard-type` (for final_df)
- `product-category` (for final_df)

---

## ⚙️ Pipeline Summary

### 🔹 Data Preprocessing
- Combined `title` and `text` into one field
- Synonym-based text augmentation using **WordNet**
- Label encoding for classification targets
- Class balancing using computed weights
- Tokenization using `bert-base-uncased`
- Format conversion to HuggingFace `Dataset`

### 🔹 Model Training
- Model: `BertForSequenceClassification`
- Metrics: Accuracy and Weighted F1 Score
- Trained using HuggingFace’s `Trainer` class
- Separate models trained for:
  - `product-category`
  - `hazard-type`

---

## 📊 Results & Performance

### ✅ Product Category Classification

| Metric         | Score |
|----------------|-------|
| Accuracy       | 0.90  |
| Macro F1 Score | 0.84  |
| Weighted F1    | 0.90  |

The model performs consistently across most categories with strong F1 scores. Smaller classes show slight performance dips due to data imbalance.

---

### ✅ Hazard Type Classification

| Metric         | Score |
|----------------|-------|
| Accuracy       | 0.95  |
| Macro F1 Score | 0.92  |
| Weighted F1    | 0.95  |

The model demonstrates excellent performance across all hazard classes, including strong results even in low-support categories.

---

## 🧪 How to Use

### 🔧 Local Prediction

To run local predictions on the test set:

1. Place test data in:
./test_dataset/Hazards_UNLABELLED_TEST.csv

2. Ensure model files are saved under:
   ./saved_model/product-category/
   ./saved_model/hazard-type/

4. Run the main prediction script:

```bash
python main.py

## Install necessary Python packages with:
~ pip install -r requirements.txt

### Project structure

.
├── data/
│   ├── final_df.csv
│   └── test_df.csv
├── saved_model/
│   ├── product-category/
│   └── hazard-type/
├── notebooks/
│   └── model_training.ipynb
├── results/
│   └── pred.csv
├── main.py
└── README.md



