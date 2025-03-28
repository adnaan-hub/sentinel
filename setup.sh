#!/bin/bash
python -m venv sentinenv
source sentinenv/bin/activate
pyenv local 3.12.9
pip install --upgrade pip
pip install -r requirements.txt
ollama serve