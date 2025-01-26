# Use an official Python runtime as a parent image with Debian base
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /app

# Install wget, unzip, curl and dependencies required for Chrome
RUN apt-get update && apt-get install -y wget unzip curl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install Google Chrome
RUN wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i /tmp/google-chrome.deb || apt-get install -yf \
    && rm /tmp/google-chrome.deb

# Copy local code to the container
COPY . .

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

