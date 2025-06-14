# Use an official lightweight Python image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements (optional: use pip freeze > requirements.txt)
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app files
COPY . .

# Download the BERT model once (if not done in your app)
RUN python -c "from transformers import BertTokenizer, BertForSequenceClassification; \
               BertTokenizer.from_pretrained('bert-base-uncased'); \
               BertForSequenceClassification.from_pretrained('bert-base-uncased')"

# Expose the port
EXPOSE 8000

# Run the FastAPI app
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]