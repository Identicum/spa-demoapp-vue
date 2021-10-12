# spa-demoapp-vue

Public SPA demo app using VueJS.
The app makes the call to the endpoint ```/api/v1/products``` in order to get products.

## Clone repo

```sh
git clone git@github.com:https://github.com/Identicum/spa-demoapp-vue.git
```

## Test environment

For a quick test, run the preset docker compose environment
```sh
docker-compose up
```
To be able to use this environment, you need to add this line to your local HOSTS file:
```sh
127.0.0.1  spa  idp  api
```
To access the SPA in the environment go to this URL: <http://spa/>

To see a reference of the architecture and diagrams, check [the docs](./docs/).

## Configure and run

Compile & run:
```sh
npm run serve
```
You can access the UI on <http://hostname:8080/>

