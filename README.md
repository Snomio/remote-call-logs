# Snom Remote Call logs PoC

This small application is implementing a remote call log.
Call logs data are store in a JSON file, from your browser you can create log entries, the entries will be accessible from the phone UI.
The phone can also delete a single entry or clear-out a foll call list.

## Intallation

This application runs on [https://bottlepy.org](bottle.py), a small Python web framework, in order to run the application you need the bottle package installed.
You can install bottle with pip: `pip install bottle`, if you prefer you can also run the application in a Python [https://docs.python.org/3/tutorial/venv.html](virtual environment).

Once bottle is installed you can execute the application:

   $ python app.py 
   Bottle v0.12.16 server starting up (using WSGIRefServer())...
   Listening on http://0.0.0.0:8080/
   Hit Ctrl-C to quit.

By default bottle runs on the port `8080`.

## Using the application

Once the application started you can access the call logs with your browser connecting to the bottle listening address and port:

![img/index.png](The main page)

This page is listing all the call logs, from here you can add or remove entries to the call logs.

## Snom phone configuration

The next step is to configure the phone in order to use the call logs: to do that you should configure the phone with the following settings:

- the call logs fkey must be defined as [https://service.snom.com/display/wiki/Function+Key+Types](Action URL) downloading the `/lists/missed` page
- the redial key must be configured as [https://service.snom.com/display/wiki/Function+Key+Types](Action URL) downloading the `/lists/dialed` page

The page `/settings.xml` is already configuring the 1st soft key as call log button and the OK key as a redial button.


