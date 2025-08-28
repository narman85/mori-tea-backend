# Simple PocketBase for Railway
FROM ubuntu:22.04

# Update and install required packages
RUN apt-get update && apt-get install -y \
    ca-certificates \
    curl \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Download PocketBase for Linux
RUN wget https://github.com/pocketbase/pocketbase/releases/download/v0.26.2/pocketbase_0.26.2_linux_amd64.zip \
    && unzip pocketbase_0.26.2_linux_amd64.zip \
    && chmod +x pocketbase \
    && rm pocketbase_0.26.2_linux_amd64.zip

# Copy configurations
COPY pocketbase-schema.json ./schema.json
COPY pb_migrations ./pb_migrations
COPY start.sh ./start.sh

# Create pb_data directory and make start script executable
RUN mkdir -p pb_data && chmod +x start.sh

# Expose port
EXPOSE 8080

# Start PocketBase via script
CMD ["./start.sh"]