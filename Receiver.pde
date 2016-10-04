public class Receiver {

  OOCSI oocsi;
  PImage receivedFrame; 
  
  public Receiver() {
    oocsi = new OOCSI(this, "VendingMachine1Receive", "13.94.200.130");
    oocsi.subscribe("CDRVendingTest");
  }
  
  public void CDRVendingTest(OOCSIEvent event) {
    println(event.getSender());
    if (event.has("isStealing2")) {
      println("Receiving stuff");
      println(event.getBoolean("isStealing2",false));
      myGUI.update(event.getBoolean("isStealing2",false));
      receivedFrame = (PImage) event.getObject("frame2");
    } else {
    println("Did not pass if statement");
    println("Has isStealing2?: " + event.has("isStealing2"));
    }
  }
  
  public PImage receiveFrame(){
    return receivedFrame;
  }

  
}