# Dockerfile (repo root)
FROM node:20-bullseye-slim

# Install build tools for better-sqlite3
RUN apt-get update && apt-get install -y python3 g++ make && rm -rf /var/lib/apt/lists/*

WORKDIR /app/server

# Copy only package.json files first for better caching
COPY server/package*.json ./

# Install dependencies (use npm install since no package-lock.json)
RUN npm install --omit=dev

# Copy the rest of the server code
COPY server/ ./

ENV NODE_ENV=production

# Railway will inject PORT automatically
CMD ["node", "src/server.js"]
