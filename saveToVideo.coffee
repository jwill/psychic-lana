#!/usr/local/bin/coffee
ffmpeg = require('fluent-ffmpeg')
fs = require 'fs-extra'
argv = require('minimist')(process.argv.slice(2))

inputPath = if argv.i? then argv.i else "images"
outputPath = if argv.o? then argv.o else "output.mp4"

# Save to video
saveToVideo = () ->
    console.log("Save to video")
    ffmpeg(inputPath+'/image-%3d.png').fps(29.97).size('1920x1080').on('error', (err) ->
        console.log('An error occurred: ' + err.message);
     ).on('end', () ->
       console.log('Done')
     ).save(outputPath)

saveToVideo()
