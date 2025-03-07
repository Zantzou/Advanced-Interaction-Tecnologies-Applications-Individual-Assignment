import TUIO.*;
TuioProcessing tuio;
float cursor_size = 15;
float object_size = 60;
float table_size = 760;
float scale_factor = 1;
boolean showImage = false;
boolean verbose = false; // print console debug messages
boolean callback = true; // updates only after callbacks
int posX, posY;
PFont font;
PImage fotoOne;
PImage fotoTwo;

void setup()
{ 
    
  fotoOne = loadImage("eikona1.jpg");
  fotoTwo = loadImage("eikona2.jpg");


  noCursor();
  size(900,700);
  noStroke();
  fill(0);
  

  if (!callback) {
    frameRate(60);
    loop();
  } 
  
  else noLoop(); // or callback updates 
  
  font = createFont("Arial", 18);
  scale_factor = height/table_size;
  tuio  = new TuioProcessing(this);
  
}



void draw()
{
  
  
  background(255);
  textFont(font,18*scale_factor);
 

 ArrayList<TuioObject> tuioObjectList = tuio.getTuioObjectList();
  for (int i=0;i<tuioObjectList.size();i++) {  
TuioObject tobj = tuioObjectList.get(i);
     
      
if(tobj.getSymbolID() == 3){
  
     stroke(0);
     fill(0,0,0);
     pushMatrix();
     translate(posX, posY);
     popMatrix();
     fill(255);
     image(fotoOne, posX, posY, width/2, height/2);
     showImage = true; }
     
     
if(tobj.getSymbolID() == 4){
  
     stroke(0);
     fill(0,0,0);
     pushMatrix();
     translate(posX, posY);
     popMatrix();
     fill(255);
     image(fotoTwo, posX, posY, width/4, height/2);
     showImage = true; }
   
if (tobj.getSymbolID()==0) {filter(INVERT);}
if (tobj.getSymbolID()==1) {filter(GRAY);} 
if (tobj.getSymbolID()==2) {scale(1.5,1.5);} 
     
  }
   
}


void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
}


void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
  +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
          
  posX = round(tobj.getX()*width);
  posY = round(tobj.getY()*height); 

}


void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
}


void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
