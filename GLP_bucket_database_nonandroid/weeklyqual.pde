void weeklyqual(int value) {

  drawheader();

  //Write days of week to screen
  textFont(font24, 14);
  float dayXpos = 25 ;
  float dayYpos = 143 ;
  float posYstep = 33;
  int i;  //used for loops

  final float qualScaleFactor = 45;  //brings the database data (-2 to 2) to the range of the graph (45pix per segment)

  // fill the connectVal, contribVal, and vitalVal arrays from the latest bucket data
  for (i = 0; i < days.length; i++) {
    connectVal[i] = myBuckets[i].connectVal * qualScaleFactor;
    contribVal[i] = myBuckets[i].contribVal * qualScaleFactor;
    vitalVal[i] = myBuckets[i].vitalVal * qualScaleFactor;
  }

  for (i = 0; i < days.length; i++) {

    fill(0);
    text(days[i], dayXpos, dayYpos); 

    //only graph days up to today
    if (i <= myDatabase.todaysWeekday()) {
      //draw connection bar for each day 
      noStroke();
      fill(connectColor);
      //reset variables for each set of bars
      float baselineXpos = (163 );
      float rectminX = 0;
      float rectmaxX = 0;

      if (connectVal[i] <= 0) { //if the connection score for the day is negative, draw a rectangle to the left of the baseline
        rectminX = baselineXpos+connectVal[i];
        rectmaxX = baselineXpos - rectminX;
      }
      if (connectVal[i] > 0) { //if positive, draw a rectangle to the right of the baseline
        rectminX = baselineXpos;
        rectmaxX = connectVal[i];
      }
      rect(rectminX, (dayYpos-(14 )), rectmaxX, (5 ));

      //contribution bar
      fill(contribColor);
      //reset variables (do not re-declare)
      baselineXpos = (163 );
      rectminX = 0;
      rectmaxX = 0;

      if (contribVal[i] <= 0) { //if the connection score for the day is negative, draw a rectangle to the left of the baseline
        rectminX = baselineXpos+contribVal[i];
        rectmaxX = baselineXpos - rectminX;
      }
      if (contribVal[i] > 0) { //if positive, draw a rectangle to the right of the baseline
        rectminX = baselineXpos;
        rectmaxX = contribVal[i];
      }
      rect(rectminX, (dayYpos-(8 )), rectmaxX, (5 ));


      //vitality bar
      fill(vitalColor);
      //reset variables (do not re-declare)
      baselineXpos = (163 );
      rectminX = 0;
      rectmaxX = 0;

      if (vitalVal[i] <= 0) { //if the connection score for the day is negative, draw a rectangle to the left of the baseline
        rectminX = baselineXpos + vitalVal[i];
        rectmaxX = baselineXpos - rectminX;
      }
      if (vitalVal[i] > 0) { //if positive, draw a rectangle to the right of the baseline
        rectminX = baselineXpos;
        rectmaxX = vitalVal[i];
      }
      rect(rectminX, (dayYpos-(2)), rectmaxX, (5));
    } 
    //increase the Y position for the day to prepare for the next iteration.
    dayYpos = dayYpos + posYstep;
  }


  //Draw graph baseline
  stroke(200);
  line((163), (125), (163), (345));



  //Draw graph legend (five-color bar)
  noStroke();
  fill(slider1Color); //full red
  rect((51 ), (110 ), (45 ), (5 ));  
  fill(slider2Color); //orange red
  rect((51+45 ), (110 ), (45 ), (5 ));
  fill(slider3Color); //yellow
  rect((51+2*45), (110 ), (45 ), (5 ));
  fill(slider4Color); //yellow green
  rect(((51+3*45) ), (110 ), (45), (5 ));
  fill(slider5Color); //full green  
  rect(((51+4*45) ), (110 ), (45 ), (5 ));







  //Write legend text to screen (connect,contrib,vital and boxes)
  fill(0);
  noStroke();
  textFont(font24, 20);
  text(connect, 64, 380 );
  text(contrib, 64, 414 );
  text(vital, 64, 448 );

  //color key indicators
  fill(connectColor); //connection
  rect(44, 368, 12, 12); //top left corner of rectangle for position marks

  fill(contribColor); //contribution
  rect(44, 400, 12, 12); //top left corner of rectangle for position marks

  fill(vitalColor); //vitality
  rect(44, 434, 12, 12); //top left corner of rectangle for position marks

  //Draw radio button components
  stroke(155);
  strokeWeight(0.5);
  noFill();
  ellipseMode(CENTER); //choose center as coordinate location
  ellipse(212, 398, 13, 13); 
  ellipse(212, 418, 13, 13);
  noStroke();
  fill(155);
  ellipse(212, 398, 7, 7);

  String quality = "Quality";
  String quantity = "Quantity";
  fill(0);
  textFont(font24, 14);
  text(quality, 225, 403);
  text(quantity, 225, 423);


  //Check for mouse over top radio button, highlight outside ring if mouse detected.
  //first, set some variables
  float topX = 212 ;
  float topY = 398 ;
  float topDiameter = 13 ;

  float bottomX = 212 ;
  float bottomY = 418 ;
  float bottomDiameter = 13 ;

  color bottomHighlight, bottomNormal;
  bottomHighlight = color(68, 68, 68);
  bottomNormal = color(155);
  float disX = bottomX - scalemouseX;
  float disY = bottomY - scalemouseY;
  boolean bottomOver;

  //Then, check whether the mouse is inside the button and set saveOver variable accordingly
  if (sqrt(sq(disX) + sq(disY)) < bottomDiameter/2 ) {
    bottomOver = true;
  } else {
    bottomOver = false;
  }

  //If the mouse is over the button, update the color to highlight (note that + needs to be re-drawn every time, since button is drawn on top of previous version)
  if (bottomOver == true) {
    fill(bottomHighlight);
    ellipse(bottomX, bottomY, 13, 13 );

    //set value variable to 1, so that the mouseClicked function will know to save the data
    bottomValue = 1;
    topValue = 0;
  }

  if (bottomOver == false) {
    fill(255);
    stroke(bottomNormal);
    ellipse(bottomX, bottomY, 13, 13 );
    //set value variable to 0, so that the mouseClicked function will know to save the data
    bottomValue = 0;
  }
}

