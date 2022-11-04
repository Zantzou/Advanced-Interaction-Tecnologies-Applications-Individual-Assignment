/*import processing.video.*;
Capture video;
void captureEvent(Capture video) {
 video.read();
}
void setup() {
 size(320, 240);
 video = new Capture(this, 320, 240);
 video.start();
}
void draw() {
 image(video, 0, 0);
}*/
import processing.video.*;
Movie myMovie;

void setup() {
  size(200, 200);
  frameRate(30);
  myMovie = new Movie(this, "cat.mov");
 
 // myMovie.speed(4.0);
  myMovie.loop();
}

void draw() {
  float ratio= mouseX / (float)width;
  myMovie.speed(ratio);
  if (myMovie.available()) {
    myMovie.read();
  }
  image(myMovie, 0, 0);
}
