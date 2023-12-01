## Локальный запуск
- Первоначально отдельно создается база данных в postgresql и ее первоначальное наполнение
- в папке local_deploy создаеться файл config.yaml по образу config.yaml-example
- запускатся проект командой **docker-compose up -d**
- любым доступным способом пробрасывается внешний ip на комп с проектом. Docker-compose открывает 80 и 443 порты. У меня есть виртуалка  с openvpn сервером. Я на ней перенаправил 80 и 443 tcp порты на свой комп по впн-соединению. После этого настроил DNS-запись для **l.info66.ru**
Пробовал вместо проброса портов использовать nginx, результат тот же

### Для данного проекта использовался домен **l.info66.ru**

### Результат
- Все три теста на отказоустойчивость проходят, но гарантированно только 2
- Но не работают 3 url

### Для локального запуска настроил отправку логов запросов в стек ELK
Результат работы сервиса Пети [тут](https://github.com/sagrityanin/ya-devops-final-project/blob/main/local_deploy/doc/metrics.png)


## Запуск в Yandex-cloud приложения производится в следующей последовательности

### Настроить доступ к яндекс облаку

### Запустить VPN или настроить зеркало terraform

### В каталоге terraform создать файл **terraform/bingo.tfvars** по образу **terraform/bingo.tfvars-example**

### Перейти в каталог terraform

### Инициализировать терраформ
- **terraform init**

### При желании посмотреть план развертывания инфраструктуры 
-  **terraform plan**

### Создать container registry
 - terraform apply -var-file=bingo.tfvars -target=yandex_container_registry.registry1
 - из вывода данной команды берем значение  **sagrityaninregistry_registry_id** и создаем переменную
    - export registry_id=<sagrityaninregistry_registry_id.value>

### Если нужен https, создаем отдельно ssl-сертификат и помещем его файлы в nginx-lb/ssl

### Создание и загрузка образов c учетом id container registry
- docker build ./db_host/postgres -t cr.yandex/${registry_id}/bingo:db
- docker build ./db_host/app -t cr.yandex/${registry_id}/bingo:init
- docker build ./app -t cr.yandex/${registry_id}/bingo:app
- docker build ./nginx_lb -t cr.yandex/${registry_id}/bingo:nginx-lb
- docker push cr.yandex/${registry_id}/bingo:db
- docker push cr.yandex/${registry_id}/bingo:init
- docker push cr.yandex/${registry_id}/bingo:app
- docker push cr.yandex/${registry_id}/bingo:nginx-lb
### Либо **bash upload_images.sh**

### Создать всю оставшуюся инфраструктуру
- terraform apply -var-file=bingo.tfvars

### Для работы прижения используются сдедующие домены
- **db.info66.ru**: база даных - приватный ip виртуалки bingo-db, жестко задан в манифесте terraform
- **bingo.info66.ru**: приложение - внешний ip Nginx-LB

### Эти DNS записи я создавал взяв ip из output последней команды

### Через 10 минут конейнер bingo_init на виртуалке bingo-db призведет первоначальное наполнение базы данных и создаст индексы. При желании можно использовать любую внешний сервер postgresql через db.info66.ru  c указанием соответствующих переменных в **terraform/bingo.tfvars** образец - terraform/bingo.tgvars-example

## Для обработки запросов /api/session произвел оптимизацию postgresql по [статье](https://habr.com/ru/companies/slurm/articles/714096/)

### Результат
- При данном варианте запуска у меня отработали все url
- Тест №3 на отказоустойчивость проваливаеться

# Пояснения
### Helthcheck
- **nginx** выбран в качестве балансировщика, т.к. может отключать узел в **upstream** по первому ошибочному запросу. **NLB** в **yandex-cloud** в самом быстром случае через 5 секунд может только понять что виртуалку нужно отключить. В моих экспириментах **NLB** еще 5 секунд думал и только потом отключал.
- Для ускорения перезапуска приложения использовал healthcheck docker контейнера. Мониторинг состояния и перезапуск производит другой контейнер на базе образа **willfarrell/autoheal**

## Дальнейшие шаги
### Избавление от хардкода
- передавать ip postgresql-сервера не через dns-имя, а формировать переменную из yandex_compute_instance.bingo-db.network_interface[0].<private_ip_address>  и передаать ее в контейнеры с бинарником
- аналогично сорать все IP yandex_compute_instance_group.bingo-worker-group и из этого списка формировать upstream для конфига nginx в yandex_compute_instance.bingo-nlb и передать в виде переменной

## PS
В последний день были урезаны квоты в яндекс облаке, поэтому запускал проект с вырезаными **sequruty groups**