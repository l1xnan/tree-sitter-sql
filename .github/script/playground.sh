#!/bin/bash

set -eEu

timeout 30s npm run start &
job=$!

while ! nc -z localhost 8000; do
  sleep 0.5
done

echo "Playground files downloaded."
wget -P playground -nH -r http://127.0.0.1:8000/{,tree-sitter.js,tree-sitter.wasm,tree-sitter-parser.wasm}
sed -i 's,LANGUAGE_BASE_URL = "";,LANGUAGE_BASE_URL = new URL(window.location.href).pathname;,' playground/index.html
# TAG=${TAG:-$(git describe --tags --abbrev=0)}
# sed -i "s,sql,sql ${TAG}," playground/index.html

wait $job || exit 0
