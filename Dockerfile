FROM node:12 as build-stage
WORKDIR /app
COPY package*.json ./
RUN yarn
COPY . .
CMD yarn build production

FROM nginx:alpine
EXPOSE 1337
COPY --from=build-stage /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
WORKDIR /usr/share/nginx/html
COPY /public /public