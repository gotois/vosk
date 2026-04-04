# Vosk Speech Recognition

## Installation

.env
```
VOSK_MODEL_PATH=/models/vosk-model-small-ru-0.22
```

```bash
bash install.sh
```

```shell
docker-compose up --build
```

## Supported Audio

- Format: WAV
- Encoding: PCM-16 LE
- Depth: 24-bit
- Sample Rate: 16 kHz

## Example

```shell
curl -X POST -F "audio=@example.wav" http://127.0.0.1:2700/recognize | jq
```
