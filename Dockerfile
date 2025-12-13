FROM node:18-alpine

WORKDIR /app

# Copy package files first
COPY frontend/package*.json ./

RUN npm install

# Copy remaining app files
COPY frontend/ .

EXPOSE 3000

CMD ["npm", "start"]
