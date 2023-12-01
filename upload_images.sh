docker build ./db_host/postgres -t cr.yandex/${registry_id}/bingo:db
docker build ./db_host/app -t cr.yandex/${registry_id}/bingo:init
docker build ./app -t cr.yandex/${registry_id}/bingo:app
docker build ./nginx_lb -t cr.yandex/${registry_id}/bingo:nginx-lb
docker push cr.yandex/${registry_id}/bingo:db
docker push cr.yandex/${registry_id}/bingo:init
docker push cr.yandex/${registry_id}/bingo:app
docker push cr.yandex/${registry_id}/bingo:nginx-lb
