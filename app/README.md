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
