# Neural-Zoom
Name subject to change


# Usage
Copy this script to neural-style directory, then run:

`./neural_zoom.sh input_file style_file zoom_value rotation_value num_frames`

The script is capable of continuing where you left off if it sees all the previous images up to where you stopped. So it can be a good idea to save all of the images it produces, so that you can always make your gifs/mp4 videos longer.

---

#Arguments

`zoom_value`: The number of pixels subtracted from the width and height of your initial content image.

`rotation_value`: The number of degrees the image is rotated by between frames.

`num_frames`: The total number of frames/images you want the script to create.

---

#Troubleshooting

If you face a permission error, try using chmod to fix the issue: 

`chmod u+x ./neural_zoom.sh`

--- 

#Example Outputs

https://i.imgur.com/UCWl54o.gifv

---

#Known Issues

* Your input image needs to be smaller than your `-image_size` parameter for it to work properly at the moment. 

