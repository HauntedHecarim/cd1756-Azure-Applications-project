#!/bin/bash

# Update package lists
apt-get update 

# Install system dependencies required for pyodbc
apt-get install -y \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    libpq-dev \
    curl \
    gnupg \
    g++ \
    python3-dev

# Install Microsoft ODBC Driver 17 (for Azure SQL)
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Verify ODBC installation
echo "Verifying ODBC Installation..."
odbcinst -q -d

# Ensure pip is installed and up-to-date
python3 -m ensurepip
pip install --upgrade pip

# Install pyodbc separately before the rest
pip install --no-cache-dir --force-reinstall pyodbc==4.0.35

# Install remaining Python dependencies
pip install --no-cache-dir -r requirements.txt

# Start the application
gunicorn --bind 0.0.0.0:8000 FlaskWebProject:app
