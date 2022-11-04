//from qr processing library 
import qrcodeprocessing.*;
Decoder decoder;
PImage img;
void setup() {
  size (200, 200);
  //we have to load the image here to avoid overloading draw ..and delay
  img = loadImage("zantzouGithubP1Er3.png");
  decoder = new Decoder(this);
  decoder.decodeImage(img);
  //to dispay the image it says i have to [image(img, 10, 20, 90, 60);]
}
void draw (){
  image(img, 0,0, width , height);
}
 
void decoderEvent(Decoder decoder) {
  String statusMsg = decoder.getDecodedString(); 
  //println(statusMsg);
   link(statusMsg);
 
  
}
