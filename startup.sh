#!/bin/sh
# Update the system package lists
apt-get update

# Install necessary dependencies for PyODBC and system requirements
apt-get install -y git unixodbc-dev unixodbc gcc g++ build-essential libssl-dev

# Define the deployment directory
APP_DIR="/home/site/wwwroot"

# Navigate to the app directory
cd $APP_DIR

# Pull the latest code from GitHub
git pull https://github.com/HauntedHecarim/cd1756-Azure-Applications-project.git main

# Install Python dependencies
pip install --no-cache-dir -r requirements.txt

# Run the application using Gunicorn
gunicorn -b 0.0.0.0:8000 FlaskWebProject:app
