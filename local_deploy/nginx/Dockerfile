FROM nginx:1.23-alpine
COPY ./bingo.conf /etc/nginx/conf.d/
COPY ./ssl-l /etc/nginx/ssl/bingo.info66.ru/
RUN mkdir /var/cache/nginx/proxy && chown nginx:nginx /var/cache/nginx/proxy