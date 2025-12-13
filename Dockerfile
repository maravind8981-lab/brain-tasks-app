FROM node:18-alpine

WORKDIR /app

# Copy package files from root
COPY package*.json ./

RUN npm install

# Copy rest of the app
COPY . .

EXPOSE 3000

CMD ["npm", "start"]
