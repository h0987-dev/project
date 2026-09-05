#!/usr/bin/env bash

set -euo pipefail

read -r -p "Enter principal amount: " principal
read -r -p "Enter annual rate of interest (%): " rate
read -r -p "Enter time period (years): " time

if ! [[ "$principal" =~ ^[0-9]+([.][0-9]+)?$ && "$rate" =~ ^[0-9]+([.][0-9]+)?$ && "$time" =~ ^[0-9]+([.][0-9]+)?$ ]]; then
    printf 'Please enter valid non-negative numbers.\n' >&2
    exit 1
fi

interest=$(awk -v principal="$principal" -v rate="$rate" -v time="$time" 'BEGIN { printf "%.2f", principal * rate * time / 100 }')
total=$(awk -v principal="$principal" -v interest="$interest" 'BEGIN { printf "%.2f", principal + interest }')

printf 'Simple interest: %s\n' "$interest"
printf 'Total amount: %s\n' "$total"
