# Geo Location App

## Pre-requisites
- Install pipenv

## Install requirements

```
pipenv shell
pipenv install
```

## Run server

```
# macos has something running on 5000 already
FLASK_RUN_PORT=8888 flask run --host=0.0.0.0
```

## Test

This will test with adding a header for `x-forwarded-for` with your own IP, when deployed this will be added by the load balancer
```
curl localhost:8888 -H "x-forwarded-for: $(curl -4 ifconfig.me)"
```

## Docker image

### Building and running locally

```
docker build . -t cbrothers-app:latest
docker run -e "ENVIRONMENT=dev" -p 8888:8888 cbrothers-app
```

### Building and pushing to ECR
First ensure the repository is created and log in to it
```
aws ecr create-repository \
    --repository-name cbrothers-app \
    --image-scanning-configuration scanOnPush=true
aws ecr get-login-password | docker login --username AWS --password-stdin $AWS_ACCOUNT_ID.dkr.ecr.$AWS_REGION.amazonaws.com
```

Then build and push the image to ECR
```
docker build . -t 329082085800.dkr.ecr.us-east-2.amazonaws.com/cbrothers-app:latest
docker push 329082085800.dkr.ecr.us-east-2.amazonaws.com/cbrothers-app:latest
```

Alternatively use `docker buildx` for multi or different platform builds
```
 docker buildx build --platform linux/amd64 -t 329082085800.dkr.ecr.us-east-2.amazonaws.com/cbrothers-app:0.1.0 --push .
```
