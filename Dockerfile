# Builder Stage
FROM node:18-alpine AS builder
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the production Next.js app
RUN npm run build

# Runtime Stage
FROM node:18-alpine
WORKDIR /app

# Copy necessary files from the builder stage
COPY --from=builder /app/package*.json ./
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/.next ./.next
COPY --from=builder /app/public ./public

# Expose the port Next.js will run on
EXPOSE 3000

# Set environment to production
ENV NODE_ENV=production

# Start production server
CMD["npm", "run", "start"]
