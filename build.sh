#!/bin/bash -e

function deps {
  uglifyjs \
    node_modules/jquery/dist/jquery.min.js \
    lib/blueimp-gallery.min.js \
    node_modules/riot/riot.min.js \
    -o tmp/deps.js
}

function tags {
  riot tags/ tmp/tags.js
}

function app {
  deps
  tags
  uglifyjs tmp/deps.js tmp/tags.js boot.js -o public/app.js
}

$1
