# Task Manager

### Summary

This task management app is a simple demo of "API only mode" available in Rails 5. You can make JSON calls to the app to create, read, edit, delete tasks, and add users to a task. All requests must be authorized with a token, which you can get by creating a user. The demo is hosted at https://redesigned-eureka.herokuapp.com

### Usage

Requests must be authenticated with a token. You can obtain a token by creating a new user or logging in as an existing user.

Add a task:

curl -v -H "Accept: application/json" -H "Authorization:0snJYIqpiml0ny5wbKWSyw" -H "Content-type: application/json" -X POST -d ' {"task": {"title":"Cool title", "description":"Sweet description"} }' https://redesigned-eureka.herokuapp.com/tasks

Show all tasks:

curl -v -H "Accept: application/json" -H "Authorization:0snJYIqpiml0ny5wbKWSyw" -H "Content-type: application/json" -X GET -d ' {}' https://redesigned-eureka.herokuapp.com/tasks

Show a task (and show names of users attached to task):

curl -v -H "Accept: application/json" -H "Authorization:0snJYIqpiml0ny5wbKWSyw" -H "Content-type: application/json" -X GET -d ' {}' https://redesigned-eureka.herokuapp.com/tasks/5

Edit a task:

curl -v -H "Accept: application/json" -H "Authorization:0snJYIqpiml0ny5wbKWSyw" -H "Content-type: application/json" -X PATCH -d ' {"task": {"title":"New title", "description":"New description"} }' https://redesigned-eureka.herokuapp.com/tasks/5

Delete a task:

curl -v -H "Accept: application/json" -H "Authorization:0snJYIqpiml0ny5wbKWSyw" -H "Content-type: application/json" -X DELETE -d ' {}' https://redesigned-eureka.herokuapp.com/tasks/4

Create a user with email and password:

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"user": {"name":"Exampleuser Name", "email":"user6@example.com", "password": "pw1234", "password_confirmation":"pw1234"} }' https://redesigned-eureka.herokuapp.com/users

Create a user with a Facebook token 

(Get a FACEBOOK_TOKEN here: https://developers.facebook.com/tools/explorer):

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"user": {"name":"Firstname Lastname", "email":"", "facebook_token":"FACEBOOK_TOKEN"} }' https://redesigned-eureka.herokuapp.com/users

Log in an existing user with email and password and return a fresh authentication token:

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"user": {"name":"Firstname Lastname", "email":"user@example.com", "password": "pw1234", "password_confirmation":"pw1234"} }' https://redesigned-eureka.herokuapp.com/login

Log in an existing user with Facebook token and return a fresh authentication token:

curl -v -H "Accept: application/json" -H "Content-type: application/json" -X POST -d ' {"user": {"name":"Firstname Lastname", "email":"", "facebook_token":"FACEBOOK_TOKEN"} }' https://redesigned-eureka.herokuapp.com/login

Add a user to a task:

curl -v -H "Accept: application/json" -H "Authorization:0snJYIqpiml0ny5wbKWSyw" -H "Content-type: application/json" -X POST -d ' {"user_id": "4" }' https://redesigned-eureka.herokuapp.com/tasks/5/users

