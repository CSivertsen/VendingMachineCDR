class Counter implements Runnable {
  
  boolean isCounting = true;
  boolean doneFirstTab = false;
  long startTime;
  long delay1, delay2;
  
  Counter(long _delay1, long _delay2){
    startTime = millis();
    delay1 = _delay1;
    delay2 = _delay2;
  }
  
  @Override 
  public void run() {
    while(isCounting) {
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
}