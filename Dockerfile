# Use an official Node runtime as a parent image
FROM node:16-alpine

# Set a working directory
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3000

# Start the development server (change to 'npm run start' for production)
CMD ["npm", "run", "dev"]
