#!/bin/bash

repos="$(curl -s https://api.github.com/search/repositories?q=singer%20in:name,description+org:Yoast&per_page=100)"
echo "$repos" | jq '.items[].name' | while read i; do
    python3 -m venv "$i" 
    /opt/airflow/singer/$i/bin/pip install --no-user git+https://github.com/Yoast/$i
done

