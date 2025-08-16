# server/Dockerfile
# Use Debian-based Node so better-sqlite3 can compile cleanly
FROM node:20-bullseye-slim

# Build tools for native modules (better-sqlite3)
RUN apt-get update && apt-get install -y python3 g++ make && rm -rf /var/lib/apt/lists/*

# Create app dir
WORKDIR /app/server

# Install deps first (better layer caching)
COPY package*.json ./
RUN npm ci --omit=dev

# Copy the rest of the server
COPY . .

# Environment (PORT comes from Railway; don't set it here)
ENV NODE_ENV=production

# Run the API
CMD ["node", "src/server.js"]
