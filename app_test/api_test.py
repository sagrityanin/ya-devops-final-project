import requests
from time import time

start_time = time()

for i in range(100):
    url = f"http://158.160.134.169:80/api/customer/{i}"
    res = requests.get(url)
    if res.status_code != 200:
        print(res.status_code)
    else:
        print(i)

print(f"Spend time: {time() - start_time} sec")