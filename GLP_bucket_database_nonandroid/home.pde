void home() {
 
 drawheader(); 
  
  //placeholder for pie chart
  noStroke();
//  fill(44,160,137);
//  ellipse( 320/2,(220 ),180  ,180 ); //ellipse dimensions given in radius, not diameter
  
  //get today's bucket number
  
  //get today's bucket statistics to calculate percents
  
  println(myBuckets[1].connectTime);
  println(myBuckets[1].contribTime);
  println(myBuckets[1].vitalTime);
  
  int day = myDatabase.todaysWeekday();
  
  float percentConnect = myBuckets[day].connectTime/(myBuckets[day].connectTime + myBuckets[day].contribTime + myBuckets[day].vitalTime);
  float percentContrib = myBuckets[day].contribTime/(myBuckets[day].connectTime+myBuckets[day].contribTime+myBuckets[day].vitalTime); 
  float percentVital = myBuckets[day].vitalTime/(myBuckets[day].connectTime+myBuckets[day].contribTime+myBuckets[day].vitalTime);
  
  float beginConnect = 0, endConnect = TWO_PI*percentConnect,  endContrib = endConnect+ (TWO_PI*percentContrib), endVital = endContrib + (TWO_PI*percentVital);

  //pie chart 
  fill(connectColor); //new connection color
//  fill(243,135,59); //connection
  arc( 320/2,(220 ),180  ,180 , beginConnect, endConnect, PIE);
  fill(contribColor);
  //fill(36,93,186);  //contribution
  arc( 320/2,(220 ),180  ,180 , endConnect, endContrib, PIE);
  fill(vitalColor);
  //fill(124,36,121); //vitality
  arc( 320/2,(220 ),180  ,180 , endContrib, endVital, PIE); //Note that zero and TWO_PI give different results! Drawn clockwise from zero (Xaxis) to TWO_PI

  //Write key words to screen
  fill(0);
  textFont(font24,20);
  text(connect,64  ,360 );
  text(contrib,64  ,394 );
  text(vital,64  ,428 );
  
  //color key indicators
  fill(connectColor); 
  rect(44  ,348 ,12,12); //top left corner of rectangle for position marks
  
  fill(contribColor);
  rect(44  ,380 ,12,12); //top left corner of rectangle for position marks
  
  fill(vitalColor);
  rect(44  ,414 ,12,12); //top left corner of rectangle for position marks
  
  //slider bar backgrounds
  fill(195);
//  rect(186+68, 288,17,10);
  rect(186  ,348 ,85,10);
  rect(186  ,382 ,85,10); 
  rect(186  ,418 ,85,10);
  
  
  //slider bar values
 
  if (myBuckets[day].connectVal < -1.5 )
    fill(slider1Color); //full red
  else if (myBuckets[day].connectVal < -0.5 )
    fill(slider2Color); //orange red
  else if (myBuckets[day].connectVal < .5 )
    fill(slider3Color); //yellow
  else if (myBuckets[day].connectVal < 1.5 )
    fill(slider4Color); //yellow green
  else
    fill(slider5Color); //full green     
  rect(186  ,348 , (myBuckets[day].connectVal * 21.25) + 42.5,10);  

  if (myBuckets[day].contribVal < -1.5 )
    fill(slider1Color); //full red
  else if (myBuckets[day].contribVal < -0.5 )
    fill(slider2Color); //orange red
  else if (myBuckets[day].contribVal < .5 )
    fill(slider3Color); //yellow
  else if (myBuckets[day].contribVal < 1.5 )
    fill(slider4Color); //yellow green
  else
    fill(slider5Color); //full green     
  rect(186  ,382,(myBuckets[day].contribVal * 21.25) + 42.5,10); 

  if (myBuckets[myDatabase.todaysWeekday()].vitalVal < -1.5 )
    fill(slider1Color); //full red
  else if (myBuckets[day].vitalVal < -0.5 )
    fill(slider2Color); //orange red
  else if (myBuckets[day].vitalVal < .5 )
    fill(slider3Color); //yellow
  else if (myBuckets[day].vitalVal < 1.5 )
    fill(slider4Color); //yellow green
  else
    fill(slider5Color); //full green     
  rect(186  ,418,(myBuckets[day].vitalVal * 21.25) + 42.5, 10);
 }
