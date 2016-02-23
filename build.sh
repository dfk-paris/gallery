#!/bin/bash -e

function deps {
  uglifyjs \
    node_modules/zepto/zepto.min.js \
    node_modules/riot/riot.min.js \
    -o tmp/deps.js
}

$1
