//If the mouse is clicked, display text in the console 
//*****************change to load the Weekly Quantity page************************* 

void mouseClicked() {
   if ((pageValue == 5) && (topValue == 1)) { //if clicking inside top radiobutton circle
     pageValue = 4;
     }
   
   else if ((pageValue == 4) && (bottomValue == 1)) {  //if clicking inside bottom radiobutton circle
     pageValue = 5;
   }
   
   else if ((plusValue == 1) && (pageValue == 2)) {
     pageValue = 1;
     saveValue = 0;
   }
   
   else if (homeValue == 1) {
     pageValue = 3;
   }
   
   else if (logValue == 1) {
     pageValue = 2;
   }
   
   else if (activValue == 1) {
     pageValue = 1;
   }
   
   else if (weeklyValue == 1) {
     pageValue = 4;
   }
   
  
   if ((pageValue == 1) && (saveValue == 1)) {
     pageValue = 2;
     Submit();
   }
   
   if ((pageValue == 1) && (sliderApos > 0)) {
     sliderAVal = sliderApos;
     println(sliderAVal + " mouseclicked");     
   }
   
   if ((pageValue == 1) && (sliderBpos > 0)) {
     sliderBVal = sliderBpos;
     println(sliderBVal + " mouseclicked");
   }
     
   if ((pageValue == 1) && (sliderCpos > 0)) {
     sliderCVal = sliderCpos;
     println(sliderCVal + " mouseclicked");
   }  
       
   if ((pageValue == 1) && (check1Over == true)) {
     check1Click = true;
//     println(check1Click + "check1Click mouseclick");
   } 
      
   if ((pageValue == 1) && (check2Over == true)) {
     check2Click = true;
//     println(check2Click + "check2Click mouseclick");
   } 
     
   if ((pageValue == 1) && (check3Over == true)) {
     check3Click = true;
//     println(check3Click + "check3Click mouseclick");
   } 
   
   else {
 //    println("outside button");
   }
}
