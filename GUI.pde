class GUI {

  PImage backgroundImg;
  PImage tableImg;
  GUIState currentState;
  PFont normalFont;
  PFont headingFont;
  int circleSize = 180;
  boolean inputIsNew = false;
  int imgDisplayWidth = 500;
  Thread recorderThread;

  GUI() {
    backgroundImg = loadImage("background.jpg");
    tableImg = loadImage("schemacandy.png");
    currentState = new GUIState();
    normalFont = createFont("Hero", 30, true);
    headingFont = createFont("Agent Orange", 40, true);
    display();
  }

  void update() {
    currentState.update(InputHandler.getInput());
    display();
  } 

  void update(boolean boolInput) {
    currentState.otherIsStealing = boolInput;
    println("Other person is stealing: " + boolInput);
    inputIsNew = true;
    currentState.otherIsReady = true; 
    currentState.update(4);
    display();
  }

  void display() {


    //background(backgroundImg);
    background(background);

    //Drawing text
    rectMode(CENTER);
    if (currentState.titleShown) {
      textAlign(CENTER);
      textFont(headingFont, 60);
      text(currentState.title, width/2, height, width, height);
      textAlign(LEFT);
    }
    rectMode(CORNER);

    if (currentState.headerShown) {
      textAlign(LEFT, TOP);
      textFont(headingFont, 60);
      text(currentState.header, width*0.1, height*0.1, width*0.6, height*0.5);
    }

    if (currentState.messageShown) {
      textAlign(LEFT, TOP);
      textFont(normalFont, 35);
      text(currentState.message, width*0.1, height*0.3, width*0.5, height*0.5);
    }

    //Drawing circles
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    strokeWeight(5);
    noFill();
    textFont(normalFont, 35);
    stroke(255, 255, 255);
    if (currentState.circle1Shown) {
      if (currentState.circle1Selected) {
        stroke(100, 100, 255);
      }  
      ellipse(width*0.8, height*0.25, circleSize, circleSize);
      text(currentState.buttonText[0], width*0.8, height*0.25, circleSize, circleSize);
      line(width*0.8+circleSize/2, height*0.25, width, height*0.25);
      if (currentState.productsShown) {
        text(currentState.price, width*0.8+circleSize*0.75+20, height*0.25+20);
        image(currentState.buttonImg[0], width*0.8-imgDisplayWidth, height*0.25-circleSize/2);
      }
      stroke(255, 255, 255);
    }
    if (currentState.circle2Shown) {
      if (currentState.circle2Selected) {
        stroke(100, 100, 255);
      }
      ellipse(width*0.8, height*0.5, circleSize, circleSize);
      text(currentState.buttonText[1], width*0.8, height*0.5, circleSize, circleSize);
      line(width*0.8+circleSize/2, height*0.5, width, height*0.5);
      if (currentState.productsShown) {
        text(currentState.price, width*0.8+circleSize*0.75+20, height*0.5+20); 
        image(currentState.buttonImg[1], width*0.8-imgDisplayWidth, height*0.5-circleSize/2);
      }
      stroke(255, 255, 255);
    }
    if (currentState.circle3Shown) {
      if (currentState.circle3Selected) {
        stroke(100, 100, 255);
      }
      ellipse(width*0.8, height*0.75, circleSize, circleSize);
      text(currentState.buttonText[2], width*0.8, height*0.75, circleSize, circleSize);
      line(width*0.8+circleSize/2, height*0.75, width, height*0.75);
      if (currentState.productsShown) {
        text(currentState.price, width*0.8+circleSize*0.75+20, height*0.75+20);
        image(currentState.buttonImg[2], width*0.8-imgDisplayWidth+10, height*0.75-circleSize/2-20);
      }
      stroke(255, 255, 255);
    }

    if (currentState.tableShown) {
      image(tableImg, width*0.1, height*0.5, tableImg.width*2, tableImg.height*2);
    }

    //Drawing webcam feed 
    if (currentState.webcamShown) {
      //Shows own feed
      //set(0,0, cam.get());

      if (myReceiver.receiveFrame() != null) {
        println("Showing webcam feed");
        set(0, 0, myReceiver.receiveFrame());
      }
    }
  }

  class GUIState {
    String header = ""; 
    String title = "Co-op Candy";
    String message = "";
    String price = "€ 0,50";
    String[] buttonText = {"", "", "Start"};    
    PImage[] buttonImg;
    boolean headerShown = false;
    boolean messageShown = false;
    boolean titleShown = true;
    boolean tableShown = false; 
    boolean webcamShown = false;
    boolean timerShown = false;
    boolean productsShown = false;
    boolean circle1Shown = false;
    boolean circle2Shown = false;
    boolean circle3Shown = true;
    boolean circle1Selected = false;
    boolean circle2Selected = false;
    boolean circle3Selected = false;
    boolean isStealing = false;
    boolean otherIsStealing = false;
    boolean otherIsReady = false;
    boolean hasRun = false;
    int state = 1;

    GUIState() {
      buttonImg = new PImage[3];
      buttonImg[0] = loadImage("snickers.png");
      buttonImg[1] = loadImage("twix.png");
      buttonImg[2] = loadImage("kitkat.png");
    }

    void update(int input) {
      //println("Input: " + input);
      //println("state: " + state);

      switch(state) {
      case 0:
        if (hasRun == false) {
          println("I am starting the tab delay now");
          
          /*//thread("counter");
          delay(5000);
          println("tabbing first");
          altTab();
          delay(5000);
          println("tabbing second"); 
          altTab();*/
          
          println("The delay and tab has ended");
          hasRun = true;
        }
        if (inputIsNew && input == 4) {
          println("Updating interface to start screen");
          myPort.write("0");
          title = "Co-op Candy";
          headerShown = false;
          titleShown = true; 
          circle3Shown = true;
          messageShown = false;
          webcamShown = false;
          otherIsReady = false;
          buttonText[0] = "";
          buttonText[2] = "Start";
          numCustomer++;
          state++;
          inputIsNew = false;
          isRecording = false;
        }
        break;  

      case 1:
        if (input == 3 && inputIsNew) {
          titleShown = false;
          headerShown = true;
          messageShown = true; 
          isRecording = true;
          header = "";
          message = "This is a study into cooperative consumer behavior. Somebody else will be using an identical machine placed at a different location. Waiting times may occur.";
          buttonText[2] = "Continue";
          state++;
          inputIsNew = false;
        }
        break;

      case 2:
        if (input == 3 && inputIsNew) {
          header = "Select candy";
          message = "Please select the desired candy";
          buttonText[1] = "";
          buttonText[2] = "";
          circle1Shown = true;
          circle2Shown = true;
          circle3Shown = true;
          productsShown = true;
          productsShown = true;
          myPort.write("9");
          state++;
          inputIsNew = false;
        }
        break;

      case 3:
        if ((input == 1 || input == 2 || input == 3) && inputIsNew) { 
          header = "Payment";
          message = "Please insert cash to pay for your candy";
          buttonText[2] = "";

          switch(input) {
          case 1: 
            circle1Selected = true;
            circle2Selected = false;
            circle3Selected = false;
            break;
          case 2: 
            circle1Selected = false;
            circle2Selected = true;
            circle3Selected = false;
            break;
          case 3: 
            circle1Selected = false;
            circle2Selected = false;
            circle3Selected = true;
            break;
          default: 
            break;
          }
          //state++;
          inputIsNew = false;
        } 
        if (input == 4 && inputIsNew) {
          state++;
          inputIsNew = false;
        }
        break;


      case 4:
        if (input == 4 && inputIsNew) {
          header = "Payment succesful";
          message = "";
          buttonText[2] = "Continue";
          circle1Shown = false;
          circle2Shown = false;
          circle3Shown = true;
          circle1Selected = false;
          circle2Selected = false;
          circle3Selected = false;
          productsShown = false;

          state++;
          inputIsNew = false;
        }
        break;

      case 5: 
        if (input == 3 && inputIsNew) {
          header = "Do you want to take extra candy?";
          message = "Do you want to take an extra piece of candy from the other customer?";
          buttonText[0] = "Yes";
          buttonText[2] = "No";
          circle1Shown = true;
          circle2Shown = false;
          circle3Shown = true;
          timerShown = true;
          tableShown = true;

          state++;
          inputIsNew = false;
        }
        break;

      case 6: 
        if (input == 1 || input == 3 && inputIsNew) {
          header = "Waiting for other customer";
          message = "Please wait while the other customer makes his choice";
          circle1Shown = false;
          circle2Shown = false;
          circle3Shown = false;
          tableShown = false;

          if (input == 1) {
            isStealing = true;
          } else if (input == 3) {
            isStealing = false;
          }
          mySender.sendBoolean(isStealing);
          state++;
          inputIsNew = false;
          println("I'm waiting");
        }

        break;

      case 7: 
        println("I am in the result state bit did not update the interface");
        if (otherIsReady || (inputIsNew && input == 4)) {
          if (otherIsStealing && isStealing) {
            title = "Both are stealing. Nobody receives a snack";
            myPort.write("8");
          } else if (otherIsStealing && !isStealing) {
            title = "The other customer took your snack";
            myPort.write("8");
          } else if (!otherIsStealing && isStealing) {
            title = "You took the other customers snack";
            myPort.write("6");
          } else if (!otherIsStealing && !isStealing) {
            title = "You both got one snack";
            myPort.write("7");
          } 
          println("I have changed the interface to display the result");
          message = "";
          header = "";
          titleShown = true;
          webcamShown = true;
          headerShown = true;  
          state = 0;
          inputIsNew = false;
          hasRun = false;
        }
        break;

      default: 
        break;
      }
    }
  }
}