#!/bin/bash

# Install system dependencies required for pyodbc
apt-get update && apt-get install -y \
    unixodbc \
    unixodbc-dev \
    odbcinst \
    libpq-dev \
    curl \
    gnupg

# Install Microsoft ODBC Driver 17 (for Azure SQL)
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list > /etc/apt/sources.list.d/mssql-release.list
apt-get update
ACCEPT_EULA=Y apt-get install -y msodbcsql17

# Install Python dependencies
pip install -r requirements.txt

# Start the application
gunicorn --bind 0.0.0.0:8000 FlaskWebProject:app

