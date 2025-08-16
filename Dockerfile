# Use Node 20 slim image
FROM node:20-bullseye-slim

# Install build tools (only if your dependencies need them)
RUN apt-get update && apt-get install -y python3 g++ make && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --omit=dev

# Copy the rest of the code
COPY . .

# Set environment to production
ENV NODE_ENV=production

# Run the app
CMD ["node", "src/server.js"]
