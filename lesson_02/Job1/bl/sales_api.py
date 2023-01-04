import requests
import json
import os
import shutil
import fastavro


def save_sales_to_local_disk(auth_token: str, date: str, raw_dir: str) -> None:
    try:
        shutil.rmtree(raw_dir)
    except FileNotFoundError:
        pass
    os.makedirs(raw_dir)
    page = 1
    data = []
    while True:
        response = requests.get(
            url='https://fake-api-vycpfa6oca-uc.a.run.app/sales',
            params={'date': date, 'page': page},
            headers={'Authorization': auth_token},
            )
        if isinstance(response.json(), dict):
            break
        data += response.json()
        page += 1
    with open(raw_dir + f'/sales_{date}.json', 'w') as output_file:
        json.dump(data, output_file)