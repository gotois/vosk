# ---- Build stage ----
FROM python:3.9-slim AS builder

WORKDIR /build

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    cmake \
    gcc \
    g++ \
    python3-dev \
    libffi-dev \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip wheel --no-cache-dir --wheel-dir /build/wheels -r requirements.txt

# ---- Runtime stage ----
FROM python:3.9-slim AS runtime

WORKDIR /app

RUN apt-get update && apt-get install -y --no-install-recommends \
    libatomic1 \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/wheels /wheels
COPY requirements.txt .
RUN pip install --no-cache-dir --no-index --find-links=/wheels -r requirements.txt \
    && rm -rf /wheels

# todo поддерживаем только маленькую русскую модель
RUN wget -q https://alphacephei.com/vosk/models/vosk-model-small-ru-0.22.zip \
    && unzip vosk-model-small-ru-0.22.zip \
    && rm vosk-model-small-ru-0.22.zip

COPY . .
