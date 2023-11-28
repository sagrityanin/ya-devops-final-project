import requests
from time import time, sleep

start_time = time()

for i in range(1000):
    # url = f"http://bingo.info66.ru/db_dummy"

    url = f"http://51.250.86.239/api/customer/{i}"
    res = requests.get(url)
    if res.status_code != 200:
        print(res.status_code)
    else:
        print(i)
    sleep(1)

print(f"Spend time: {time() - start_time} sec")