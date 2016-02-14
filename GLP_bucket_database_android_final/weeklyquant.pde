void weeklyquant(int value) {
  
  drawheader();
  
  //Draw axes and labels
  stroke(200);
  line(28,320,300,320); //x axis
  line(28,120,28,320); //y axis
  
  String time = "Time";
  textFont(font24,14);
  fill(0);
  pushMatrix();           //separate text object from coordinate system of rest of sketch
  translate(22,228);      //move its origin to where I want the text to begin
  rotate(3*PI/2.0);       //rotate the grid for the text around its origin
  text(time,0,0);         //print the text to the screen, placing it at the origin of its own grid
  popMatrix();            //go back to the normal grid for everything else
  
  
  //Write days of week to screen
  float dayXpos = 32 ;
  float plotXpos = 32;
  float dayYpos = 340 ;
  float posXstep = 42;
  float plotXstep = 42;
  float connectA =0, connectB=0, contribA=0, contribB=0, vitalA=0, vitalB=0;
 
   //check which day of the week it is
  int day = myDatabase.todaysWeekday();
  //int day = 0;
  
  float[] bucketconnectTime = {myBuckets[0].connectTime,myBuckets[1].connectTime,myBuckets[2].connectTime,myBuckets[3].connectTime,myBuckets[4].connectTime,myBuckets[5].connectTime,myBuckets[6].connectTime};
  float[] bucketcontribTime = {myBuckets[0].contribTime,myBuckets[1].contribTime,myBuckets[2].contribTime,myBuckets[3].contribTime,myBuckets[4].contribTime,myBuckets[5].contribTime,myBuckets[6].contribTime};
  float[] bucketvitalTime = {myBuckets[0].vitalTime,myBuckets[1].vitalTime,myBuckets[2].vitalTime,myBuckets[3].vitalTime,myBuckets[4].vitalTime,myBuckets[5].vitalTime,myBuckets[6].vitalTime};

  float maxConnect = max(bucketconnectTime);
  float maxContrib = max(bucketcontribTime);
  float maxVital = max(bucketvitalTime);
  float weeklymax = max(maxConnect, maxContrib, maxVital);
  println(weeklymax);
 
  for (int i = 0; i < 7; i++) {
    fill(0);
    text(days[i],dayXpos,dayYpos); 
    
    //also draw tick marks
    stroke(200);
    line(dayXpos+5, 320, dayXpos+5, 323); 
    line(28,320-180,31,320-180); //draw y axis tick mark 180 pixels above the x axis (will mark with weekly max)   
    noStroke();
    dayXpos = dayXpos + posXstep;
  }   
    fill(200);  
    textFont(font24,12);  
    text(int(weeklymax) +" hours", 35, 320-180+5);  //180 pixels above the x axis
    
        
    if (day == 0) {
      fill(connectColor);  //connection
      ellipse(plotXpos+4, 320-(180*myBuckets[day].connectTime/weeklymax),5,5);
      fill(contribColor); //contribution
      ellipse(plotXpos+4, 320-(180*myBuckets[day].contribTime/weeklymax),5,5);
      fill(vitalColor); //vitality
      ellipse(plotXpos+4, 320-(180*myBuckets[day].vitalTime/weeklymax),5,5);
     }
    
    else if (day != 0) {
    
      for (int h = 0; h < day; h++) {
        println(myBuckets[h].connectTime);
        
        //Plot points
        stroke(connectColor);  //connection
        line(plotXpos+4, 320-(180*(myBuckets[h].connectTime/weeklymax)),plotXpos+plotXstep+4, 320-(180*(myBuckets[h+1].connectTime/weeklymax))   );
        
        stroke(contribColor); //contribution
        line(plotXpos+4, 320-(180*myBuckets[h].contribTime/weeklymax),plotXpos+plotXstep+4,320-(180*myBuckets[h+1].contribTime/weeklymax));
        
        stroke(vitalColor); //vitality
        line(plotXpos+4, 320-(180*myBuckets[h].vitalTime/weeklymax),plotXpos+plotXstep+4,320-(180*myBuckets[h+1].vitalTime/weeklymax));
       
        plotXpos = plotXstep + plotXpos;
 
       
      }
    }
     
      
  
//    for (int j = 1; j <=i; j++) {
//      fill(0);
//      line(dayXpos-posXstep,320-connectTime[j-1],dayXpos,320-connectTime[j]);
//    }
    
 
    
 
   
  


  
  //Write legend text to screen (connect,contrib,vital and boxes)
  fill(0);
  noStroke();
  textFont(font24,20);
  text(connect, 64 , 380 );
  text(contrib, 64 , 414 );
  text(vital,   64 , 448 );
  
  //color key indicators
  fill(connectColor); //connection
  rect(44 ,368 ,12,12); //top left corner of rectangle for position marks
  
  fill(contribColor); //contribution
  rect(44 ,400 ,12,12); //top left corner of rectangle for position marks
  
  fill(vitalColor); //vitality
  rect(44 ,434 ,12,12); //top left corner of rectangle for position marks
      
  //Draw radio button components
  stroke(155);
  strokeWeight(0.5);
  noFill();
  ellipseMode(CENTER); //choose center as coordinate location
  ellipse(212,394,15,15); 
  ellipse(212,422,15,15);
  noStroke();
  fill(155);
  ellipse(212,422,9,9);
  
  String quality = "Quality";
  String quantity = "Quantity";
  fill(0);
  textFont(font24,14);
  text(quality, 225,399);
  text(quantity, 225,427);
  
  
    //Check for mouse over top radio button, highlight outside ring if mouse detected.
    //first, set some variables
    float topX = 212 ;
    float topY = 394 ;
    float topDiameter = 15 ;
    
    float bottomX = 212 ;
    float bottomY = 422 ;
    float bottomDiameter = 15 ;
    
    color topHighlight, topNormal;
    topHighlight = color(68,68,68);
    topNormal = color(155);
    float disX = topX - scalemouseX;
    float disY = topY - scalemouseY;
    boolean topOver;

    //Then, check whether the mouse is inside the button and set saveOver variable accordingly
    if (sqrt(sq(disX) + sq(disY)) < topDiameter/2 ) {
      topOver = true;
    } 
    else {
      topOver = false;
    }

    //If the mouse is over the button, update the color to highlight (note that + needs to be re-drawn every time, since button is drawn on top of previous version)
    if (topOver == true) {
      fill(topHighlight);
      ellipse(topX,topY,15 ,15 );
      
      //set value variable to 1, so that the mouseClicked function will know to save the data
      topValue = 1;
      bottomValue = 0;
    }
    
     if (topOver == false) {
      fill(255);
      stroke(topNormal);
      ellipse(topX,topY,15 ,15 );
      //set value variable to 1, so that the mouseClicked function will know to save the data
      topValue = 0;
    }
    
}
