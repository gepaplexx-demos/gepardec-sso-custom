# local setup 
## build container image 
```shell
podman build -t gepardec-sso-custom:local -f ./Containerfile .
```
```shell
podman network create gepardec-sso-custom
```
```shell
podman run -d --name gepardec-soo-postgres --network=gepardec-sso-custom -e POSTGRES_DB=keycloak -e POSTGRES_PASSWORD=keycloak@123 -e POSTGRES_USER=keycloak -p 5432:5432 postgres:15
```
```shell
podman run -d --name gepardec-sso-custom --rm --network=gepardec-sso-custom -e KC_HTTP_ENABLED=true \
           -e KC_DB_USERNAME=keycloak \
           -e KC_DB_PASSWORD=keycloak@123 \
           -e KC_DB_URL=jdbc:postgresql://gepardec-soo-postgres:5432/keycloak \
           -e KC_HTTP_PORT=8080 \
           -e KEYCLOAK_ADMIN=admin \
           -e KEYCLOAK_ADMIN_PASSWORD=admin@123 \
           -e KC_HOSTNAME_ADMIN_URL=http://localhost:8080 \
           -e KC_HOSTNAME_URL=http://localhost:8080 \
           -p 8080:8080 gepardec-sso-custom:local

```