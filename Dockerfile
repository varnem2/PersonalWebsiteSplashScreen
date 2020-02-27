FROM node as build
WORKDIR /app
COPY package.json /app/package.json
RUN npm install
COPY angular.json /app/angular.json
COPY e2e /app/e2e
COPY karma.conf.js /app/karma.conf.js
COPY protractor.conf.js /app/protractor.conf.js
COPY src /app/src
COPY tsconfig.json /app/tsconfig.json
COPY tslint.json /app/tslint.json
RUN npx ng build
FROM nginx

COPY --from=build /app/dist /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
