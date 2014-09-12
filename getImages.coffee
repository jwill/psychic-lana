#!/usr/local/bin/coffee
ffmpeg = require('fluent-ffmpeg')
fs = require 'fs-extra'

console.log(process.argv)

# Export to images
# remove -t 4 in prod
getImages = () ->
   fs.mkdirsSync('images')
   console.log("Get images")
   ffmpeg('./WhatWeWillBuild.mp4').inputOptions('-t 2').size('1920x1080').outputOptions('-r 29.97').on('error', (err) ->
        console.log('An error occurred: ' + err.message);
   ).on('end', () ->
       console.log('done')
   ) .on('progress', (progress) ->
       console.log('Processing: ' + progress.timemark) 
   ).save('images/image-%3d.png')

getImages()
