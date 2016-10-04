import processing.serial.*;
import processing.video.*;
import nl.tue.id.oocsi.*;

String message;

PImage frame; 
GUI myGUI;
Sender mySender;
Receiver myReceiver;
Capture cam;
int inByte;
Serial myPort;    

void setup() {
  size(1000,800);
  background(120);
  frameRate(10);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  myGUI = new GUI();
  mySender = new Sender();
  myReceiver = new Receiver();
  
  String[] cameras = Capture.list();

    if (cameras == null) {
      println("Failed to retrieve the list of available cameras, will try the default...");
      cam = new Capture(this, 640, 480);
    } if (cameras.length == 0) {
      println("There are no cameras available for capture.");
      exit();
    } else {
      println("Available cameras:");
      printArray(cameras);
  
      // The camera can be initialized directly using an element
      // from the array returned by list():
      cam = new Capture(this, cameras[0]);
      // Or, the settings can be defined based on the text in the list
      //cam = new Capture(this, 640, 480, "Built-in iSight", 30);
      
      // Start capturing the images from the camera
      cam.start();
    }
}

void draw() {
 
  mySender.sendFrame(getFrame());
  myGUI.display();
  myGUI.update();
}

void keyPressed() {
  
  InputHandler.receiveInput(key);
  myGUI.inputIsNew = true;
  println("Keypressed");

}

PImage getFrame() {

  if (cam.available() == true) {
    cam.read();
  }

  return frame = cam.get();
}

void serialEvent(Serial myPort){
  inByte = myPort.read()-'0';
  InputHandler.receiveInput(inByte);
  myGUI.inputIsNew = true;
  println("Serial received: " + inByte);
}