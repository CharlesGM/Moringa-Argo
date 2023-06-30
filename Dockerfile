# Use the official Nginx image as a base
FROM nginx:alpine

# Copy the HTML file to the Nginx container
COPY index.html /usr/share/nginx/html/index.html