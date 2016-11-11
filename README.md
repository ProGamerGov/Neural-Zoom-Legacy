# Neural-Zoom
---

#Requirements

[Neural-Style](https://github.com/jcjohnson/neural-style) or a [similar style transfer system](https://github.com/jcjohnson/neural-style/wiki/Similar-to-Neural-Style).

ImageMagick can be installed on Ubuntu with:

`sudo apt-get install imagemagick`

FFmpeg for making gifs and mp4 format videos with ImageMagick: 

`sudo apt-get install ffmpeg`



---

# Usage
Copy this script to neural-style directory, then run:

`./neural_zoom.sh input_file style_file zoom_value rotation_value num_frames`

The script is capable of continuing where you left off if it sees all the previous images up to where you stopped. So it can be a good idea to save all of the images it produces, so that you can always make your gifs/mp4 videos longer.

All of the frames after being run through Neural-Style can be found inside a folder the script creates called "output". 

If you wish to continue where you left off, make sure you save the frames that are outputted into the Neural-Style directory in additon to the frames saved in the output directory. You can also continue where you left off by simply using your last frame as your new content image.

---

#Arguments

`zoom_value`: The number of pixels subtracted from the width and height of your initial content image between each "frame".

`rotation_value`: The number of degrees the image is rotated by between frames. Use a value of "`0`" to have no rotation between frames.

`num_frames`: The total number of frames/images you want the script to create.

---
 
#Troubleshooting

If you face a permission error, try using chmod to fix the issue: 

`chmod u+x ./neural_zoom.sh`

--- 

#Example Outputs

https://i.imgur.com/UCWl54o.gifv

![](https://i.imgur.com/jcO0qpN.gif)

Zoom value of 5:

https://i.imgur.com/1880gPU.gifv

Zoom value of 37.5:

https://gfycat.com/HighlevelThinIndianpangolin

GIMP Auto-Color: https://gfycat.com/AfraidAcademicGnu

Fast-Neural-Style out at 37.5 zoom:

https://i.imgur.com/Jkd7QZ0.gifv


---

#Known Issues

* All the frames used for cropping, are dumped into your Neural-Style directory, while all the full sized frames are saved in their own folder/directory inside the Neural-Style directory called, "output". 


---

# Free and Open Source Gif/Video Making Tools: 

These tools are for putting your frames together into a video or gif. There are plenty of tools that exist for gif and video creation, so use whatever works well for you.

* Windows and OSX: http://instagiffer.com

* Linux: https://www.ffmpeg.org

For editing all the frames at once with the same settings: 

GIMP Plug-in: http://www.alessandrofrancesconi.it/projects/bimp/

---


