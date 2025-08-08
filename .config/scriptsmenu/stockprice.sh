#!/bin/bash

# This script uses dmenu to search for stock prices on Yahoo Finance.

# Prompt the user for a stock ticker symbol using dmenu
ticker=$(echo "" | dmenu -p "Enter stock ticker symbol (e.g., AAPL):")

# Check if the user entered a ticker
if [ -z "$ticker" ]; then
    echo "No ticker entered. Exiting."
    exit 1
fi

# Construct the Yahoo Finance URL
yahoo_url="https://finance.yahoo.com/quote/$ticker"

# Open the URL in the default web browser
# You can replace 'xdg-open' with your preferred browser command if needed
# For example: 'firefox', 'google-chrome', 'brave-browser', etc.
xdg-open "$yahoo_url" &

echo "Opening Yahoo Finance for $ticker..."
