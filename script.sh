#!/bin/sh
dbt seed --target dev --profiles-dir .
dbt seed --target prod --profiles-dir .
dbt deps --profiles-dir .  # Pulls the most recent version of the dependencies listed in your packages.yml from git
dbt debug --target dev --profiles-dir .
dbt debug --target prod --profiles-dir .
dbt run --target prod --profiles-dir .
dbt test --target prod --profiles-dir .
dbt docs generate --no-compile --target dev --profiles-dir .

echo 'start collect path'
IFS=/
current_path1=$(pwd)
current_path2=${current_path1[-1]}

echo $current_path2 'path para salvar a docs.json'

ls ./target
ls /secrets/dbt-service-keyfile
gcloud auth activate-service-account --key-file=/secrets/dbt-service-keyfile
gsutil cp -r ./target/catalog.json gs://dbt_testeintegration/$current_path2
