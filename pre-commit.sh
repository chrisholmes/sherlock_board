#!/usr/bin/env bash
set -eu
mix test
(cd example_dashboard && mix deps.get && mix test)
(cd installer && mix deps.get && mix test && mix sherlock.new.test)
