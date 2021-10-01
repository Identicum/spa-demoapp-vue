FROM node:12.14.1-alpine as build-stage
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM identicum/ipax:latest

ENV SESSION_COOKIE_PERSISTENT=off \
    SESSION_COOKIE_LIFETIME=86400 \
    API_URL=http://myapi:8080/
    
COPY --from=build-stage /app/dist /var/ipax/html
COPY conf/ /usr/local/openresty/nginx/conf/
COPY lua/ /etc/ipax/lua/