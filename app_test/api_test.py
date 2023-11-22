import requests
from time import time

start_time = time()

for i in range(1000):
    url = f"http://127.0.0.1:32531/api/customer/{i}"
    res = requests.get(url)
    if res.status_code != 200:
        print(res.status_code)

print(f"Spend time: {time() - start_time} sec")