# Use the official Nginx image from the Docker Hub
FROM nginx:latest

# Copy the Nginx configuration file to the container
COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80 to allow external access
EXPOSE 80

# Command to run Nginx
CMD ["nginx", "-g", "daemon off;"]