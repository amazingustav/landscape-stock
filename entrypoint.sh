#!/bin/bash -e

set -e
# Remove a potentially pre-existing server.pid for Rails.
rm -f /landscape/tmp/pids/server.pid

exec "${@}"
