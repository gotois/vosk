FROM python:3.9-slim

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    libffi-dev \
    libatomic1 \
    unzip \
    wget \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ARG VOSK_MODEL=vosk-model-small-ru-0.22
RUN wget -q "https://alphacephei.com/vosk/models/${VOSK_MODEL}.zip" \
    && unzip -q "${VOSK_MODEL}.zip" \
    && rm "${VOSK_MODEL}.zip"

ENV VOSK_MODEL_PATH=/app/vosk-model-small-ru-0.22

COPY . .
