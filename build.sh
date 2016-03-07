#!/bin/bash -e

function deps {
  uglifyjs \
    node_modules/jquery/dist/jquery.min.js \
    lib/blueimp-gallery.min.js \
    node_modules/riot/riot.min.js \
    -o tmp/deps.js
}

$1
