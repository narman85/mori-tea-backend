# Railway optimized PocketBase Dockerfile
FROM alpine:latest

ARG PB_VERSION=0.26.2

# Install dependencies
RUN apk add --no-cache \
    unzip \
    ca-certificates \
    curl

# Create app directory
WORKDIR /app

# Download and install PocketBase
ADD https://github.com/pocketbase/pocketbase/releases/download/v${PB_VERSION}/pocketbase_${PB_VERSION}_linux_amd64.zip /tmp/pb.zip
RUN unzip /tmp/pb.zip -d /app/ && \
    chmod +x /app/pocketbase && \
    rm /tmp/pb.zip

# Copy schema and configuration
COPY pocketbase-schema.json /app/schema.json
COPY pb_migrations /app/pb_migrations

# Expose common port (Railway will override with $PORT)
EXPOSE 8080

# Start PocketBase with Railway's dynamic port
# Railway automatically provides $PORT environment variable
CMD sh -c './pocketbase serve --http=0.0.0.0:${PORT:-8080}'