#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <target> <wordlist>"
    exit 1
fi

target="$1"
wordlist_path="$2"

if [ ! -f "$wordlist_path" ]; then
    echo "Wordlist file '$wordlist_path' not found."
    exit 1
fi

while read -r word; do
    url="http://$target/$word"
    response=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    
    if [ "$response" == "200" ]; then
        echo "Found: $url"
    fi
done < "$wordlist_path"
