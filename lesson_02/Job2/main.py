"""
This file contains the controller that accepts command via HTTP
and trigger business logic layer
"""
import os
from flask import Flask, request
from flask import typing as flask_typing

from bl.sales_api import save_sales_to_avro

app = Flask(__name__)


@app.route('/', methods=['POST'])
def main() -> flask_typing.ResponseReturnValue:
    """
    Controller that accepts command via HTTP and
    trigger business logic layer

    Proposed POST body in JSON:
    {
      "data: "2022-08-09",
      "raw_dir": "/path/to/my_dir/raw/sales/2022-08-09"
    }
    """
    input_data: dict = request.json
    # TODO: implement me
    raw_dir = input_data.get('raw_dir')
    stg_dir = input_data.get('stg_dir')

    save_sales_to_avro(raw_dir=raw_dir, stg_dir=stg_dir)

    return {
               "message": "Data successfully copied to avro",
           }, 201


if __name__ == "__main__":
    app.run(debug=True, host="localhost", port=8082)