FROM nginx:alpine

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copy static website files
COPY . /var/www/html

# Clean git and deploy configs from image
RUN cd /var/www/html && rm -rf .git .kamal config docs scripts README.md GEMINI.md SECURITY.md suggest.md Dockerfile .dockerignore nginx.conf _config.yml

EXPOSE 80

HEALTHCHECK --interval=15s --timeout=3s --start-period=5s --retries=3 \
  CMD wget -qO- http://127.0.0.1/v1/health || exit 1

CMD ["nginx", "-g", "daemon off;"]
