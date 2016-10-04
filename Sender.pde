class Sender {
  
  OOCSI oocsi;

  Sender() {
    oocsi = new OOCSI(this, "VendingMachine1Send", "13.94.200.130");
  }
  
  void sendFrame(PImage postImg) {
    oocsi.channel("CDRVendingTest").data("frame1", postImg).send();  
  }
  
  void sendText(String postMsg) {
     oocsi.channel("CDRVendingTest").data("text1", postMsg).send();
  }
  
  void sendBoolean(boolean postBool) {
    oocsi.channel("CDRVendingTest").data("isStealing1", postBool).send();
  }

}