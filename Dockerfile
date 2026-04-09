# Use official Python slim image
FROM python:3.11-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# Set working directory inside container
WORKDIR /app

# Copy requirements first for caching
COPY requirements-minimal.txt .

# Install dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements-minimal.txt

# Copy the rest of the project
COPY . .

# Expose the port uvicorn will run on
EXPOSE 8000

# Set environment variables for model paths (optional)
ENV MODEL_PATH=models/trained/house_price_model.pkl
ENV PREPROCESSOR_PATH=models/trained/preprocessor.pkl

# Command to run the FastAPI app
CMD ["uvicorn", "src.api.main:app", "--host", "0.0.0.0", "--port", "8000", "--reload"]
 