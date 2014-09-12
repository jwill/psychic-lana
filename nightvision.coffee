

Canvas = require('canvas')

Image = Canvas.Image

fs = require('fs')

mask = fs.readFileSync(__dirname + '/mask.png')
maskImg = new Image
maskImg.src = mask



allTheThings = (filename) ->
  image = fs.readFileSync(__dirname + '/images/'+filename)
  img = new Image
  img.src = image
  
  canvas = new Canvas(1920, 1080)
  c2 = new Canvas(1920, 1080)
  ctx = canvas.getContext("2d")
  c2ctx = c2.getContext("2d")
  
  brightness = 0.2
  makePixelNightVision = (r,g,b,a) ->
          # Green
          g = (b * 0.1 + (g * brightness + r * 0.2))
          # Red
          r = 0
          
          # Blue
          b = 0
          return [r,g,b,a]
        
  doIt = () ->
          imageData = ctx.getImageData(0,0, 1920, 1080)
          length = imageData.data.length / 4
          for i in [0..length]
              r = imageData.data[i * 4 + 0]
              g = imageData.data[i * 4 + 1]
              b = imageData.data[i * 4 + 2]
              a = imageData.data[i * 4 + 3]
              pixel = makePixelNightVision(r, g, b, a)
              imageData.data[i * 4 + 0] = pixel[0]
              imageData.data[i * 4 + 1] = pixel[1]
              imageData.data[i * 4 + 2] = pixel[2]
              imageData.data[i * 4 + 3] = pixel[3]
              
          ctx.putImageData(imageData, 0, 0)
          c2ctx.drawImage(maskImg, 0, 0)
        
        
        
  mask = (mainCtx) -> 
          mainCtx.globalCompositeOperation = 'destination-out'
          mainCtx.drawImage(maskImg, 0, 0)
        
  ctx.drawImage(img, 0, 0)
  console.log("image load")
  doIt()
  mask(ctx)
  
  out = fs.createWriteStream(__dirname + '/out/'+filename)
  stream = canvas.createPNGStream()
  
  stream.on('data', (chunk) ->
    out.write(chunk)  
  )
  
  # Get filenames
filenames = fs.readdirSync(__dirname+'/images')

for n in filenames
  allTheThings(n)