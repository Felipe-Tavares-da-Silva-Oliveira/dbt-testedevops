#!/bin/sh
dbt seed --target dev --profiles-dir .
dbt seed --target prod --profiles-dir .
dbt deps --profiles-dir .  # Pulls the most recent version of the dependencies listed in your packages.yml from git
dbt debug --target dev --profiles-dir .
dbt debug --target prod --profiles-dir .
dbt run --target prod --profiles-dir .
dbt test --target prod --profiles-dir .
dbt docs generate --no-compile --target dev --profiles-dir .

current_path=`cat dbt_project.yml | grep -i name | awk -F: '{print $2}' | tr -d "\'" | tr -d "\''" | awk '{sub(" ","")}1'`
echo "current path é $current_path"
ls ./target

gcloud auth activate-service-account --key-file=/secrets/dbt-service-keyfile

pathbucket="gs://dbt_testeintegration/$current_path/"
gsutil cp ./target/catalog.json pathbucket
