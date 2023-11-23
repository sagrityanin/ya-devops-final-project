## Create images
- docker build ./postgres -t cr.yandex/crps6iajan0jje7v30hd/bingo:db
- docker build ./app -t cr.yandex/crps6iajan0jje7v30hd/bingo:init

## Push images
- docker push cr.yandex/crps6iajan0jje7v30hd/bingo:db
- docker push cr.yandex/crps6iajan0jje7v30hd/bingo:init
