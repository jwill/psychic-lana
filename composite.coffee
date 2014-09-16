argv = require('minimist')(process.argv.slice(2))

Canvas = require('canvas')

Image = Canvas.Image

console.log(argv)
inputPath = if argv.i? then argv.i else "images"
inputPath2 = if argv.j? then argv.j else "images2"

outputPath = if argv.o? then argv.o else "out"

fs = require('fs')

allTheThings = (filename) ->
  image = fs.readFileSync(__dirname + '/'+inputPath+'/'+filename)
  image2 = fs.readFileSync(__dirname + '/'+inputPath2+'/'+filename)
  img = new Image
  img.src = image
  img2 = new Image
  img2.src = image2
  console.log("image load")

  canvas = new Canvas(1920, 1080)
  ctx = canvas.getContext("2d")

  ctx.drawImage(img, 0, 0)
  ctx.drawImage(img2, 0, 0)
  

  out = fs.createWriteStream(__dirname + '/'+outputPath+'/'+filename)
  stream = canvas.createPNGStream()

  stream.on('data', (chunk) ->
    out.write(chunk)
    console.log("Done writing image.")
  )

# Get filenames
filenames = fs.readdirSync(__dirname+'/'+inputPath)

for n in filenames
  allTheThings(n)
