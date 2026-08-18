# Vosk Speech Recognition

## Installation

```bash
docker-compose up --build
```

The Vosk model is downloaded into `/models` while the image is built. To use a
new model version in development, update `VOSK_MODEL` in `compose.dev.yml`,
then rebuild the image.

## Supported Audio

- Format: WAV
- Encoding: PCM-16 LE
- Depth: 24-bit
- Sample Rate: 16 kHz

## Example

```shell
curl -X POST -F "audio=@example.wav" http://127.0.0.1:2700/recognize | jq
```
