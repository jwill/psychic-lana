Support libraries for the Visual effects made in UD292

==============

The scripts in this repository were used to create many of the visual effects in
ud292. Sure any of these effects could be done with the run of the mill video
editor but doing them with JavaScript is fun because you can. 

To make things
more sane to run programmatically, I've taken some liberties from time to time
like choosing to run the code on Node.js or by using a library that implements
the Canvas API with a couple key changes. As a result, you can not just open up
a browser window and drop the code in and expect it to run. You will need to
install several libraries (listed below), some of which will compile themselves
as a part of the installation process

A summary of what they do is as follows:

```chromakey``` - Replaces colors in a source image and saves them as transparent pixels. <br/>
```composite``` - Takes two source images and creates a composite image of the two. <br/>
```getImages``` - Gets the individual frames from a video file and saves them as lossless PNG files. <br/>
```grayscale``` - Averages color data from image to create a grayscale image. <br/>
```invertColor``` - Invert the color values in an image. <br/>
```nightvision``` - Scales colors on the green range to create a night vision effect. Composites a mask image over it. <br/>
```removeImages``` - Simple clean up script to delete all images in a directory. <br/>
```saveToVideo``` - Takes a directory of images and encodes them to a video file. <br/>
```vibrance```     - Adjust color hue/saturation values. <br/>


To Install:

1. Install [node.js](http://nodejs.org/download/)
2. Install [FFMPEG](https://www.ffmpeg.org/download.html)
3. Install [Cairo](http://cairographics.org/download/).
4. Download this repository and extract it somewhere.
5. Run ```npm install``` to install all the dependencies.
