FROM node:12.14.1-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build


FROM identicum/ipax:latest
COPY --from=build-stage /app/dist /var/ipax/html
