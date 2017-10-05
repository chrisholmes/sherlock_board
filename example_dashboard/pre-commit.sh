#!/usr/bin/env bash
set -eu
set -o pipefail
yarn run dev
mix test
