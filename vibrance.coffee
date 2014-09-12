Canvas = require('canvas')

Image = Canvas.Image

fs = require('fs')
amount = 0.55

allTheThings = (filename) ->
  image = fs.readFileSync(__dirname + '/images/'+filename)
  img = new Image
  img.src = image
  canvas = new Canvas(1920, 1080)
  ctx = canvas.getContext("2d")
  
  makePixelVibrant = (r,g,b,a) ->
    # adapted from glfx.js vibrant filter
    avg = (r + g + b) / 3.0
    mx = Math.max(r, Math.max(g, b))
    amt = (mx/255 * avg/255) * (-amount * 3.0)
    
    # calculate line distance
    #dst = Math.sqrt(Math.pow(r - mx, 2) + Math.pow(g - mx, 2) + Math.pow(b - mx, 2))
    
    rs = r + (amt *(mx - r)) 
    gs = g + (amt *(mx - g)) 
    bs = b + (amt *(mx - b)) 
    
    return [rs,gs,bs,a]
        
  doIt = () ->
          imageData = ctx.getImageData(0,0, 1920, 1080)
          length = imageData.data.length / 4
          for i in [0..length]
              r = imageData.data[i * 4 + 0]
              g = imageData.data[i * 4 + 1]
              b = imageData.data[i * 4 + 2]
              a = imageData.data[i * 4 + 3]
              pixel = makePixelVibrant(r, g, b, a)
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