FROM node:latest as build

WORKDIR /app

# download Ionic app from github
RUN wget https://github.com/guilhermeteruaki/mobdev_ca3/archive/main.tar.gz \
&& tar xf main.tar.gz \
&& rm main.tar.gz 

#change to app folder
WORKDIR /app/mobdev_ca3-main/

#install ionic
RUN npm install -g ionic
RUN npm install


# running ionic
RUN npm run build --prod

#installing alpine
FROM nginx:alpine

#exposing port 8080
EXPOSE 8080

RUN rm -rf /usr/share/nginx/html/*


COPY --from=build app/mobdev_ca3-main//www/ /usr/share/nginx/html/