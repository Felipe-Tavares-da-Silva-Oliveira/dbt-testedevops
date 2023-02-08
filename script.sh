#!/bin/sh
dbt seed --target dev --profiles-dir .
dbt seed --target prod --profiles-dir .
dbt deps --profiles-dir .  # Pulls the most recent version of the dependencies listed in your packages.yml from git
dbt debug --target dev --profiles-dir .
dbt debug --target prod --profiles-dir .
dbt run --target prod --profiles-dir .
dbt test --target prod --profiles-dir .
dbt docs generate --no-compile --target dev --profiles-dir .
gsutil cp /dbt/docs/* gs://dbt_testeintegration/
