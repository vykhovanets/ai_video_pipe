# Video editing script

this script works with ai-generated videos
there are steps performed:

1. video is split into individual frames
2. frames are filtered - we left only every nth frame
3. remaining frames get upscaled with ESRGAN
4. correct fps is calculated
5. frames are stitched into video
6. some interpolation method is used to add frame transitions to the video (mci or blend)

# Setup
1. Please, download portable version of esrgan from [here](https://github.com/xinntao/Real-ESRGAN#-quick-inference), and copy executable `realesrgan-ncnn-vulkan` and folder `models` into repository folder.
2. Make sure you have `ffmpeg` installed
3. You can launch `./permissions.sh`

# Usage

0. launch scripts from the repository folder, so `cd` into it.

1. to process one video provide full path to the input video, full path to the result and modulo number to be used at stage 2, for example:
```bash
./flow.sh ~/Downloads/scenes/Scene1_Chinese.mp4 ~/Downloads/results/Scene1_Chinese.mp4 15
```

2. to process the whole folder of videos provide input and output folders as arguments, without trailing `/`, and modulo number:
```bash
./folder_processing ~/Downloads/scenes ~/Downloads/results 15
```
