# Neural-Zoom
---

# Requirements

[Neural-Style](https://github.com/jcjohnson/neural-style) or a [similar style transfer system](https://github.com/jcjohnson/neural-style/wiki/Similar-to-Neural-Style).

ImageMagick can be installed on Ubuntu with:

`sudo apt-get install imagemagick`

FFmpeg for making gifs and mp4 format videos with ImageMagick: 

`sudo apt-get install ffmpeg`



---

# Usage
Copy this script to neural-style directory, then run:

`./neural-zoom.sh input_file style_file zoom_value num_frames`

An example of running the script would be:

`./neural-zoom.sh input.jpg style.png 32 1000000`

Or if you are using [Fast-Neural-Style](https://github.com/jcjohnson/fast-neural-style), run: 

`./fast-neural-zoom.sh input_file model_file zoom_value num_frames`

The script is capable of continuing where you left off if it sees all the previous images up to where you stopped. So it can be a good idea to save all of the images it produces, so that you can always make your gifs/mp4 videos longer.

All of the frames after being run through Neural-Style can be found inside a folder the script creates called "output". 

If you wish to continue where you left off, past the contents of the "output" which contains the uncropped images, into your Neural-Style directory. ~~make sure you save the frames that are outputted into the Neural-Style directory in additon to the frames saved in the output directory.~~  You can also continue where you left off by simply using your last frame as your new content image.

---

# Arguments

`zoom_value`: The number of pixels subtracted from the width and height of your initial content image between each "frame".

`num_frames`: The total number of frames/images you want the script to create.

To adjust the normal style transfer parameters, you either change the Neural-Style parameters on [lines 80-82](https://github.com/ProGamerGov/Neural-Zoom/blob/master/neural-zoom.sh#L80-L82) or the Fast-Neural-Style parameters on [lines 81-82](https://github.com/ProGamerGov/Neural-Zoom/blob/master/fast-neural-zoom.sh#L81-L82).

---

# MP4/GIF Making: 

First, use this `bash` script (modified from [here](https://stackoverflow.com/a/3700146/763127)) to rename your frames to have leading zeroes, so that `ffmpeg` will place them in the correct order.  This script will clone all the frames into a new directory.  (change it to `mv` if you don't want that, but, this is useful for postprocessing without editing the originals.)

Alter the script for the correct postfix for your content, and target directory for your system.

```bash
#!/bin/bash

postfix="_chicago.png"
targetDir="./renamed_frames"
paddingLength=8

for file in [0-9]*${postfix}; do

  # strip the postfix off the file name
  number=${file%$postfix}

  # copy to a new name with padded zeros in a new folder
  cp ${file} "$targetDir"/$(printf %0${paddingLength}d$postfix $number)

done
```

Next, navigate to your output directory and run: 

`convert *.png name.mp4`

or 

`convert *.png name.gif`

---
 
# Troubleshooting

## permission errors

If you face a permission error, try using chmod to fix the issue: 

```bash
chmod u+x ./neural-zoom.sh
chmod u+x ./fast-neural-zoom.sh
```

## cache resources exhausted

The tool `ImageMagick` is intended for network use, and so comes with a resource limit policy file to prevent attacks.  The default policy file in some linuxes, such as `ubuntu`, [has settings too small for image to video work](https://github.com/ImageMagick/ImageMagick/issues/396).

This is probably the problem if you see errors of this form:

```
convert-im6.q16: DistributedPixelCache '127.0.0.1' @ error/distribute-cache.c/ConnectPixelCacheServer/244.
convert-im6.q16: cache resources exhausted `81_chicago.jpg' @ error/cache.c/OpenPixelCache/3945.
```

To fix this, alter your policy file.  Assuming `ImageMagick 6` and the text editor `nano`, you may

```bash
nano -w /etc/ImageMagick-6/policy.xml
```

Then, [as described in this comment](https://github.com/ImageMagick/ImageMagick/issues/396#issuecomment-319569255), near the top of the `<policymap>` tag, comment out the top block of subtags, the `<policy>` tags for `temporary-path`, `memory`, `map`, `area`, `disk`, `file`, `thread`, `throttle`, and `time`.

If this is on a server being used over the network, set to larger limits instead of commenting out.

--- 

# Example Outputs

https://i.imgur.com/UCWl54o.gifv

![](https://i.imgur.com/jcO0qpN.gif)

Zoom value of 5:

https://i.imgur.com/1880gPU.gifv

Zoom value of 37.5:

https://gfycat.com/HighlevelThinIndianpangolin

GIMP Auto-Color: https://gfycat.com/AfraidAcademicGnu

Fast-Neural-Style out at 37.5 zoom:

https://i.imgur.com/Jkd7QZ0.gifv

Cosmic Zoom: 

https://gfycat.com/SandySarcasticAphid

---

# Known Issues

* All the frames used for cropping, are dumped into your Neural-Style directory, while all the full sized frames are saved in their own folder/directory inside the Neural-Style directory called, "output". 

* If you start from where you left off, it may crop the orginal full sized frames, so always back up the folder containing the full sized frames before starting the script again. Because of this, the cropped frames seem to be able to be replaced by the non cropped frames, with no issue. Meaning you only have to save the uncropped frames. 

* Before making a gif or mp4 file with your frames, either resize image number 1, or delete it, so that all frames are the same size.


---

For editing all the frames at once with the same settings: 

GIMP Plug-in: http://www.alessandrofrancesconi.it/projects/bimp/

---


