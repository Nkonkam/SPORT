# Étape 1: Builder avec Alpine sécurisé
FROM alpine:3.21.3 as builder

WORKDIR /app
COPY . .

FROM nginxinc/nginx-unprivileged:1.28.0-alpine-slim

# 1. Suppression sécurisée avec les bonnes permissions
USER root
RUN rm -f /usr/share/nginx/html/* || true

# 2. Copie des nouveaux fichiers
COPY --from=builder --chown=nginx:nginx /app /usr/share/nginx/html

# 3. Retour à l'utilisateur non-privilégié
USER nginx

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]