import requests
from time import time, sleep

start_time = time()

for i in range(100):
    url = f"http://bingo.info66.ru/db_dummy"

    # url = f"http://158.160.118.183:8000/api/customer/{i}"
    res = requests.get(url)
    if res.status_code != 200:
        print(res.status_code)
    else:
        print(i)
    sleep(0.5)

print(f"Spend time: {time() - start_time} sec")