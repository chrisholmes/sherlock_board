#!/usr/bin/env bash
set -eu
set -o pipefail
yarn run compile
mix test
(cd example_dashboard && ./pre-commit.sh)
(cd installer && ./pre-commit.sh)
