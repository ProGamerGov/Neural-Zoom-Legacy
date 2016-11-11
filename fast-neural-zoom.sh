#!/bin/bash -x

 #Check for output directory, and create it if missing
if [ ! -d "$output" ]; then
  mkdir output
fi


main(){
    # 1. input image
    input=$1
    input_file=`basename $input`
    clean_name="${input_file%.*}"

    # 2. Style image
    style=$2
    style_dir=`dirname $style`
    style_file=`basename $style`
    style_name="${style_file%.*}"
    
    #Defines the output directory
    output="./output"

    # 4. Zoom value
    zoom=$3

    #5. Rotation value
    rotation_value=$4

    #6. Number of frames
    num_frames=$5

###############################################

#Run image 0 through neural_style.lua before cropping/rotation occurs

v_frames=0
out_file1="${v_frames}_${clean_name}.png"
neural_style $input $style $out_file1

###############################################


#Get the width and height  
width=`convert "${v_frames}_${clean_name}.png" -format "%w" info:`
height=`convert "${v_frames}_${clean_name}.png" -format "%h" info:`
#Calculate the new cropped dimensions of the new image
widthcrop=`echo $width $zoom | awk '{print $1-$2}'`
heightcrop=`echo $height $zoom | awk '{print $1-$2}'`

###############################################

#Takes output image 0 and rotates/crops it before running the new output through neural_style.lua again. 
#This process is repeated until it has been done a use specified number of times.

for r in `seq 1 $num_frames`;
do 

input=$outfile

convert -rotate $rotation_value -gravity center -crop "$widthcrop"x"$heightcrop"+0+0 $out_file "${v_frames}_${clean_name}.png"
input="${v_frames}_${clean_name}.png"
v_frames=`echo $v_frames 1 | awk '{print $1+$2}'`
out_file="${v_frames}_${clean_name}.png"

neural_style $input $style $out_file

#Copy the uncropped output to the output directory in order to preserve it's output size
cp $out_file $output/$out_file

done

}

retry=0

###############################################

#Specific the Neural-Style command used for each frame here:

neural_style(){
    echo "Neural Style Transfering "$1
    if [ ! -s $3 ]; then
        th fast_neural_style.lua -input_image $1 -model $2 -output_image $3 \
 -gpu 0 -use_cudnn 1 -backend cuda -image_size 1000

    fi
    if [ ! -s $3 ] && [ $retry -lt 3 ] ;then
            echo "Transfer Failed, Retrying for $retry time(s)"
            retry=`echo 1 $retry | awk '{print $1+$2}'`
            neural_style $1 $2 $3
    fi
    retry=0
}
main $1 $2 $3 $4 $5 
