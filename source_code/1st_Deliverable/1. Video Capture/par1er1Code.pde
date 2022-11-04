import processing.video.*;

Capture video;

void captureEvent(Capture video) {
 video.read();
}


void setup(){
  size(400,400);
  video = new Capture(this,height , width);
  video.start();
}
void draw(){
image(video, 0 ,0);

}
