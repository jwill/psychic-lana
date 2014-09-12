

Canvas = require('canvas')

Image = Canvas.Image

fs = require('fs')

allTheThings = (filename) ->
  image = fs.readFileSync(__dirname + '/images/'+filename)
  img = new Image
  img.src = image
  canvas = new Canvas(1920, 1080)
  ctx = canvas.getContext("2d")
  
  makePixelGreyScale = (r,g,b,a) ->
    y = (0.3 * r) + (0.59 * g) + (0.11 * b)
    r = y
    g = y
    b = y
    return [r,g,b,a]
        
  doIt = () ->
          imageData = ctx.getImageData(0,0, 1920, 1080)
          length = imageData.data.length / 4
          for i in [0..length]
              r = imageData.data[i * 4 + 0]
              g = imageData.data[i * 4 + 1]
              b = imageData.data[i * 4 + 2]
              a = imageData.data[i * 4 + 3]
              pixel = makePixelGreyScale(r, g, b, a)
              imageData.data[i * 4 + 0] = pixel[0]
              imageData.data[i * 4 + 1] = pixel[1]
              imageData.data[i * 4 + 2] = pixel[2]
              imageData.data[i * 4 + 3] = pixel[3]
              
          ctx.putImageData(imageData, 0, 0)

        
        
  ctx.drawImage(img, 0, 0)
  console.log("image load")
  doIt()

  out = fs.createWriteStream(__dirname + '/out/'+filename)
  stream = canvas.createPNGStream()
  
  stream.on('data', (chunk) ->
    out.write(chunk)  
  )
  
# Get filenames
filenames = fs.readdirSync(__dirname+'/images')

for n in filenames
  allTheThings(n)