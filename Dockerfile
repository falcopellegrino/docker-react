#1st - build phase

FROM node:alpine as builder
#/app/build <-- all the stuff produced form 1st phase

WORKDIR '/app'

COPY package.json .
RUN npm install

COPY . .

RUN npm run build



#2nd - run phase

# any phase can have a single FROM, so here begins 2nd phase
FROM nginx
EXPOSE 80

#copia dalla fase builder, dalla cartella /app/build, nella cartella della fase corrente /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html
#la cartella della fase corrente è specifica della configurazione di nginx
#presa da https://hub.docker.com/_/nginx

#start nginx
#viene eseguito automaticamente da solo utilizzando l'immagine FROM nginx