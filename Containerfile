FROM library/maven:3.8.6-openjdk-18-slim as provider-builder
WORKDIR /
ADD . /
RUN mvn clean install -Drevision=$(cat version)

FROM quay.io/keycloak/keycloak:20.0.3 as builder
COPY --from=provider-builder /target/*.jar /opt/keycloak/providers/
RUN /opt/keycloak/bin/kc.sh build \
    --db postgres \
    --transaction-xa-enabled false \
    --health-enabled true \
    --metrics-enabled true \
    --features=openshift-integration
CMD ["start", "--optimized"]