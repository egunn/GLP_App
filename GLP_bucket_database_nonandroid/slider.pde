//void slider(int x, int y, int xlength, int ylength, int sliderValIn) {
void slider() {
  
//  sliderApos = 0;
//  sliderBpos = 0;
//  sliderCpos = 0;
  
  boolean sliderAOver=false, sliderBOver=false, sliderCOver=false;
  boolean slider1Over = false, slider2Over =false, slider3Over = false,slider4Over =false, slider5Over=false;
//  sliderAVal = 0;
//  sliderBVal= 0;
//  sliderCVal = 0;
  
if (check1On)  {  
  

  //Check whether the mouse is over the connection slider bar
  if ((186 < scalemouseX) && (scalemouseX < 271) && (288 < scalemouseY) && (scalemouseY < 298)) {  
      sliderAOver = true;
      //sliderReadIn(x, y, xlength, ylength, sliderValIn);
      sliderReadIn();  //uses the mouse position to draw the appropriate fill rectangles
      //println(sliderAOver + "sliderAOver slider");  //????Once true, always shows as true, even if mouse moves outside of slider bar
  }
//  else {
//    sliderAOver = false;
//  }
  
  
  if (sliderAOver == false) {
    sliderApos = 0;
    //println(sliderAVal); //always reads as zero
    
    switch(sliderAVal) {
      case 0:
      break;  
      
      case 1:
          fill(slider1Color); //full red
          rect(186, 288, 17,10);
      break;
          
      case 2: 
          fill(slider2Color); //orange red
          rect(186, 288, 34, 10);
      break;
      
      case 3:
          fill(slider3Color); //yellow
          rect(186, 288, 51, 10);
      break;
      
      case 4: 
          fill(slider4Color); //yellow green
          rect(186, 288, 68, 10);
      break;
      
      case 5:
          fill(slider5Color); //full green     
          rect(186, 288, 85, 10);
      break;
    }
  }
  

}
 
else {  
  fill(195);
  rect(186, 288, 85,10);
}

if (check2On) {
  
   
  //Check whether the mouse is over the contribution slider bar
  if ((186 < scalemouseX) && (scalemouseX < 271) && (323 < scalemouseY) && (scalemouseY < 333)) {  
      sliderBOver = true;
      sliderReadIn();
  }
  
  if (sliderBOver == false) {
  sliderBpos = 0;
    
    switch(sliderBVal) {
      case 0:
      break;  
      
      case 1:
          fill(slider1Color); //full red
          rect(186, 323, 17,10);
      break;
          
      case 2: 
          fill(slider2Color); //orange red
          rect(186, 323, 34, 10);
      break;
      
      case 3:
          fill(slider3Color); //yellow
          rect(186, 323, 51, 10);
      break;
      
      case 4: 
          fill(slider4Color); //yellow green
          rect(186, 323, 68, 10);
      break;
      
      case 5:
          fill(slider5Color); //full green     
          rect(186, 323, 85, 10);
      break;
    }
  }

}

else {
  fill(195);
  rect(186, 323, 85,10);
}













if (check3On)  {
  
  //Check whether the mouse is over the vitality slider bar
  if ((186 < scalemouseX) && (scalemouseX < 271) && (358 < scalemouseY) && (scalemouseY < 368)) {  
      sliderCOver = true;
      sliderReadIn();
  }
  
  if (sliderCOver == false) {
  sliderCpos = 0;
      
    switch(sliderCVal) {

      case 0:
      break;  
      
      
      case 1:
          fill(slider1Color); //full red
          rect(186, 358, 17,10);
      break;
          
      case 2: 
          fill(slider2Color); //orange red
          rect(186, 358, 34, 10);
      break;
      
      case 3:
          fill(slider3Color); //yellow
          rect(186, 358, 51, 10);
      break;
      
      case 4: 
          fill(slider4Color); //yellow green
          rect(186, 358, 68, 10);
      break;
      
      case 5:
          fill(slider5Color); //full green     
          rect(186, 358, 85, 10);
      break;    }
  }

}

else {
  fill(195);
  rect(186, 358, 85,10);
}

   
  
  
}


