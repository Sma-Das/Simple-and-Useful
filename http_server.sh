#!/usr/bin/env bash

$PORT=$1

command -v python &>/dev/null && python -c "import http.server" && python -m http.server $PORT

if [ $? -ne 0 ]; then
    kill -INT $$
else
    command -v python3 &>/dev/null && python3 -c "import http.server" && python3 -m http.server $PORT
fi

if [ $? -ne 0 ]; then
    echo "Failed to create http.server with python"
fi
