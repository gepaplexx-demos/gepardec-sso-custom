FROM library/maven:3.8.5-openjdk-17 as provider-builder
WORKDIR /
ADD . /
RUN mvn clean install -Drevision=$(cat version)

FROM quay.io/keycloak/keycloak:19.0.2 as builder
COPY --from=provider-builder /target/*.jar /opt/keycloak/providers/
RUN /opt/keycloak/bin/kc.sh build \
    --db postgres \
    --transaction-xa-enabled false \
    --health-enabled true \
    --metrics-enabled true
CMD ["start", "--optimized"]