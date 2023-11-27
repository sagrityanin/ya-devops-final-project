# Запуск приложения производится в следующей последовательности
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

### Создание образов c учетом id container registry
- docker build ./db_host/postgres -t cr.yandex/crpgs3g59it0ouonuleo/bingo:db
- docker build ./db_host/app -t cr.yandex/crpgs3g59it0ouonuleo/bingo:init
- docker build ./app -t cr.yandex/crpgs3g59it0ouonuleo/bingo:app
- docker build ./nginx -t cr.yandex/crpgs3g59it0ouonuleo/bingo:proxy

### Заливка образов в container registry c учетом id container registry
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:db
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:init
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:app
- docker push cr.yandex/crpgs3g59it0ouonuleo/bingo:proxy

### Создать всю оставшуюся инфраструктуру
- terraform apply -var-file=bingo.tfvars

### Для работы прижения используются сдедующие домены
- **db.info66.ru**: база даных - приватный ip виртуалки bingo-db
- **bingo.info66.ru**: приложение - внешний ip NLB

### Эти DNS записи я создавал взяв ip из консоли управления облаком

### Через 10 минут конейнер bingo_init на виртуалке bingk-db призведет первоначальное наполнение базы данных и создаст индексы. При желании можно использовать любую внешний сервер postgresql через db.info66.ru  c указанием соответствующих переменных в **terraform/bingo.tfvars**

## Для обработки запросов /api/session произвел оптимизацию postgresql по [статье](https://habr.com/ru/companies/slurm/articles/714096/)