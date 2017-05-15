#!/usr/bin/env bash
set -eu
mix test
(cd example_dashboard && mix test)
