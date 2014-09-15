#!/usr/local/bin/coffee
ffmpeg = require('fluent-ffmpeg')
fs = require 'fs-extra'
argv = require('minimist')(process.argv.slice(2))

inputPath = "input.mp4"

inputPath = if argv.i? then argv.i else "input.mp4"
outputPath = if argv.o? then argv.o else "imagesx"

# Export to images
# remove -t 4 in prod
getImages = () ->
   fs.mkdirsSync('images')
   console.log("Get images")
   ffmpeg(inputPath).inputOptions('-t 2').size('1920x1080').outputOptions('-r 29.97').on('error', (err) ->
        console.log('An error occurred: ' + err.message)
   ).on('end', () ->
       console.log('done')
   ) .on('progress', (progress) ->
       console.log('Processing: ' + progress.timemark)
   ).save(outputPath+'/image-%3d.png')

getImages()
