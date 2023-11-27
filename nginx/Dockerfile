FROM nginx:1.23-alpine
COPY ./ssl /etc/nginx/ssl/bingo.info66.ru/
COPY ./bingo.conf /etc/nginx/conf.d/
RUN mkdir /var/cache/nginx/proxy && chown nginx:nginx /var/cache/nginx/proxy