## Create images
- docker build ./postgres -t cr.yandex/crpgs3g59it0ouonuleo/bingo:db
- docker build ./app -t cr.yandex/crpgs3g59it0ouonuleo/bingo:init

## Push images
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:db
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:init

## После старта db-host нужно проделать следующие действия
- по ssh зайти на виртуалку с BD
- командой "docker images -a" проверить что загрузились 2 docker images
- загрузить переменные "export $(cat .env)"
- вычистить доверовские сети "docker system prune"
- docker-compose up -d
- проверить работу контейнеров "docker-compose logs"

Причина этих телодвижений - не решенный вопрос с загрузкой переменных окружения внутри виртуальной машины
