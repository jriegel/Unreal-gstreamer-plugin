# Example gStreamer pipelines for use in Unreal

This Examples use the installed Version of gGstreamer found here:
https://gstreamer.freedesktop.org/data/pkg/windows/1.22.3/msvc/gstreamer-1.0-msvc-x86_64-1.22.3.msi

On the other side the the piplines are used in the Unreal GstreamerSink to show it on a Unreal mesh/geo.

# Sources

Mostly used is to stream a Video, e.g. a GUI, from an client into Unreal. There fore we use different pipelines to send video over the network to unreal.

Used is the udpsink which get the IP and PORT for the target machine.
https://gstreamer.freedesktop.org/documentation/udp/udpsink.html?gi-language=c

Here some example to send different sources on the way. 

## From File

Sends any kind of Video file from any location:

    gst-launch-1.0 -v filesrc location= C:/Users/mail/Videos/Coffee_Run.webm  ! decodebin ! videoconvert ! x264enc tune=zerolatency ! rtph264pay ! udpsink host=127.0.0.1 port=5000


## From WebCam / WDM device

Grabs a Windows Video device and sends it:

https://gstreamer.freedesktop.org/documentation/winks/index.html?gi-language=c

    gst-launch-1.0 -v ksvideosrc ! videoconvert ! x264enc tune=zerolatency ! rtph264pay ! udpsink host=127.0.0.1 port=5000

## Capture on Window and send

Here we capture from the screen or full screen window with the optimized d3d capturer.

https://gstreamer.freedesktop.org/documentation/winks/index.html?gi-language=c

    gst-launch-1.0 -v d3d11screencapturesrc ! videoconvert ! x264enc tune=zerolatency ! rtph264pay ! udpsink host=127.0.0.1 port=5000

And here we crop the capture to a certain area of the capture:

     gst-launch-1.0 -v d3d11screencapturesrc ! videocrop top=10 left=10 right=50 bottom=50 ! videoconvert ! x264enc tune=zerolatency ! rtph264pay ! udpsink host=127.0.0.1 port=5000

https://gstreamer.freedesktop.org/documentation/videocrop/videocrop.html?gi-language=c



 