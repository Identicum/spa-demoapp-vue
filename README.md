# spa-demoapp-vue

Public SPA demo app using VueJS.
The app makes the call to the endpoint ```/api/v1/products``` in order to get products.

:::mermaid
sequenceDiagram

actor Browser

Browser->SPA: GET /
SPA->SPA: Check lua-resty-openidc session
SPA->Browser: redirect to authorization_endpoint
Browser->IDP: /auth
IDP->Browser: Prompt credentials
Browser->IDP: Submit credentials
IDP->IDP: Create authenticated session
IDP->Browser: redirect to /redirect_uri
Browser->SPA: /redirect_uri
SPA->SPA: Create authenticated session
SPA->Browser: Set cookie + return /index.html
Browser->SPA: GET /api/v1/products (with cookie)
SPA->API: GET /api/v1/products (with access_token)
API->SPA: return JSON
SPA->Browser: return JSON
:::

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

To see a reference of the architecture, check [the docs](./docs/).

