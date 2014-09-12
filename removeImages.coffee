#!/usr/local/bin/coffee
fs = require 'fs-extra'

# Remove Images
removeImages = () ->
    console.log("Remove images")
    fs.removeSync('images')

removeImages()
