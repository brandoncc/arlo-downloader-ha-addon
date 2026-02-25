#!/usr/bin/with-contenv bashio

ARLO_USERNAME="$(bashio::config 'arlo_username')"
ARLO_PASSWORD="$(bashio::config 'arlo_password')"
MEDIA_FOLDER="$(bashio::config 'media_folder')"
TFA_TYPE="$(bashio::config 'tfa_type')"
TFA_SOURCE="$(bashio::config 'tfa_source')"
TFA_RETRIES="$(bashio::config 'tfa_retries')"
TFA_DELAY="$(bashio::config 'tfa_delay')"

export ARLO_USERNAME ARLO_PASSWORD

if bashio::config.true 'debug'; then
  export DEBUG=1
fi

ARGS=(
  --save-media-to "$MEDIA_FOLDER"
  --tfa-type "$TFA_TYPE"
  --tfa-source "$TFA_SOURCE"
  --tfa-retries "$TFA_RETRIES"
  --tfa-delay "$TFA_DELAY"
)

if bashio::config.has_value 'tfa_host'; then
  ARGS+=(--tfa-host "$(bashio::config 'tfa_host')")
fi
if bashio::config.has_value 'tfa_username'; then
  ARGS+=(--tfa-username "$(bashio::config 'tfa_username')")
fi
if bashio::config.has_value 'tfa_password'; then
  ARGS+=(--tfa-password "$(bashio::config 'tfa_password')")
fi

bashio::log.info "Starting Arlo Downloader..."
bashio::log.info "Media folder: ${MEDIA_FOLDER}"
bashio::log.info "TFA type: ${TFA_TYPE}"

exec python3 /arlo-downloader/arlo-downloader.py "${ARGS[@]}"
