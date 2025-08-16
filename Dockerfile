# Dockerfile (repo root)
FROM node:20-bullseye-slim
RUN apt-get update && apt-get install -y python3 g++ make && rm -rf /var/lib/apt/lists/*

WORKDIR /app/server
COPY server/package*.json ./
RUN npm ci --omit=dev

COPY server/ ./
ENV NODE_ENV=production
CMD ["node", "src/server.js"]
