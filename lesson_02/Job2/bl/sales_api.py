import json
import os
import shutil
from fastavro import writer, parse_schema


def save_sales_to_avro(raw_dir: str, stg_dir: str) -> None:
    try:
        shutil.rmtree(stg_dir)
    except FileNotFoundError:
        pass
    os.makedirs(stg_dir)
    for filename in os.listdir(raw_dir):
        with open(os.path.join(raw_dir, filename)) as input_file:
            data = json.load(input_file)
            schema = {
                'doc': 'sales',
                'name': 'sales',
                'namespace': 'test',
                'type': 'record',
                'fields': [
                    {'name': 'client', 'type': 'string'},
                    {'name': 'purchase_date', 'type': 'string'},
                    {'name': 'product', 'type': 'string'},
                    {'name': 'price', 'type': 'int'},
                ],
            }
            parsed_schema = parse_schema(schema)
            basename = os.path.splitext(filename)[0]
            with open(os.path.join(stg_dir, basename + '.avro'), 'wb') as output_file:
                writer(output_file, parsed_schema, data)