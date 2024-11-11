FROM node:18-alpine as builder

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build --max-old-space-size=2048

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html