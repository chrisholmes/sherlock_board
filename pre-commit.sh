#!/usr/bin/env bash
set -eu
set -o pipefail
mix test
(cd example_dashboard && mix deps.get && mix test)
(cd installer && mix deps.get && mix test)
