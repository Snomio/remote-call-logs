#!/usr/bin/python
# -*- coding: UTF-8 -*-
# -*- Mode: Python -*-

from bottle import abort, Bottle, redirect, run, template, response, request
import bottle
import uuid
import json
import os

bottle.debug(True)

if "WEB_FOLDER" in os.environ.keys():
    web_folder = os.environ['WEB_FOLDER']
else:
    web_folder = ''

data_file = 'data.json'

init_data = {
        "missed":[
            {
                'id':   str(uuid.uuid1()),
                'time': "23:44",
                'date': "05/19/2019",
                'display': "Pietro",
                'number': "1234"
            },
            {
                'id':   str(uuid.uuid1()),
                'time': "24:54",
                'date': "05/19/2019",
                'display': "Luca",
                'number': "567"
            }
            ],
         "dialed":[
            {
                'id':   str(uuid.uuid1()),
                'time': "21:04",
                'date': "07/18/2019",
                'display': "Tony",
                'number': "89871"
            },
            {
                'id':   str(uuid.uuid1()),
                'time': "21:22",
                'date': "05/13/2019",
                'display': "Luke",
                'number': "511"
            }
            ],
         "received":[
            {
                'id':   str(uuid.uuid1()),
                'time': "01:04",
                'date': "01/18/2019",
                'display': "Lamp",
                'number': "89812"
            },
            {
                'id':   str(uuid.uuid1()),
                'time': "03:20",
                'date': "01/11/2018",
                'display': "Rotr",
                'number': "6451"
            }
           ]

        }

icons = {
            'missed': '45', #'kIconTypeCallHistoryMissed',
            'dialed': '46', #'kIconTypeCallHistoryDialed',
            'received': '47' #'kIconTypeCallHistoryReceived',
        }

def read_data():
    with open('data.json') as json_file:
        return json.load(json_file)

def save_data(data):
    with open(data_file, 'w+') as outfile:
        json.dump(data, outfile)
try:
    if os.stat(data_file).st_size == 0:
        save_data(init_data)
except FileNotFoundError:
    save_data(init_data)

app = Bottle()

@app.route('/lists/<list_name>')
@app.route('/lists/<list_name>/<call_id>')
def render_list(list_name="missed",call_id=None):
    data = read_data()
    url_parts = request.urlparts
    request_url = "%s://%s%s" % (url_parts[0], url_parts[1], web_folder)
    response.content_type = 'text/xml'
    if list_name in data.keys():
        if call_id:
            return template('details', call_id=call_id, call_list_name=list_name, call_list=data[list_name], request_url=request_url)
        return template('list', call_list_name=list_name, data=data, request_url=request_url, icon=icons[list_name])
    else:
        abort(404, 'No such list')

@app.route('/')
def index():
    url_parts = request.urlparts
    request_url = "%s://%s%s" % (url_parts[0], url_parts[1], web_folder)
    data = read_data()
    return template('index', data=data, request_url=request_url)

@app.route('/add/<list_name>', method="POST")
def add(list_name=None):
    data = read_data()
    if list_name == None:
        redirect('/')
    call = {
            'id':   str(uuid.uuid1()),
            'time': request.forms.get('time'),
            'date': request.forms.get('date'),
            'display': request.forms.get('display'),
            'number': request.forms.get('number')
            }
    data[list_name].append(call)
    save_data(data)
    redirect('/')

@app.route('/delete/<list_name>/<call_id>/<is_snom>')
@app.route('/delete/<list_name>/<call_id>')
@app.route('/delete/<list_name>')
def delete(list_name=None, call_id=None, is_snom=None):
    data = read_data()
    url_parts = request.urlparts
    request_url = "%s://%s%s" % (url_parts[0], url_parts[1], web_folder)
    if call_id == 'snom':
        data[list_name] = []
    else:
        data[list_name] = [item for item in data[list_name] if item["id"] != call_id]
    save_data(data)
    if is_snom == 'snom' or call_id == 'snom':
        response.content_type = 'text/xml'
        return template('snom_redirect', target = request_url + '/lists/' + list_name, message="Done" , title="Call entry removed", timeout="300")

    redirect('/')

@app.route('/settings.xml')
def settings():
    url_parts = request.urlparts
    request_url = "%s://%s%s" % (url_parts[0], url_parts[1], web_folder)
    response.content_type = 'text/xml'
    return template('settings', request_url=request_url)

run(app, reloader=True, host='0.0.0.0', port=8080)
