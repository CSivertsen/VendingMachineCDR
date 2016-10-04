static class InputHandler {

  static int lastInput;

  static int getInput() {
    return lastInput;
  }

  static void receiveInput(char incomingKey) {
    switch(incomingKey) {
    case '1':
      lastInput = 1;
      break;
    case '2':
      lastInput = 2;
      break;
    case '3': 
      lastInput = 3;
      break;
    case '4': 
      lastInput = 4;
      break;
    default: 
      lastInput = 0;
      break;
    }
  }
}