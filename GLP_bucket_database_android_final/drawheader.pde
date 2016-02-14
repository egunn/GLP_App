void drawheader() {
 
  //draw dark gray header bar, header text 
  noStroke();
  fill(68,68,68);
  rect(0,0,320, 73);
  textFont(font24,24);
  fill(255);                        
  text(heading,(20),(45)); //left baseline of textbox controls position, reference off of screen coordinates
 
  //Set fill and stroke colors for menu bar objects 
  stroke(200);
  strokeWeight(2);
  
  color menuHighlight, menuActive, menuInactive; //Highlight is mouse-over, Active is currently selected page, Inactive is non-selected page
  menuHighlight = color(205);
  menuActive = color(235);
  menuInactive = color(255);
  
  //decide which page is active and highlight that header box, based on pageValue variable used for page selection
  switch(pageValue) {
    case 1:   //Navigation bar outlines for home page
      fill(menuActive);
      rect(0,73,320/4,(24));
      fill(menuInactive);
      rect(320/4,73,320/4,(24 ));
      rect((2*320/4),73,320/4,(24 ));
      rect((3*320/4),73,320/4,(24 ));
      textFont(font24,18);
    break;
    
    case 2: 
      //Navigation bar outlines log page
      fill(menuInactive);
      rect(0,73, 320/4,(24 ));
      fill(menuActive);
      rect( 320/4,73, 320/4,(24 ));
      fill(menuInactive);
      rect((2* 320/4),73, 320/4,(24 ));
      rect((3* 320/4),73, 320/4,(24 ));
      textFont(font24,18);
    break;
    
    case 3: 
      //Navigation bar outlines  new activity page
      fill(menuInactive);
      rect(0,73, 320/4,(24  ));
      rect( 320/4,73, 320/4,(24  ));
      fill(menuActive);
      rect((2* 320/4),73, 320/4,(24  ));
      fill(menuInactive);
      rect((3* 320/4),73, 320/4,(24  ));
      textFont(font24,18);
    break;
    
    case 4:
      //Navigation bar outlines  weekly qual
      fill(menuActive);
      rect((3* 320/4),73, 320/4,(24 ));
      fill(menuInactive);
      rect(320/4,73, 320/4,(24 ));
      rect((2* 320/4),73, 320/4,(24 ));
      rect(0,73, 320/4,(24 ));
      textFont(font24,18);
    break; 
 
   case 5:
      //Navigation bar outlines  weekly quant
      fill(menuActive);
      rect((3* 320/4),73, 320/4,(24 ));
      fill(menuInactive);
      rect(320/4,73, 320/4,(24 ));
      rect((2* 320/4),73, 320/4,(24 ));
      rect(0,73, 320/4,(24 ));
      textFont(font24,18);
 
  }
  
  
  //Navigation bar text
  fill(155);
  String home = "Home";
  text(home,(0 + 16  ),(77 ),320/4,(24 )); 
  
  String log = "Log";
  text(log,(320/4 + 25  ),(77 ),320/4,(24 )); 
  
  String activ = "+Activity";
  text(activ,(2*320/4 + 6  ),(77 ), 320/4,(24 ));
  
  String weekly = "Weekly";
  text(weekly,(3* 320/4 + 12  ),(77 ), 320/4,(24 ));

  boolean homeOver, logOver, activOver, weeklyOver;
    
  //Check whether the mouse is over the "Home" menu item
  if ((0 < scalemouseX) && (scalemouseX < 320/4) && (73 < scalemouseY) && (scalemouseY < 97)) {  //97 = 73+24      && (73 << scalemouseY << 97)
    homeOver = true;
  }
  else {
    homeOver = false;
  }
    
 //If it is, change the fill for the "Home" item
  if (homeOver == true) {
    fill(menuHighlight);
    rect(0,73,320/4,(24));
    fill(255);
    text(home,(0 + 16),(75),320/4,(24)); 
    homeValue = 1;   
  }
  else {
    homeValue = 0;
  }

 //Check whether the mouse is over the "Log" menu item
 if ((320/4 < scalemouseX) && (scalemouseX < 2*320/4) && (73 < scalemouseY) && (scalemouseY < 97)) {  //97 = 73+24      && (73 << scalemouseY << 97)
   logOver = true;
 }
 else {
   logOver = false;
 }
    
 //If it is, change the fill for the "log" item
 if (logOver == true) {
   fill(menuHighlight);
   rect(320/4,73, 320/4,(24 ));
   fill(255);
   text(log,(320/4 + 25  ),(75 ),320/4,(24 ));
   logValue = 1;   
 }
 else {
   logValue = 0;
 }
    
 //Check whether the mouse is over the "+Activity" menu item
 if ((2*320/4 < scalemouseX) && (scalemouseX < 3*320/4) && (73 < scalemouseY) && (scalemouseY < 97)) {  //97 = 73+24      && (73 << scalemouseY << 97)
   activOver = true;
 }
 else {
   activOver = false;
 }
   
 //If it is, change the fill for the "Activity" item
 if (activOver == true) {
   fill(menuHighlight);
   rect(2*320/4,73, 320/4,(24 ));
   fill(255);
   text(activ,(2*320/4 + 6  ),(75 ), 320/4,(24 ));
   activValue = 1;   
 }
 else {
   activValue = 0;
 }
    
 //Check whether the mouse is over the "weekly" menu item
 if ((3*320/4 < scalemouseX) && (scalemouseX < 320) && (73 < scalemouseY) && (scalemouseY < 97)) {  //97 = 73+24      && (73 << scalemouseY << 97)
   weeklyOver = true;
 }
 else {
   weeklyOver = false;
 }
    
 //If it is, change the fill for the "weekly" item
 if (weeklyOver == true) {
   fill(menuHighlight);
   rect(3*320/4,73, 320/4,(24 ));
   fill(255);
   text(weekly,(3* 320/4 + 12  ),(75 ), 320/4,(24 )); 
   weeklyValue = 1;   
 }
 else {
   weeklyValue = 0;
 }
  
}
  


