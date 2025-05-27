# Étape 1: Builder avec Alpine sécurisé
FROM alpine:3.21.3 as builder

WORKDIR /app
COPY . .

# Étape 2: Image finale avec Nginx sécurisé
FROM nginxinc/nginx-unprivileged:1.28.0-alpine-slim
# Copie des fichiers statiques
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app /usr/share/nginx/html
EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]