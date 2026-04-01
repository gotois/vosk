import os
import json
import wave
from flask import Flask, request, jsonify
from vosk import Model, KaldiRecognizer

app = Flask(__name__)
model_path = os.getenv("VOSK_MODEL_PATH")
model = Model(model_path)

@app.route("/recognize", methods=["POST"])
def recognize():
    if "audio" not in request.files:
        return jsonify({"error": "No audio file provided"}), 400

    audio_file = request.files["audio"]
    with wave.open(audio_file, "rb") as wf:
        rec = KaldiRecognizer(model, wf.getframerate())

        while True:
            data = wf.readframes(4000)
            if len(data) == 0:
                break
            rec.AcceptWaveform(data)

        result = json.loads(rec.FinalResult())

    return app.response_class(
        response=json.dumps(result),
        status=200,
        mimetype="application/json; charset=utf-8"
    )
