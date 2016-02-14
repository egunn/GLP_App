import controlP5.*;
 
ControlP5 actin, hoursin, minsin; //declare textboxes of class ControlP5 to get activity name and times from user (newact page)
//Label actLabel;

PFont font24; //create a font object of class PFont to be used for all text displays

//Declare static text strings that will be used throughout the program
String heading = "Good Life Project"; 
String connect = "Connection";
String contrib = "Contribution";
String vital = "Vitality";
String activity = "Activity";
String  time = "Time";
String save = "Save";
String colon = ":";
String[] days = {"M", "T", "W", "R","F","Sa","Su"};

//create string to hold user inputs for textboxes
//needs to exist outside of the newact page function, because used in function calls at the end of the newact tab
String activityText = "", hourText = "", minText = "";

//create dummy arrays to hold data for plotting (replace with database struct in final version)
float[] connectVal = {50,52, 10,-40,17,-60,-40};
float[] contribVal = {10,-20, -8, 30, 9, 25,-25};
float[] vitalVal = {-1, 2, 0, 1, 2, -2, 1};
float[] connectTime = {1,3, 2,7,5,0,3};
float[] contribTime = {2,7, 3, 6, 5, 9,2};
float[] vitalTime = {4, 6, 2, 4, 11, 0, 1};
float scaleX = 1;
float scaleY = 1;
float scalemouseX = mouseX/scaleX;  //change to adjust screen scaling for phone/resizing
float scalemouseY = mouseY/scaleY;

//float scrscale = 4.5;  //use when scaling screen for phone display

int topValue = 0;     //radiobutton value on weekly pages (Quantity is top)
int bottomValue = 0;  //radiobutton value on weekly pages (Quantity is top)
int plusValue = 0;    //value for the add activity button on the log page (used for setting selection highlight on mouseover and page change on mouse click)
int saveValue = 0;    //value for the save button on the newact page
int homeValue = 0;    //value for the header tab "home"
int logValue = 0;     //value for the header tab "log"
int activValue = 0;   //value for the header tab "+Activity"
int weeklyValue = 0;  //value for the header tab "Weekly"
int pageValue = 1;    //used to track the current page (used in if statements for mouseClicked)
//int sliderVal = 0;    //saves slider values 1-5, depending on which box the user highlights in the slider() funtion. Used in mouseClicked function
int sliderAVal = 0;   
int sliderBVal = 0;
int sliderCVal = 0;
int sliderpos = 0;    //used in the sliderReadIn() function to track which box is highlighted (can possibly make local??)
int sliderApos = 0;
int sliderBpos = 0;
int sliderCpos = 0;

color connectColor = color(255,102,0); //(44,160,137);
color contribColor = color(98,174,201); //slate(67,106,166); //(199,187,112);
color vitalColor = color(88,150,42);    //(0,102,128);
color slider1Color = color(255, 42,42);   //(255, 42,42);
color slider2Color = color(255,127,42);  //(255,127,42);
color slider3Color = color(255,204,0); //(255,204,0);
color slider4Color = color(55,200,55);  //(55,200,55);
color slider5Color = color(0, 170,0);  //(0, 170,0);



//boolean check1Val = true, check2Val = true, check3Val = true;              //Use these to pass value of checkbox on newact page to mouseClick
boolean check1Over = false, check2Over = false, check3Over = false;        //Check whether the mouse is over the checkboxes on newact page
//boolean check1Over, check2Over, check3Over;                              //changed between revisions - doesn't seem to make any difference - leave new declared values 
boolean check1Click = false, check2Click = false, check3Click = false;     //Records whether mouse has been clicked in a checkbox; used in newact to change state of checkboxes
boolean check1On = true, check2On = true, check3On = true;                 //Use these to save state of each checkbox on newact to database (null value if inactive; doesn't count in sums)
//int value = 0;

ControlP5 controlP5;         //set up variable controlp5 of class ControlP5 for textboxes on newact page        
//Textfield activitybox;
//Textfield hoursbox;
//Textfield minsbox;

PImage checkmark;            //.png of a checkmark from Inkscape for checkboxes in newact page

//Global list of current activities and the week's buckets
MyActivities[] myActivities = new MyActivities[0];
MyActivities[] myActivitiesToday = new MyActivities[0];
MyBuckets[] myBuckets = new MyBuckets[7];

//the fake database
FakeDatabase myDatabase = new FakeDatabase();

  Boolean lastMousePressed = false;


void setup() {
  background(255);
  size(int(320*scaleX),int(470*scaleY));
  //size(1440,2560); //correct phone screen size - (360x640) is 1/4 scale (set scale below: 4 width, 4.5 height for 320 x 470 screen - fix aspect ratio in final version)

  //initialize the database
  myDatabase.initialize("this"); //in the real database, you will need to pass a this (variable) instead of "this" (the string). 'this' is the context in which the database resides, namely the GLP main app
  
  //get current database values
  //This must happen once before adding any new data
  myActivities = myDatabase.LoadActivitiesFromDatabase();
  myActivitiesToday = myDatabase.GetTodaysActivities();
  myBuckets = myDatabase.LoadBucketsFromDatabase();
    
  //create controlp5 objects (textboxes)
  actin = new ControlP5(this);
  hoursin = new ControlP5(this);
  minsin = new ControlP5(this);
//  actLabel = new Label(this, "Enter activity here", 300,160, color(68,68,68));
  
  font24 = createFont("Arial",24); // Arial, 16 point, left off anti-aliasing option, because it caused pixellated fonts (don't know why)

  drawtextbox(); //textboxes have to be drawn outside of draw command and then hidden until needed

}

void draw() {
  scalemouseX = mouseX/scaleX;
  scalemouseY = mouseY/scaleY;
  scale(scaleX, scaleY); //set scale for drawing
  //scale(4.5,5.45);  //for phone app version
  background(255);

  //Select which page to display, based on the pageValue function
  switch(pageValue) {
    case 1:
      newact(saveValue);
    break;
   
    case 2:
      logpg(plusValue);
    break;
    
    case 3:
      home();
    break;
    
    case 4:
      weeklyqual(bottomValue);
    break;
    
    case 5:
      weeklyquant(topValue);
    break;
  }  

  //turn on textbox display for newact page, otherwise, turn it off 
   if (pageValue == 1) {
     actin.show();
     hoursin.show();
     minsin.show();
   }
   else {
     actin.hide();
     hoursin.hide();
     minsin.hide();
   }
   
  if (scaleX > 3) {
    //we must be on android
    if ((mousePressed == false) && (lastMousePressed == true))
    {
      mouseClicked();
    }
    lastMousePressed = mousePressed;
  }
  
}


