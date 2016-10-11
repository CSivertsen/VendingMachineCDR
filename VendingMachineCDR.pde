import processing.serial.*;
import processing.video.*;
import nl.tue.id.oocsi.*;
import java.awt.Robot;
import java.awt.event.KeyEvent;
import java.io.IOException;

String message;

PImage frame; 
GUI myGUI;
Sender mySender;
Receiver myReceiver;
Capture cam;
int inByte;
Serial myPort;
Robot robot;
PImage background; 
PGraphics camCanvas;
boolean isRecording = false;
long frameNum = 0;
int numCustomer = 1; 

void setup() {
  fullScreen();
  background = loadImage("background.jpg");
  background.resize(width, height);
  background(background);
  //frameRate(29);
  String portName = Serial.list()[0];
  myPort = new Serial(this, portName, 9600);
  
  myGUI = new GUI();
  mySender = new Sender();
  myReceiver = new Receiver();
  
  /*String[] cameras = Capture.list();

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
    }*/
    
    try {
      robot = new Robot();
      
    } catch (Exception e) {
    e.printStackTrace();
    exit();
    }
    
    camCanvas = createGraphics(640, 480);
}

void draw() {
 
  //mySender.sendFrame(getFrame());
  myGUI.display();
  myGUI.update();
  
  /*if(isRecording) {
    camCanvas.beginDraw();
    camCanvas.set(0,0,cam);
    camCanvas.endDraw();
    camCanvas.save("output"+ numCustomer +"/frame" + frameNum + ".jpg");
    frameNum++;
  }*/
}

void keyPressed() {
  
  InputHandler.receiveInput(key);
  myGUI.inputIsNew = true;
  //println("Keypressed");

}

void counter() {
      println("I'm tabbing");
      boolean isCounting = true;
      boolean doneFirstTab = false;
      long delay1 = 5000;
      long delay2 = 10000;

      long startTime = millis();

      while (isCounting) {
        if (millis() - startTime > delay1 && doneFirstTab == false) {
          altTab();
          startTime = millis();
          doneFirstTab = true;
        } else if ( millis() - startTime > delay2 && doneFirstTab == true) {
          altTab();
          isCounting = false;
        }
      }
    }

void altTab() {
  try {
    robot.keyPress(KeyEvent.VK_ALT);
    robot.keyPress(KeyEvent.VK_TAB);
    robot.keyRelease(KeyEvent.VK_TAB);
    robot.keyRelease(KeyEvent.VK_ALT);
    
  } catch (Exception e) {
    //Uh-oh...
    e.printStackTrace();
    exit();
  }
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
  //println("Serial received: " + inByte);
}