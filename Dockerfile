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
RUN mkdir -p /models \
    && wget -q -O "/tmp/${VOSK_MODEL}.zip" "https://alphacephei.com/vosk/models/${VOSK_MODEL}.zip" \
    && unzip -q "/tmp/${VOSK_MODEL}.zip" -d /models \
    && rm "/tmp/${VOSK_MODEL}.zip"

ENV VOSK_MODEL=${VOSK_MODEL}
ENV VOSK_MODEL_PATH=/models/${VOSK_MODEL}

COPY . .
