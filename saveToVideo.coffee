#!/usr/local/bin/coffee
ffmpeg = require('fluent-ffmpeg')
fs = require 'fs-extra'

console.log(process.argv)

# Save to video
saveToVideo = () ->
    console.log("Save to video")
    ffmpeg('images/image-%3d.png').fps(29.97).size('1920x1080').on('error', (err) ->
        console.log('An error occurred: ' + err.message);
     ).on('end', () ->
       console.log('Done')
     ).save('output.mp4')

saveToVideo()
