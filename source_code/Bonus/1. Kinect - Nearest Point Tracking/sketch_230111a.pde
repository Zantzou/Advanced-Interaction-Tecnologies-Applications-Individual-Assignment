import SimpleOpenNI.*;
SimpleOpenNI kinect;
int closestValue; 
int []closestX= new int [50];
int []closestY = new int [50];
 int closeX;
 int closeY;
void setup()
{
 size(640, 480);
 kinect = new SimpleOpenNI(this);
 kinect.enableDepth();
 //gia to fidaki
  for (int i = 0; i < closestX.length; i ++ ) {
    closestX[i] = 0; 
    closestY[i] = 0;
    
  }
}
void draw()
{
 closestValue = 2000; 
 kinect.update();
 // get the depth array from the kinect
 int[] depthValues = kinect.depthMap();
 // for each row in the depth image
 for(int y = 0; y < 480; y++){ 
 // look at each pixel in the row
 for(int x = 0; x < 640; x++){ 



 // pull out the corresponding value from the depth array
 int i = x + y * 640; 
 int currentDepthValue = depthValues[i];
 // if that pixel is the closest one we've seen so far
 if(currentDepthValue > 0 && currentDepthValue < closestValue){ 
 // save its value
 closestValue = currentDepthValue;
 // and save its position (both X and Y coordinates)
 closeX = x;
 closeY = y;
 
 } //kleinei to if 
 }
 }

 //prepei kapou na valoume to closestX[i]=closeX;
 
 for (int i = 0; i < closestX.length-1; i ++ ) {
    // Shift all elements down one spot. 
    // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. 
    // Stop at the second to last element.
    closestX[i] = closestX[i+1];
    closestY[i] = closestY[i+1];
  }
  // New location
  // Update the last spot in the array with the mouse location.
  closestX[closestX.length-1] = closeX; 
  closestY[closestY.length-1] = closeY;
  
 //draw the depth image on the screen
 image(kinect.depthImage(),0,0);
 // draw a red circle over it,
 // positioned at the X and Y coordinates
 // we saved of the closest pixel.
  
  for (int i = 0; i < closestX.length; i ++ ) {
    // Draw an ellipse for each element in the arrays. 
    // Color and size are tied to the loop's counter: i.
    noStroke();    
    fill(255 , 0, 255-i*5);
    ellipse(closestX[i], closestY[i], i, i);
  }
 
}
