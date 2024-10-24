# UE5 GStreamer plugin

[![Demo video](img/demo1.jpg)](https://www.youtube.com/watch?v=eCLCdaSIxBA)

## Getting Started

Tested with UE4 5.1 and GStreamer 1.22

Download and install [GStreamer runtime and development packages](https://gstreamer.freedesktop.org/download/)

After Gstreamer install the GSTREAMER_1_0_ROOT_MSVC_X86_64 have to be set. On every computer the plugin need to run, gstreamer has to be installed!

Launch project and hit play

## AppSink examples

Test pattern:
`videotestsrc pattern=snow ! video/x-raw,width=(int)512,height=(int)512,format=(string)RGBA,framerate=(fraction)30/1 ! appsink name=sink`

Play a local file:
`filesrc location=d:/video/doom.mp4 ! decodebin ! videoconvert ! video/x-raw,format=(string)RGBA ! videoconvert ! appsink name=sink`

Play URI:
`uridecodebin uri=http://images.nvidia.com/geforce-com/international/videos/doom/doom-nvidia-geforce-gtx-geforce-dot-com-vulkan-graphics-api-gameplay-video.mp4 ! videoconvert ! video/x-raw,format=(string)RGBA ! videoconvert ! appsink name=sink`

## AppSrc examples

Capture and stream render target:
`appsrc name=src caps=video/x-raw,width=(int)640,height=(int)480,format=(string)BGRA,framerate=(fraction)60/1 ! tcpserversink host=127.0.0.1 port=5000 sync=false`

Preview stream:
`gst-launch-1.0 -v tcpclientsrc host=127.0.0.1 port=5000 ! videoparse width=640 height=480 framerate=60/1 format=8 ! autovideoconvert ! autovideosink`
