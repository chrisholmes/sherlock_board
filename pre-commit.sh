#!/usr/bin/env bash
set -eu
set -o pipefail
mix test
(cd example_dashboard && mix test)
(cd installer && mix test)
