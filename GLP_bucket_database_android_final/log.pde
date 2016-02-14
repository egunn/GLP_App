void logpg(int value) {


   drawheader(); 
  
  //insert table (reworked from comment on: http://geojournalism.org/2013/08/portugues-as-cidades-mais-populosas-do-mundo/)
  float nColumns = 5;
  float nLines = 13;
  
  float posX = (39 );
  float posY = (122 );
  // float shiftposX = (112 );
  float shiftposY = (20 );
   
  for(int i = 0; i < nLines; i++){
      noFill();
      stroke(200);
      rectMode(CENTER);
      rect(posX + (9 ),                 posY, 86 , 20 ); //use dist btwn centers to determine interval to add. For center-oriented drawing, need to recalc all distances
      rect(posX + (9 )+ 63 ,            posY, 40 , 20 );
      rect(posX + (9 )+ (63+54) ,       posY, 67 , 20 );
      rect(posX + (9 )+ (63+54+68) ,    posY, 70 , 20 );
      rect(posX + (9 )+ (63+54+68+58) , posY, 46 , 20 );
      
      if (i == 0) {
      //Fill top row of table with column names
      fill(0);
      textFont(font24,12);
      //measure text position from the center of the box to simplify alignment with box 
      textAlign(CENTER);
      //inherit positions from box (rectangle) positions above. A 3 pt shift in y was needed to get proper alignment
      text(activity, posX + (9 ),                 posY+5 , 86 , 20 );  
      text(time,     posX + (9 )+ 63 ,            posY+5 , 40 , 20 );
      text(connect,  posX + (9 )+ (63+54) ,       posY+5 , 66 , 20 );
      text(contrib,  posX + (9 )+ (63+54+68) ,    posY+5 , 70 , 20 );
      text(vital,    posX + (9 )+ (63+54+68+58) , posY+5 , 46 , 20 );
      textAlign(LEFT);
      }

    //increment position variables one step, reset rectangle mode for other function alignments
    posY = posY + shiftposY;
    posX = (39 );
    rectMode(CORNER);


  }

    //write table values
    
    //go through each line in the myActivitiesToday column and write names to table
    // ********************** (note that this will be a problem with arrays bigger than the number of rows in the table)**************
    //start at row 1 because headings go in row 0. (possibly change to match index values later?)
    int row = 0;
    //hard-code X positions for now, to match above. Keep values explicit for ease of editing.
    int namecellXpos =    39 + 9;
    int timecellXpos =    39 + 9 + 63;
    int connectcellXpos = 39 + 9 + 63 + 54;
    int contribcellXpos = 39 + 9 + 63 + 54 + 68;
    int vitalcellXpos =   39 + 9 + 63 + 54 + 68 + 58;
    //note that 122 is the posY value for the first box in the table above, but can't use that variable because it iterates separately (for now). Also, since this is the 1st rather than the 0th row, need to add shift even on first box written.
    float cellYpos; 
    int shiftcellYpos = 20;

    textAlign(CENTER);  //keep text aligned using center to make it easy to match the rectangles above.
    fill(0);  //changing color changes both sets of text (large and small)
    textFont(font24,12);  //declare font choices again, even though they should inherit from previous (avoids problems in editing later)
    
    //update to check lengths of myActivitiesToday and nLines and wrap this in an if/else statement to deal with discrepancies. 
    //Also, consider not drawing activity tables longer than required for the myActivitiesToday function, and modifying the table draw function above accordingly.
    
//    text(myActivitiesToday[0].name,namecellXpos,cellYpos);

     
     for (int q = 0; q < myActivitiesToday.length ; q++) {    
       row = q +1;  
       cellYpos = (126)+((row)*shiftcellYpos);  
//       fill(0);
//       textFont(font24,12);  //declare font choices again, even though they should inherit from previous (avoids problems in editing later)
       //text(myActivitiesToday[q].name,namecellXpos,cellYpos); 
     
        
//        //check if activity name is longer than 7 characters. If so, only display the first 7.        
//        if (myActivitiesToday[q].name.length() > 10) {
//            text(myActivitiesToday[q].name.substring(0,10),namecellXpos,cellYpos); 
//        }
//        
//        else if (myActivitiesToday[q].name.length() <= 10) {
//            text(myActivitiesToday[q].name,namecellXpos,cellYpos); 
//        }  


          //If the text is wider than the box
          //crop the text by one letter and test again (loop)
          //If the text is not wider than the box
          //print the text.
           
          float stringwidth = textWidth(myActivitiesToday[q].name);
          
          if (stringwidth > 84){
            
            for (int v = myActivitiesToday[q].name.length(); v>0; v--) {
              stringwidth = textWidth(myActivitiesToday[q].name.substring(0,v));
             
              if (stringwidth <= 84) {
                 text(myActivitiesToday[q].name.substring(0,v),namecellXpos,cellYpos);
                 break;
              }
            }
          }

          else if (textWidth(myActivitiesToday[q].name) <= 84) {
              text(myActivitiesToday[q].name,namecellXpos,cellYpos);
          }
     }
             

//          //check if text width is greater than the width of the box.
//          if (textWidth(myActivitiesToday[q].name) > 86) {
//            for (int v = myActivitiesToday[q].name.length(); v > 6; v--){
//               if (myActivitiesToday[q].name.length() <= 86) {
//                 text(myActivitiesToday[q].name.substring(0,v),namecellXpos,cellYpos);
//               }
//            }
//          }
//          else if (textWidth(myActivitiesToday[q].name) <= 86){
//            text(myActivitiesToday[q].name,namecellXpos,cellYpos); 
//          }
//      }   
//     
 
     for (int r = 0; r < myActivitiesToday.length ; r++) {    
        row = r +1;
        cellYpos = (126)+((row)*shiftcellYpos);   
        text(myActivitiesToday[r].timeIn_h+ ":" + (myActivitiesToday[r].timeIn_m < 10 ? "0" : "") + myActivitiesToday[r].timeIn_m,timecellXpos,cellYpos);
//        myActivity.date = String.valueOf(year()) + "." + String.valueOf(month()) + "." + String.valueOf(day());
     }        
     
     
//     color key:     
//     fill(255, 42,42); //full red
//     fill(255,127,42); //orange red
//     fill(255,204,0); //yellow
//     fill(55,200,55); //yellow green
//     fill(31,148,42); //full green     
     
     rectMode(CENTER);   
     textFont(font24,18); 
             
     for (int s = 0; s < myActivitiesToday.length ; s++) {    
        row = s +1;
        cellYpos = (126)+((row)*shiftcellYpos);   
        
        if (myActivitiesToday[s].connectApplic == true)
        {
          switch (myActivitiesToday[s].connectScore) {
            case -2:
              fill(slider1Color);  //full red
              rect(connectcellXpos,cellYpos-4,68 , 20);
              fill(235);
              text("-",connectcellXpos,cellYpos+2);
            break;
            
            case -1:
              fill(slider2Color);  //orange red
              rect(connectcellXpos,cellYpos-4, 68 , 20);
              fill(235);
              text("-",connectcellXpos,cellYpos+2);
            break;
            
            case 0: 
              fill(slider3Color); //yellow
              rect(connectcellXpos,cellYpos-4,68 , 20);
            break;
            
            case 1: 
              fill(slider4Color); //yellow green
              rect(connectcellXpos,cellYpos-4,68 , 20);
              fill(235);
              text("+",connectcellXpos,cellYpos+2);
            break;
            
            case 2:
              fill(slider5Color); //full green 
              rect(connectcellXpos,cellYpos-4,68 , 20);
              fill(235);
              text("+",connectcellXpos,cellYpos+2);
            break;
          }
       
          }
          else if (myActivitiesToday[s].connectApplic == false) {
            fill(255); 
            rect(connectcellXpos,cellYpos-4,68 , 20);
          }
        
     }       


     for (int t = 0; t < myActivitiesToday.length ; t++) {    
        row = t +1;
        cellYpos = (126)+((row)*shiftcellYpos);   
        
        if (myActivitiesToday[t].contribApplic == true)
        {
          switch (myActivitiesToday[t].contribScore) {
            case -2:
              fill(slider1Color);  //full red
              rect(contribcellXpos,cellYpos-4,68 , 20);
              fill(235);
              text("-",contribcellXpos,cellYpos+2);
            break;
            
            case -1:
              fill(slider2Color);  //orange red
              rect(contribcellXpos,cellYpos-4, 68 , 20);
              fill(235);
              text("-",contribcellXpos,cellYpos+2);
            break;
            
            case 0: 
              fill(slider3Color); //yellow
              rect(contribcellXpos,cellYpos-4,68 , 20);
            break;
            
            case 1: 
              fill(slider4Color); //yellow green
              rect(contribcellXpos,cellYpos-4,68 , 20);
              fill(235);
              text("+",contribcellXpos,cellYpos+2);
            break;
            
            case 2:
              fill(slider5Color); //full green 
              rect(contribcellXpos,cellYpos-4,68 , 20);
              fill(235);
              text("+",contribcellXpos,cellYpos+2);
            break;
          }
       
          }
          else if (myActivitiesToday[t].contribApplic == false) {
            fill(255); 
            rect(contribcellXpos,cellYpos-4,68 , 20);
          }
        
     }   



        for (int u = 0; u < myActivitiesToday.length ; u++) {    
        row = u +1;
        cellYpos = (126)+((row)*shiftcellYpos);   
        
        if (myActivitiesToday[u].vitalApplic == true)
        {
          switch (myActivitiesToday[u].vitalScore) {
            case -2:
              fill(slider1Color);  //full red
              rect(vitalcellXpos,cellYpos-4,46 , 20);
              fill(235);
              text("-",vitalcellXpos,cellYpos+2);
            break;
            
            case -1:
              fill(slider2Color);  //orange red
              rect(vitalcellXpos,cellYpos-4, 46 , 20);
              fill(235);
              text("-",vitalcellXpos,cellYpos+2);
            break;
            
            case 0: 
              fill(slider3Color); //yellow
              rect(vitalcellXpos,cellYpos-4,46 , 20);
            break;
            
            case 1: 
              fill(slider4Color); //yellow green
              rect(vitalcellXpos,cellYpos-4,46 , 20);
              fill(235);
              text("+",vitalcellXpos,cellYpos+2);
            break;
            
            case 2:
              fill(slider5Color); //full green 
              rect(vitalcellXpos,cellYpos-4,46 , 20);
              fill(235);
              text("+",vitalcellXpos,cellYpos+2);
            break;
          }
       
          }
          else if (myActivitiesToday[u].vitalApplic == false) {
            fill(255); 
            rect(vitalcellXpos,cellYpos-4,46 , 20);
          }
        
     }   


    textAlign(LEFT);
    rectMode(CORNER);

    //plus button
    fill(155);
    noStroke();
    float buttonX = 270;
    float buttonY = 422;
    float buttonDiameter = 40;
    
    //draw button, add + sign (use centered text to help with alignment)
    ellipse(buttonX,buttonY,40 ,40 );
    textFont(font24,28);
    textAlign(CENTER);
    fill(255);
    String plus = "+";
    text(plus,270,431);
    textAlign(LEFT);
    
    //Check for mouse over + button, highlight if mouse detected.
    //first, set some variables
    color plusHighlight, plusNormal;
    plusHighlight = color(68,68,68);
    plusNormal = color(155);
    float disX = buttonX - scalemouseX;
    float disY = buttonY - scalemouseY;
    boolean plusOver;

    //Then, check whether the mouse is inside the button and set plusOver variable accordingly
    if (sqrt(sq(disX) + sq(disY)) < buttonDiameter/2 ) {
      plusOver = true;
    }
    else {
    plusOver = false;
    }

    //If the mouse is over the button, update the color to highlight (note that + needs to be re-drawn every time, since button is drawn on top of previous version)
    if (plusOver == true) {
      fill(plusHighlight);
      ellipse(buttonX,buttonY,40 ,40 );
      textFont(font24,28);
      textAlign(CENTER);
      fill(255);
      text(plus,270,431);
      textAlign(LEFT);
      
      //set value variable to 1, so that the mouseClicked function will know to save the data
      plusValue = 1;
    }
    
    if(plusOver == false) {
      plusValue = 0;
    }
  
  
}



