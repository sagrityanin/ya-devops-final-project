import requests
from time import time

start_time = time()

for i in range(100):
    url = f"http://bingo.info66.ru/api/session/{i}"

    # url = f"http://158.160.118.183:8000/api/customer/{i}"
    res = requests.get(url)
    if res.status_code != 200:
        print(res.status_code)
    else:
        print(i)

print(f"Spend time: {time() - start_time} sec")