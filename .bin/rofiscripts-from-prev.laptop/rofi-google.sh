     #!/bin/bash
     browser=chromium
     query=$(echo "" | rofi -dmenu -p "Google Search:")
     if [[ -n "$query" ]]; then
       $browser "https://www.google.com/search?q=$query"
     fi
