#!/usr/bin/env bash
set -eu
mix test && mix sherlock.new.test
