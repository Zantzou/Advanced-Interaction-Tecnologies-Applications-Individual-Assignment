import SimpleOpenNI.*;
SimpleOpenNI kinect;

float [] xpos = new float[50]; 
float [] ypos = new float[50];

void setup() {
 kinect = new SimpleOpenNI(this);
 kinect.enableDepth();
 kinect.enableUser();// this changed
 size(640, 480);
 fill(255, 0, 0);
 
  for (int i = 0; i < xpos.length; i ++ ) {
    xpos[i] = 0; 
    ypos[i] = 0;
  }
  
}

void draw() {
  kinect.update();
  image(kinect.depthImage(), 0, 0);

  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  if (userList.size() > 0) {
  int userId = userList.get(0);

    if ( kinect.isTrackingSkeleton(userId)) {
    drawSkeleton(userId);
    }
  }
  
   for (int i = 0; i < xpos.length-1; i ++ ) {
    // Shift all elements down one spot. 
    // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. 
    // Stop at the second to last element.
    xpos[i] = xpos[i+1];
    ypos[i] = ypos[i+1];
  }

 for (int i = 0; i < xpos.length; i ++ ) {
    // Draw an ellipse for each element in the arrays. 
    // Color and size are tied to the loop's counter: i.
    noStroke();
    fill(255-i*5);
    ellipse(xpos[i], ypos[i], i, i);
  }
  
}

void drawSkeleton(int userId) {
 stroke(0);
 strokeWeight(5);
 noStroke();

 fill(255,0,0);

 drawJoint(userId, SimpleOpenNI.SKEL_RIGHT_HAND);

}

void drawJoint(int userId, int jointID) {
 PVector joint = new PVector();

 float confidence = kinect.getJointPositionSkeleton(userId, jointID,
joint);
 if(confidence < 0.5){
   return;
 }
 PVector convertedJoint = new PVector();
 kinect.convertRealWorldToProjective(joint, convertedJoint);
 
 ellipse(convertedJoint.x, convertedJoint.y, 25, 25);
 
 xpos[xpos.length-1] = convertedJoint.x; 
 ypos[ypos.length-1] = convertedJoint.y;
}

//Calibration not required

void onNewUser(SimpleOpenNI kinect, int userID){
  println("Start skeleton tracking");
  kinect.startTrackingSkeleton(userID);
}
