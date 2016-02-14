import android.text.InputType;
import android.view.inputmethod.EditorInfo;
import android.widget.EditText;
import android.view.*;


void drawtextbox() {


    actin = new APEditText(int(30*scaleX), int(135*scaleY), int(255*scaleX), int(38*scaleY)); //create a textfield from x- and y-pos., width and height
    hoursin = new APEditText(int(113*scaleX), int(196*scaleY), int(37*scaleX), int(38*scaleY)); //create a textfield from x- and y-pos., width and height
    minsin = new APEditText(int(163*scaleX), int(196*scaleY), int(37*scaleX), int(38*scaleY)); //create a textfield from x- and y-pos., width and height

    actin.setTextColor(68,68,68,255);
    actin.setNextEditText(hoursin);
    actin.setInputType(InputType.TYPE_CLASS_TEXT);
    actin.setImeOptions(EditorInfo.IME_ACTION_NEXT);
    
    widgetContainer.addWidget(actin); //place textField in container  
    
//    actinView = (EditText) actin.getView();
//    
//    actinView.setBackground(new Border(0xff0000ff,10));


    hoursin.setTextColor(68,68,68,255);
    hoursin.setNextEditText(minsin);
    hoursin.setInputType(InputType.TYPE_CLASS_NUMBER);
    hoursin.setImeOptions(EditorInfo.IME_ACTION_NEXT);
    widgetContainer.addWidget(hoursin); //place textField in container  


    minsin.setTextColor(68,68,68,255);
    minsin.setInputType(InputType.TYPE_CLASS_NUMBER);
    minsin.setImeOptions(EditorInfo.IME_ACTION_DONE);
    minsin.setCloseImeOnDone(true);
    widgetContainer.addWidget(minsin); //place textField in container  

  
//      actin.addTextfield("actin",300,160,200,60)  //prints label below text entry field (in white)
//     .setPosition(30,140) //position is given as x, y (top left corner?)
//     .setSize(255,28)  //x,y dimensions
//     .setAutoClear(false) 
//     .setFont(font24)   //uses my font (set with PFont above)
//     .setColor(color(68,68,68))  //sets color of user-input text
//     .setColorForeground(color(215))  //sets color of box edge
//     .setColorBackground((color(235,235,235)))  //sets color of textbox background, when not selected
//     .setColorActive(color(200,200,200))  //sets color of textbox background when selected
//     .setLabel("");
//
//    hoursin.addTextfield("hoursin",300,160,200,60)  //prints label below text entry field (in white)
//     .setPosition(113,205) //position is given as x, y (top left corner?)
//     .setSize(37,28)  //x,y dimensions
//     .setAutoClear(false) 
//     .setFont(font24)   //uses my font (set with PFont above)
//     .setColor(color(68,68,68))  //sets color of user-input text
//     .setColorForeground(color(215))  //sets color of box edge
//     .setColorBackground((color(235,235,235)))  //sets color of textbox background, when not selected
//     .setColorActive(color(200,200,200))  //sets color of textbox background when selected
//     .setLabel("");
//
//    minsin.addTextfield("minsin",300,160,200,60)  //prints label below text entry field (in white)
//     .setPosition(163,205) //position is given as x, y (top left corner?)
//     .setSize(37,28)  //x,y dimensions
//     .setAutoClear(false) 
//     .setFont(font24)   //uses my font (set with PFont above)
//     .setColor(color(68,68,68))  //sets color of user-input text
//     .setColorForeground(color(215))  //sets color of box edge
//     .setColorBackground((color(235,235,235)))  //sets color of textbox background, when not selected
//     .setColorActive(color(200,200,200))  //sets color of textbox background when selected
//     .setLabel("");

}


//Controlp5
//records text entered when "Enter" is hit
//void controlEvent(ControlEvent theEvent) {
//  if(theEvent.isAssignableFrom(Textfield.class)) {
//    println("controlEvent: accessing a string from controller '"
//            +theEvent.getName()+"': "
//            +theEvent.getStringValue()
//            );
//  }  
//}

public class Border
extends android.graphics.drawable.Drawable
{
  public android.graphics.Paint paint;
  public android.graphics.Rect bounds_rect;
  
  public Border(int newcolor, int newwidth)
  {
    this.paint = new android.graphics.Paint();
    this.paint.setColor(newcolor);
    this.paint.setStrokeWidth(newwidth);
    this.paint.setStyle(android.graphics.Paint.Style.STROKE);
  }
  
  @Override
  public void onBoundsChange(android.graphics.Rect bounds) {
    this.bounds_rect = bounds;   
  }
  
  public void draw(android.graphics.Canvas c) {
    c.drawRect(this.bounds_rect, this.paint);
  }
  
  public void setAlpha(int a){}
  public void setColorFilter(android.graphics.ColorFilter cf){}
  public int getOpacity()
  {
    return 0;
  }
}
