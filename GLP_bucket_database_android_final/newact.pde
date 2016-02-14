void newact(int value) {

//TODO: if the minutes field is an int between 0 and 9, auto prefix with a 0
  
 
  //*************Add text entry box here**************
  background(255);
  
  noStroke();

//  rect(35  ,142  ,247  ,28  );
  
  //cp5.show();
  
  //*****************Draw in dummy text "Activity" "hh" "mm"**********************
 

  String textinput = "";

//  drawtextbox();
  
  drawheader();
  
//  //*************Add time entry tool here***************
//  rect(112  ,204  ,46  ,28  );
//  rect(164  ,204  ,46  ,28  );
//  fill(155);

  //colon between two time textboxes
  fill(155);
  textFont(font24,24);
  text(colon,153  ,202  ,46  ,40  );
  

  //Write key words to screen
  fill(0);
  textFont(font24,20);
  text(connect,64  ,300  );
  text(contrib,64  ,334  );
  text(vital,64  ,368  );
  
  //color key indicators
  noStroke();
  fill(connectColor); 
  rect(44  ,288  ,12,12); //top left corner of rectangle for position marks
  
  fill(contribColor);
  rect(44  ,320  ,12,12); //top left corner of rectangle for position marks
  
  fill(vitalColor);
  rect(44  ,354  ,12,12); //top left corner of rectangle for position marks
  
  //Set up check boxes for each slider 
  //set variables 
  color checkHighlight, checkNormal;
  checkHighlight = color(155);
  checkNormal = color(200);

  
  //draw checkmarks for each legend entry
  checkmark = loadImage("checkmark.png");
  checkmark.resize(15,0);  //using 0 forces proportional resize
  stroke(checkNormal);
  noFill();
  if (check1On == true) {
    rect(280, 288, 10,10);
    image(checkmark, 281  ,284);
  }
  
  else if (check1On == false) {
    rect(280, 288, 10,10);
  }
  
  if (check2On == true) {
    rect(280, 323, 10,10);
    image(checkmark, 281  ,319);
  }
  
  else if (check2On == false) {
    rect(280, 323, 10,10);
  }
  
//  rect(280, 323, 10,10);
//  image(checkmark, 281  ,318);
//  rect(280, 358, 10,10);
//  image(checkmark, 281  ,353);
  
if (check3On == true) {
    rect(280, 358, 10,10);
    image(checkmark, 281  ,354);
  }
  
  else if (check3On == false) {
    rect(280, 358, 10,10);
  }

  
    //Check whether the mouse is over the check1 button (connection)
    if ((280 < scalemouseX) && (scalemouseX < 290) && (288 < scalemouseY) && (scalemouseY < 298)) {  //272 = 185+87, 434 = 405+29
        check1Over = true;
      }
      else {
        check1Over = false;
      }
      
      //If it is, change the stroke color for the check1 box
      if (check1Over == true) {
        stroke(checkHighlight);
        rect(280, 288, 10,10);
      
        if (check1Click == false) {
          //do nothing
        }
        else if ((check1Click == true) && (check1On == true)) {
            //turn box off, deactivate slider, set check1On to false
            check1On = false;
            check1Click = false;
            
        }
          
        else if ((check1Click == true) && (check1On == false)) {
            //turn box on, activate slider, set check1On to true, record slider vals using slider()
            check1On = true;
            check1Click = false;
        }
     }
    
        

  //Check whether the mouse is over the check2 button (contribution)
    if ((280 < scalemouseX) && (scalemouseX < 290) && (323 < scalemouseY) && (scalemouseY < 333)) {  //272 = 185+87, 434 = 405+29
        check2Over = true;
      }
      else {
        check2Over = false;
      }
      
      //If it is, change the stroke color for the check2 box
      if (check2Over == true) {
        stroke(checkHighlight);
        rect(280, 323, 10,10);
        
        if (check2Click == false) {
          //do nothing
        }
        else if ((check2Click == true) && (check2On == true)) {
            //turn box off, deactivate slider, set check1On to false
            check2On = false;
            check2Click = false;

            
        }
          
        else if ((check2Click == true) && (check2On == false)) {
            //turn box on, activate slider, set check1On to true, record slider vals using slider()
            check2On = true;
            check2Click = false;
        }
     }



  //Check whether the mouse is over the check3 button (contribution)
    if ((280 < scalemouseX) && (scalemouseX < 290) && (358 < scalemouseY) && (scalemouseY < 368)) { 
        check3Over = true;
      }
      else {
        check3Over = false;
      }
      
      //If it is, change the stroke color for the check1 box
      if (check3Over == true) {
        stroke(checkHighlight);
        rect(280, 358, 10,10);
        
        if (check3Click == false) {
          //do nothing
        }
        else if ((check3Click == true) && (check3On == true)) {
            //turn box off, deactivate slider, set check3On to false
            check3On = false;
            check3Click = false;
            
        }
          
        else if ((check3Click == true) && (check3On == false)) {
            //turn box on, activate slider, set check3On to true, record slider vals using slider()
            check3On = true;
            check3Click = false;
            //sliderCpos = 0; does overwrite fill rectangles, but with a slight delay. Better to find appropriate location in slider function
        }
     }

  
  //**************Import sliders from Controlp5, at these locations**************
  noStroke();
  fill(195);
  rect(186  ,288  ,85,10);
  rect(186  ,323  ,85,10); 
  rect(186  ,358  ,85,10);
  
  
/*  //background fill for slider bars
  fill(200,31,47);  
  rect(186  ,288  ,25,10);  //use random lengths for now - replace with database readout later.
  fill(252,212,80);  
  rect(186  ,323  ,60,10); 
  fill(31,148,42);   
  rect(186  ,358  ,42,10);


if ((check1On == true)) {
 //slider(186, 288, 85,10, sliderAVal);
 //slider();
 //sliderAVal = sliderVal;
}

else if (check1On == false) {
  //show a greyed out slider 
  fill(195);
  rect(186, 288, 85,10);
}


if (check2On == true) {
 //slider(186, 323, 85,10, sliderBVal);
 sliderBVal = sliderBpos;
}

else if (check2On == false) {
  //show a greyed out slider 
  fill(195);
  rect(186, 323, 85,10);
}
  
  
if (check3On == true) {
 //slider(186, 323, 85,10, sliderBVal);
 sliderCVal = sliderCpos;
}

else if (check3On == false) {
  //show a greyed out slider 
  fill(195);
  rect(186, 358, 85,10);
}  
  
*/

   slider();
  
  
  
  
  
  
  
/*    
  //slider bar options
  fill(255, 42,42); //full red
  rect(186, 288, 17,10);
  fill(255,127,42); //orange red
  rect(186+17, 288, 17, 10);
  fill(255,204,0); //yellow
  rect(186+34, 288, 17, 10);
  fill(55,200,55); //yellow green
  rect(186+51, 288,17,10);
  fill(0, 170,0); //full green
  rect(186+68, 288,17,10);
  
  //Contribution slider bar
  //background fill values
  fill(195);
  rect(186  ,323  ,85,10);
  //slider bar options
  fill(255, 42,42); //full red
  rect(186, 323, 17,10);
  fill(255,127,42); //orange red
  rect(186+17, 323, 17, 10);
  fill(255,204,0); //yellow
  rect(186+34, 323, 17, 10);
  fill(55,200,55); //yellow green
  rect(186+51, 323,17,10);
  fill(0, 170,0); //full green
  rect(186+68, 323,17,10);
  
  //Vitality slider bar
  //background fill values
  fill(195);
  rect(186  ,358  ,85,10);
  //slider bar options
  fill(255, 42,42); //full red
  rect(186, 358, 17,10);
  fill(255,127,42); //orange red
  rect(186+17, 358, 17, 10);
  fill(255,204,0); //yellow
  rect(186+34, 358, 17, 10);
  fill(55,200,55); //yellow green
  rect(186+51, 358,17,10);
  fill(0, 170,0); //full green
  rect(186+68, 358,17,10);
  
 */ 
 
 
 
  //draw Save button
  fill(155);
  rect(185, 405, 87, 29, 9);
  fill(255);
  textFont(font24,18);
  text(save, 209, 425);
  
  color saveHighlight, saveNormal;
  saveHighlight = color(68,68,68);
  saveNormal = color(155);
  boolean saveOver;
 // saveOver = false;
  
  //Check whether the mouse is over the save button
  if ((185 < scalemouseX) && (scalemouseX < 272) && (405 < scalemouseY) && (scalemouseY < 434)) {  //272 = 185+87, 434 = 405+29
      saveOver = true;
    }
    else {
      saveOver = false;
    }
    
    //If it is, change the fill for the "save" button
    if (saveOver == true) {
      fill(saveHighlight);
      rect(185, 405, 87, 29, 9);
      fill(255);
      text(save, 209, 425); 
      saveValue = 1;  
//      println("over save");
    }
    else {
      saveValue = 0;
//      println("outside button");
    }
  
}


