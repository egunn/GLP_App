void drawtextbox() {

    actin.addTextfield("actin",300,160,200,60)  //Create text box actin at position and size given. 
     .setPosition(30,140) //position is given as x, y (top left corner?)
     .setSize(255,28)  //x,y dimensions
     .setAutoClear(false) 
     .setFont(font24)   //uses my font (set with PFont above)
     .setColor(color(68,68,68))  //sets color of user-input text
     .setColorForeground(color(215))  //sets color of box edge
     .setColorBackground((color(235,235,235)))  //sets color of textbox background, when not selected
     .setColorActive(color(200,200,200))  //sets color of textbox background when selected
   //  .setColorLabel(150)  //set text color for textbox label
   //  .setColor(color(150,0,0))  //sets color of user-input text
     .setLabel(""); //Default label shows below text entry field (in white, unless setColorCaptionLabel is called) 
    

    hoursin.addTextfield("hoursin",300,160,200,60)  //prints label below text entry field (in white)
     .setPosition(113,205) //position is given as x, y (top left corner?)
     .setSize(37,28)  //x,y dimensions
     .setAutoClear(false) 
     .setFont(font24)   //uses my font (set with PFont above)
     .setColor(color(68,68,68))  //sets color of user-input text
     .setColorForeground(color(215))  //sets color of box edge
     .setColorBackground((color(235,235,235)))  //sets color of textbox background, when not selected
     .setColorActive(color(200,200,200))  //sets color of textbox background when selected
     .setLabel("");

    minsin.addTextfield("minsin",300,160,200,60)  //prints label below text entry field (in white)
     .setPosition(163,205) //position is given as x, y (top left corner?)
     .setSize(42,28)  //x,y dimensions
     .setAutoClear(false) 
     .setFont(font24)   //uses my font (set with PFont above)
     .setColor(color(68,68,68))  //sets color of user-input text
     .setColorForeground(color(215))  //sets color of box edge
     .setColorBackground((color(235,235,235)))  //sets color of textbox background, when not selected
     .setColorActive(color(200,200,200))  //sets color of textbox background when selected
     .setLabel("");

}



//records text entered when "Enter" is hit
void controlEvent(ControlEvent theEvent) {
  if(theEvent.isAssignableFrom(Textfield.class)) {
    println("controlEvent: accessing a string from controller '"
            +theEvent.getName()+"': "
            +theEvent.getStringValue()
            );
  }  
}

