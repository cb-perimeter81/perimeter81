import json
import os
import requests

from flask import Flask, request, render_template

environment = os.environ['ENVIRONMENT'];
environment = environment if environment is not None else 'dev'

app = Flask(__name__)

def getLocation(ip):
    response = requests.get(f'https://ipapi.co/{ip}/json/').json()
    if response.get('error') == True:
        return "Error from ipapi: %s" % response.get('reason')
    else:
        return "Location %s %s %s, Latitude: %s Longitude: %s" % response.get('city'), response.get('region'), response.get('country'), response.get('latitude'), response.get('longitude')

@app.route("/")
@app.route("/index.html")
def index():
    forwardedFor = request.headers.get('x-forwarded-for')
    ip = forwardedFor if forwardedFor is not None else request.remote_addr
    location = getLocation(ip)
    return render_template('index.html', environment=environment, ip=ip, location=location)
