FROM alpine:latest AS integration

RUN apk add --no-cache git

ARG INTEGRATION_REF=main

RUN git clone \
    --depth 1 \
    --branch "${INTEGRATION_REF}" \
    https://github.com/KeldorDE/Home-Assistant-AV-Access.git \
    /source

RUN test -f /source/custom_components/av_access/manifest.json


FROM ghcr.io/home-assistant/base:latest

ARG BUILD_VERSION
ARG BUILD_ARCH

LABEL \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.type="app" \
    io.hass.arch="${BUILD_ARCH}"

COPY --from=integration \
    /source/custom_components/av_access \
    /integration/av_access

COPY run.sh /
RUN chmod a+x /run.sh

CMD ["/run.sh"]
