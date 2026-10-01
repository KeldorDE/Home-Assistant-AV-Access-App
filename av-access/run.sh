#!/usr/bin/with-contenv bashio

set -euo pipefail

SOURCE="/integration/av_access"
CUSTOM_COMPONENTS="/homeassistant/custom_components"
TARGET="${CUSTOM_COMPONENTS}/av_access"
TEMP="${CUSTOM_COMPONENTS}/.av_access_install"

bashio::log.info "Starting AV Access installer..."

if [ ! -d "/homeassistant" ]; then
    bashio::log.error "Home Assistant configuration directory not found."
    exit 1
fi

if [ ! -f "${SOURCE}/manifest.json" ]; then
    bashio::log.error "AV Access integration files not found in the app image."
    exit 1
fi

SOURCE_VERSION="$(jq -r '.version' "${SOURCE}/manifest.json")"
INSTALLED_VERSION=""

if [ -f "${TARGET}/manifest.json" ]; then
    INSTALLED_VERSION="$(jq -r '.version' "${TARGET}/manifest.json")"
fi

bashio::log.info "Bundled integration version: ${SOURCE_VERSION}"

if [ -n "${INSTALLED_VERSION}" ]; then
    bashio::log.info "Installed integration version: ${INSTALLED_VERSION}"
else
    bashio::log.info "No existing AV Access integration detected."
fi

if [ "${SOURCE_VERSION}" != "${INSTALLED_VERSION}" ]; then
    bashio::log.info "Installing AV Access integration..."

    mkdir -p "${CUSTOM_COMPONENTS}"

    rm -rf "${TEMP}"
    mkdir -p "${TEMP}"

    cp -a "${SOURCE}/." "${TEMP}/"

    if [ -d "${TARGET}" ]; then
        bashio::log.info "Replacing existing installation..."
        rm -rf "${TARGET}"
    fi

    mv "${TEMP}" "${TARGET}"

    bashio::log.info "AV Access integration ${SOURCE_VERSION} installed successfully."
    bashio::log.info "Restarting Home Assistant..."

    curl \
        --silent \
        --show-error \
        --fail \
        --request POST \
        --header "Authorization: Bearer ${SUPERVISOR_TOKEN}" \
        --header "Content-Type: application/json" \
        http://supervisor/core/restart \
        > /dev/null

    bashio::log.info "Home Assistant restart requested."
else
    bashio::log.info "AV Access integration is already up to date."
fi

bashio::log.info "AV Access app is running."

while true; do
    sleep 86400
done