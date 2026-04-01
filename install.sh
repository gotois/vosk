#!/bin/bash

# Скачивание модели
model=vosk-model-small-ru-0.22

if [ -f "${model}.zip" ]; then \
  echo "Using local zip"; \
else \
  echo "Downloading model"; \
  wget "https://alphacephei.com/vosk/models/${model}.zip"; \
fi \
  && unzip -o "${model}.zip"
