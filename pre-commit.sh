#!/usr/bin/env bash
set -eu
set -o pipefail
mix test
(cd example_dashboard && mix deps.get && yarn install && brunch b && mix test)
(cd installer && mix deps.get && yarn install && brunch b && mix test)
