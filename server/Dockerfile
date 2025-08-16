FROM node:20-bullseye-slim
RUN apt-get update && apt-get install -y python3 g++ make && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev

COPY . .
ENV NODE_ENV=production
CMD ["node", "src/server.js"]
