# Use an official Python runtime as a parent image with Debian base
FROM python:3.12-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Install wget, unzip, curl and dependencies required for Chrome
RUN apt-get update && apt-get install -y wget unzip curl \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Install Google Chrome
RUN wget -O /tmp/google-chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
    && dpkg -i /tmp/google-chrome.deb || apt-get install -yf \
    && rm /tmp/google-chrome.deb

# Install ChromeDriver
RUN CHROME_VERSION=$(google-chrome --version | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | head -1) \
    && CHROMEDRIVER_VERSION=$(wget -qO- "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_$CHROME_VERSION") \
    && wget -O /tmp/chromedriver.zip "https://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip" \
    && unzip /tmp/chromedriver.zip -d /usr/local/bin/ \
    && rm /tmp/chromedriver.zip

# Copy local code to the container
COPY . .

# Install Python dependencies from requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "app.py"]