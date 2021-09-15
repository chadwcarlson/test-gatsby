#!/usr/bin/env bash

echo $1
echo $2

python <<EOP
import yaml

with open('.platform/applications.yaml', 'r') as file:
    data = yaml.safe_load(file)
    print(data[0]['dependencies']['nodejs']['yarn']) 
EOP