//void sliderReadIn(int x, int y, int xlength, int ylength, int sliderValIn) {
void sliderReadIn() {
  
//  sliderApos = 0;
//  sliderBpos = 0;
//  sliderCpos = 0;
  
  boolean sliderAOver=false, sliderBOver=false, sliderCOver=false;
  boolean slider1Over = false, slider2Over =false, slider3Over = false,slider4Over =false, slider5Over=false;
//  sliderAVal = 0;
//  sliderBVal= 0;
//  sliderCVal = 0;
  
  String terrible = "terrible", drag = "a drag", ok = "ok", good = "good", awesome = "awesome!";
   
  
//  //Connection slider bar
//  //background fill values
//  fill(195);
//  rect(186  ,288  ,85,10);
  
  textFont(font24,12);
  
  if (check1On == false) {
  //Contribution slider bar
  //background fill values
  fill(195);
  rect(186  ,358  ,85,10);
  } 
  
 //Check whether the mouse is over the connection slider bar
  else if ((186 < scalemouseX) && (scalemouseX < 271) && (288 < scalemouseY) && (scalemouseY < 298)) {  
      sliderAOver = true;
             
      
      if ((186<scalemouseX) && (scalemouseX < 203)) {
        slider1Over = true;
        sliderApos = 1;
        //slider bar options
        fill(slider1Color); //full red
        rect(186, 288, 17,10);
        fill(0);
        text(terrible, 186 ,385 );
      }
      
      else if ((203<scalemouseX)&& (scalemouseX < 220)) {
        slider2Over = true;
        sliderApos = 2;
        fill(slider2Color); //orange red
        rect(186, 288, 34, 10);
        fill(0);
        text(drag, 186 ,385 );
      }
      
      else if ((220 < scalemouseX) && (scalemouseX < 237)) {
        slider3Over = true;
        sliderApos = 3;
        fill(slider3Color); //yellow
        rect(186, 288, 51, 10);
        fill(0);
        text(ok, 186 ,385 );
      }
      
      else if ((237 < scalemouseX) && (scalemouseX < 254)) {
        slider4Over = true;
        sliderApos = 4;
        fill(slider4Color); //yellow green
        rect(186, 288,68,10);
        fill(0);
        text(good, 186 ,385 );
        
      } 
      
      else if ((254 < scalemouseX) && (scalemouseX < 271)) {
        slider5Over = true;
        sliderApos = 5;
        fill(slider5Color); //full green 
        rect(186, 288,85,10);
        fill(0);
        text(awesome, 186 ,385 );
      }
      
    
    }
    else {
      sliderAOver = false;
      sliderApos = 0;
    }
    
   // println(sliderApos);
   
   
  //If the contribution checkbox is off, draw a rectangle
  if (check2On == false) {
  //Contribution slider bar
  //background fill values
  fill(195);
  rect(186  ,323  ,85,10);
  }  
   
   
  //If the check box is on, check whether the mouse is over the contribution slider bar
  else if ((186 < scalemouseX) && (scalemouseX < 271) && (323 < scalemouseY) && (scalemouseY < 333)) {  
      sliderBOver = true;
      
      if ((186<scalemouseX) && (scalemouseX < 203)) {
        slider1Over = true;
        sliderBpos = 1;
        //slider bar options
        fill(slider1Color); //full red
        rect(186, 323, 17,10);
        fill(0);
        text(terrible, 186 ,385 );
      }
      
      else if ((203<scalemouseX)&& (scalemouseX < 220)) {
        slider2Over = true;
        sliderBpos = 2;
        fill(slider2Color); //orange red
        rect(186, 323, 34, 10);
        fill(0);
        text(drag, 186 ,385 );
      }
      
      else if ((220 < scalemouseX) && (scalemouseX < 237)) {
        slider3Over = true;
        sliderBpos = 3;
        fill(slider3Color); //yellow
        rect(186, 323, 51, 10);
        fill(0);
        text(ok, 186 ,385 );
      }
      
      else if ((237 < scalemouseX) && (scalemouseX < 254)) {
        slider4Over = true;
        sliderBpos = 4;
        fill(slider4Color); //yellow green
        rect(186, 323,68,10);
        fill(0);
        text(good, 186 ,385 );
      } 
      
      else if ((254 < scalemouseX) && (scalemouseX < 271)) {
        slider5Over = true;
        sliderBpos = 5;
        fill(slider5Color); //full green 
        rect(186, 323,85,10);
        fill(0);
        text(awesome, 186 ,385 );
      }
      
      
    }
    else {
      sliderBOver = false;
      sliderBpos = 0;
    }
    
    
    
    
      
  if (check3On == false) {
  //Contribution slider bar
  //background fill values
  fill(195);
  rect(186  ,358  ,85,10);
  } 
    
  //Vitality slider bar
  
   
  //Check whether the mouse is over the vitality slider bar
  else if ((186 < scalemouseX) && (scalemouseX < 271) && (358 < scalemouseY) && (scalemouseY < 368)) {  
      sliderCOver = true;
      
      if ((186<scalemouseX) && (scalemouseX < 203)) {
        slider1Over = true;
        sliderCpos = 1;
        //slider bar options
        fill(slider1Color); //full red
        rect(186, 358, 17,10);
        fill(0);
        text(terrible, 186 ,385 );
      }
      
      else if ((203<scalemouseX)&& (scalemouseX < 220)) {
        slider2Over = true;
        sliderCpos = 2;
        fill(slider2Color); //orange red
        rect(186, 358, 34, 10);
        fill(0);
        text(drag, 186 ,385 );
      }
      
      else if ((220 < scalemouseX) && (scalemouseX < 237)) {
        slider3Over = true;
        sliderCpos = 3;
        fill(slider3Color); //yellow
        rect(186, 358, 51, 10);
        fill(0);
        text(ok, 186 ,385 );
      }
      
      else if ((237 < scalemouseX) && (scalemouseX < 254)) {
        slider4Over = true;
        sliderCpos = 4;
        fill(slider4Color); //yellow green
        rect(186, 358,68,10);
        fill(0);
        text(good, 186 ,385 );
      } 
      
      else if ((254 < scalemouseX) && (scalemouseX < 271)) {
        slider5Over = true;
        sliderCpos = 5;
        fill(slider5Color); //full green 
        rect(186, 358,85,10);
        fill(0);
        text(awesome, 186 ,385 );
      }
      
    
    }
    else {
      sliderCOver = false;
      sliderCpos = 0;
    }

}



      
