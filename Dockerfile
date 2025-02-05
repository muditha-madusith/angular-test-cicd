# Use official Node.js image for building the Angular app
FROM node:18 AS build

WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the entire Angular project to the container
COPY . .

# Build the Angular app
RUN npm run build --prod

# Use Nginx to serve the Angular app
FROM nginx:alpine

# Copy built Angular files to Nginx HTML directory
COPY --from=build /app/dist/my-app /usr/share/nginx/html

# Copy custom Nginx config
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
