import requests
from time import time, sleep

start_time = time()

for i in range(1000):
    # url = f"http://bingo.info66.ru/db_dummy"

    url = f"http://127.0.0.1/api/customer/{i}"
    res = requests.get(url)
    if res.status_code != 200:
        print(res.status_code)
    else:
        print(i)
    sleep(0.5)

print(f"Spend time: {time() - start_time} sec")