FROM node:24-alpine AS build-stage
WORKDIR /app
COPY spa/package*.json ./
RUN npm ci
COPY spa/ .
RUN npm run build

FROM ghcr.io/identicum/ipax:latest
# IPAx "spa" mode: serves /var/ipax/html behind OIDC login and proxies /api/ to API_BASE_URL with the access token.
# Environment-specific values (IPAX_BASE_URL, OIDC_DISCOVERY, OIDC_CLIENT_ID, OIDC_CLIENT_SECRET, API_BASE_URL) are set at runtime.
ENV IPAX_MODE=spa \
    IPAX_APP_NAME=spa \
    IPAX_DISPLAY_NAME="Store Online" \
    OIDC_USE_PKCE=true
COPY --from=build-stage /app/dist /var/ipax/html
