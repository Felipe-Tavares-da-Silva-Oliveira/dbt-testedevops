FROM python:3.8-slim-buster
WORKDIR /app
COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt
EXPOSE 8080

FROM ghcr.io/dbt-labs/dbt-bigquery:1.3.latest
USER root
WORKDIR /dbt
COPY script.sh ./
COPY . ./

# Downloading gcloud package
RUN apt-get update && apt-get install -y curl

RUN curl https://dl.google.com/dl/cloudsdk/release/google-cloud-sdk.tar.gz > /tmp/google-cloud-sdk.tar.gz

# Installing the package
RUN mkdir -p /usr/local/gcloud \
  && tar -C /usr/local/gcloud -xvf /tmp/google-cloud-sdk.tar.gz \
  && /usr/local/gcloud/google-cloud-sdk/install.sh

# Adding the package path to local
ENV PATH $PATH:/usr/local/gcloud/google-cloud-sdk/bin


ENTRYPOINT ["gunicorn", "-w", "4", "-b", "0.0.0.0:8080", "app:app"]
