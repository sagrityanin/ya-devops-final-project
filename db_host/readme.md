## Create images
- docker build ./db_host/postgres -t cr.yandex/crpgs3g59it0ouonuleo/bingo:db
- docker build ./db_host/app -t cr.yandex/crpgs3g59it0ouonuleo/bingo:init
- docker build ./app -t cr.yandex/crpgs3g59it0ouonuleo/bingo:app

## Push images
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:db
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:init
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:app

## Если через 5 минут после создания виртуали с приложением не заработают следует проделать следующие действия
- по ssh зайти на виртуалку с BD
- командой "docker images -a" проверить что загрузились 2 docker images
- вычистить доверовские сети "docker system prune"
- docker-compose up -d
- проверить работу контейнеров "docker-compose logs"

Причина этих телодвижений - не решенный вопрос с загрузкой переменных окружения внутрь виртуальной машины

## Для работы прижения используются сдедующие домены
- db.info66.ru
- diag.info66.ru
- bingo.info66.ru