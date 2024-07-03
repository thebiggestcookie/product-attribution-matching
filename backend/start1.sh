#!/bin/bash
echo "Current directory: $(pwd)"
echo "Python version: $(python --version)"
echo "Pip version: $(pip --version)"
echo "Installing requirements..."
pip install -r requirements.txt
echo "Installing gunicorn..."
pip install gunicorn
echo "Starting gunicorn..."
gunicorn app:app
