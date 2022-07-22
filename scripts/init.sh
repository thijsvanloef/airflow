#!/bin/sh

repos="$(curl -s https://api.github.com/search/repositories?q=singer%20in:name,description+org:Yoast&per_page=100)"
echo "$repos" | jq '.items[].name' | while read -r i; do
    repo=$(echo "$i" | tr -d '"')
    python3 -m venv "$repo" 
    /opt/airflow/singer/"$repo"/bin/python3 -m pip install --no-user --upgrade pip 
    /opt/airflow/singer/"$repo"/bin/pip install --no-user git+https://github.com/Yoast/"$repo" || ( echo "Error: repository not found" && exit 1 )
done

