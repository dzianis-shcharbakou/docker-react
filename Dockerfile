FROM node:18-alpine as builder

WORKDIR '/app'
COPY package.json .
ENV NODE_OPTIONS="--max-old-space-size=2048"
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html