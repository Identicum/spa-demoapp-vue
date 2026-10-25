FROM node:24-alpine AS build-stage
WORKDIR /app
COPY spa/package*.json ./
RUN npm ci
COPY spa/ .
RUN npm run build

FROM ghcr.io/identicum/ipax:latest
COPY --from=build-stage /app/dist /var/ipax/html
