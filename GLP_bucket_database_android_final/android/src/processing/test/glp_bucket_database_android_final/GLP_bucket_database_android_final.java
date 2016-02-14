package processing.test.glp_bucket_database_android_final;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import apwidgets.*; 
import java.util.Date; 
import android.text.InputType; 
import android.view.inputmethod.EditorInfo; 
import android.widget.EditText; 
import android.view.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class GLP_bucket_database_android_final extends PApplet {


APWidgetContainer widgetContainer;
APEditText actin, hoursin, minsin;

//import controlP5.*;
 //ControlP5 actin, hoursin, minsin; //declare textboxes of class ControlP5 to get activity name and times from user (newact page)

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
float scaleX = 4.5f;
float scaleY = 4.5f;
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

int connectColor = color(255,102,0); //(44,160,137);
int contribColor = color(98,174,201); //slate(67,106,166); //(199,187,112);
int vitalColor = color(88,150,42);    //(0,102,128);
int slider1Color = color(255, 42,42);   //(255, 42,42);
int slider2Color = color(255,127,42);  //(255,127,42);
int slider3Color = color(255,204,0); //(255,204,0);
int slider4Color = color(55,200,55);  //(55,200,55);
int slider5Color = color(0, 170,0);  //(0, 170,0);



//boolean check1Val = true, check2Val = true, check3Val = true;              //Use these to pass value of checkbox on newact page to mouseClick
boolean check1Over = false, check2Over = false, check3Over = false;        //Check whether the mouse is over the checkboxes on newact page
//boolean check1Over, check2Over, check3Over;                              //changed between revisions - doesn't seem to make any difference - leave new declared values 
boolean check1Click = false, check2Click = false, check3Click = false;     //Records whether mouse has been clicked in a checkbox; used in newact to change state of checkboxes
boolean check1On = true, check2On = true, check3On = true;                 //Use these to save state of each checkbox on newact to database (null value if inactive; doesn't count in sums)
//int value = 0;

//ControlP5 controlP5;         //set up variable controlp5 of class ControlP5 for textboxes on newact page        
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


public void setup() {
  background(255);
  size(PApplet.parseInt(320*scaleX),PApplet.parseInt(470*scaleY));
  //size(1440,2560); //correct phone screen size - (360x640) is 1/4 scale (set scale below: 4 width, 4.5 height for 320 x 470 screen - fix aspect ratio in final version)

  //initialize the database
  myDatabase.initialize("this"); //in the real database, you will need to pass a this (variable) instead of "this" (the string). 'this' is the context in which the database resides, namely the GLP main app
  
  //get current database values
  //This must happen once before adding any new data
  myActivities = myDatabase.LoadActivitiesFromDatabase();
  myActivitiesToday = myDatabase.GetTodaysActivities();
  myBuckets = myDatabase.LoadBucketsFromDatabase();
    
  //create controlp5 objects (textboxes)
//  actin = new ControlP5(this);
//  hoursin = new ControlP5(this);
//  minsin = new ControlP5(this);
  widgetContainer = new APWidgetContainer(this); //create new container for widgets

  font24 = createFont("Arial",24); // Arial, 16 point, left off anti-aliasing option, because it caused pixellated fonts (don't know why)

  drawtextbox(); //textboxes have to be drawn outside of draw command and then hidden until needed

}

public void draw() {
  scalemouseX = mouseX/scaleX;
  scalemouseY = mouseY/scaleY;
  scale(scaleX, scaleY); //set scale for drawing
  //scale(4.5,5.45);  //for phone app version
  background(255);

  //Select which page to display, based on the pageValue function
  switch(pageValue) {
    case 1:
      home();
    break;
   
    case 2:
      logpg(plusValue);
    break;
    
    case 3:
      newact(saveValue);
    break;
    
    case 4:
      weeklyqual(bottomValue);
    break;
    
    case 5:
      weeklyquant(topValue);
    break;
  }  

  //turn on textbox display for newact page, otherwise, turn it off 
   if (pageValue == 3) {
      widgetContainer.show();
//     actin.show();
//     hoursin.show();
//     minsin.show();
   }
   else {
      widgetContainer.hide();
//     actin.hide();
//     hoursin.hide();
//     minsin.hide();
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




class FakeDatabase {
  
  //Branden will write converter class to send myActivities to database and load myBuckets from database.

  //Variable and constant declarations at the bottom! (so the public functions are more visible at the top)

  //call this function when you want to know what weekday it is currently (as an int, 0=monday) --> mydatabase.todaysWeekday()
  //you can then ask for myBuckets[mydatabase.todaysWeekday()].whatever...
  public int todaysWeekday() {
    return weekday(year(),month(),day());
  }


  //********* This function saves a single Activity to the database
  public void SaveActivityToDatabase (MyActivities myActivity) {
    //do calculations like the database would
    myActivity.identifier = table.getRowCount() + 1;
    myActivity.date = String.valueOf(year()) + "." + String.valueOf(month()) + "." + String.valueOf(day());
    myActivity.weekday = dayName[weekday(year(),month(),day())];
    myActivity.time_h = ((float)myActivity.timeIn_h + ((float)myActivity.timeIn_m / 60.0f));

    //append to fakedatabase array
    fakedatabase = (MyActivities[]) append(fakedatabase, myActivity);  //Reference: When using an array of objects, the data returned from the function must be cast to the object array's data type. For example: SomeClass[] items = (SomeClass[]) append(originalArray, element)

    //also make a new row for the table that can be saved to a file (doing this as two steps prevents data older than a week from being lost, but also keeps it out of the array)
    TableRow newRow = table.addRow();
    newRow.setInt("Identifier", myActivity.identifier);
    newRow.setString("Name", myActivity.name);
    newRow.setString("Weekday", myActivity.weekday);
    newRow.setString("CreateDate", myActivity.date);
    newRow.setInt("timeIn_h", myActivity.timeIn_h);
    newRow.setInt("timeIn_m", myActivity.timeIn_m);
    newRow.setFloat("time_h", myActivity.time_h);
    newRow.setInt("connectScore", myActivity.connectScore);
    newRow.setInt("contribScore", myActivity.contribScore);
    newRow.setInt("vitalScore", myActivity.vitalScore);
    //the booleans need converting to Int to save them. This uses the ternary operator.
    newRow.setInt("connectApplic", myActivity.connectApplic ? 1 : 0);
    newRow.setInt("contribApplic", myActivity.contribApplic ? 1 : 0);
    newRow.setInt("vitalApplic", myActivity.vitalApplic ? 1 : 0);

    //save the table
    saveTable(table, filename);

    if (DEBUG_MESSAGES)
      println(DEBUG_PREFIX + "current data count for data table: "+ fakedatabase.length);
  }

  //********* This function returns all the Activities from the database  
  public MyActivities[] LoadActivitiesFromDatabase() {

    //wipe out the current copy of fakedatabase
    fakedatabase = new MyActivities[0];

    //Load the table into memory
    table = loadTable(filename, "header");
    if (DEBUG_MESSAGES)
      println(DEBUG_PREFIX + table.getRowCount() + " total rows in table");

    //convert the table to the output array format
    for (TableRow row : table.rows ()) {

      //TODO: this if statement could be used to filter data
      if (true) {
        //add a row to the array
        fakedatabase = (MyActivities[]) expand(fakedatabase, fakedatabase.length + 1);  //set array size to 1 bigger
        int i = fakedatabase.length - 1; //get the index of the new (last) array element
        
        //Create a blank activity at the new element
        fakedatabase[i] = new MyActivities();
        
        //populate the acticity with data from the table row
        fakedatabase[i].identifier = row.getInt("Identifier");
        fakedatabase[i].name = row.getString("Name");
        fakedatabase[i].weekday = row.getString("Weekday");
        fakedatabase[i].date = row.getString("CreateDate");
        fakedatabase[i].timeIn_h = row.getInt("timeIn_h");
        fakedatabase[i].timeIn_m = row.getInt("timeIn_m");
        fakedatabase[i].time_h = row.getFloat("time_h");
        fakedatabase[i].connectScore = row.getInt("connectScore");
        fakedatabase[i].contribScore = row.getInt("contribScore");
        fakedatabase[i].vitalScore = row.getInt("vitalScore");
        //the booleans are stored as Ints in the table, so we need to convert them back
        fakedatabase[i].connectApplic = (row.getInt("connectApplic") == 1) ? true : false;
        fakedatabase[i].contribApplic = (row.getInt("contribApplic") == 1) ? true : false;
        fakedatabase[i].vitalApplic = (row.getInt("vitalApplic") == 1) ? true : false;

        if (DEBUG_MESSAGES)
          println(DEBUG_PREFIX + fakedatabase[i].name + " (" + fakedatabase[i].weekday + ") has an ID of " + fakedatabase[i].identifier);
      }
    }
    return fakedatabase;
  }

  //********* This function returns all TODAY's Activities from the database  
  // ******** YOU MUST UPDATE THE DATABASE (LoadActivitiesFromDatabase) JUST BEFORE CALLING THIS
  public MyActivities[] GetTodaysActivities() {

    
    MyActivities[] todaysActivities = new MyActivities[0];
    String todaysdate = String.valueOf(year()) + "." + String.valueOf(month()) + "." + String.valueOf(day());

    //This walks through the table object, but could be altered to walk through the fakedatabase array...
    //convert the table to the output array format
    for (TableRow row : table.rows ()) {

      //this if statement is used to filter data
      if (row.getString("CreateDate").equals(todaysdate) == true) {    //This method is necessary because it's not possible to compare strings using the equality operator (==). 
        //add a row to the array
        todaysActivities = (MyActivities[]) expand(todaysActivities, todaysActivities.length + 1);  //set array size to 1 bigger
        int i = todaysActivities.length - 1; //get the index of the new (last) array element
        
        //Create a blank activity at the new element
        todaysActivities[i] = new MyActivities();
        
        //populate the acticity with data from the table row
        todaysActivities[i].identifier = row.getInt("Identifier");
        todaysActivities[i].name = row.getString("Name");
        todaysActivities[i].weekday = row.getString("Weekday");
        todaysActivities[i].date = row.getString("CreateDate");
        todaysActivities[i].timeIn_h = row.getInt("timeIn_h");
        todaysActivities[i].timeIn_m = row.getInt("timeIn_m");
        todaysActivities[i].time_h = row.getFloat("time_h");
        todaysActivities[i].connectScore = row.getInt("connectScore");
        todaysActivities[i].contribScore = row.getInt("contribScore");
        todaysActivities[i].vitalScore = row.getInt("vitalScore");
        //the booleans are stored as Ints in the table, so we need to convert them back
        todaysActivities[i].connectApplic = (row.getInt("connectApplic") == 1) ? true : false;
        todaysActivities[i].contribApplic = (row.getInt("contribApplic") == 1) ? true : false;
        todaysActivities[i].vitalApplic = (row.getInt("vitalApplic") == 1) ? true : false;

        if (DEBUG_MESSAGES)
          println(DEBUG_PREFIX + todaysActivities[i].name + " (" + todaysActivities[i].weekday + ") has an ID of " + todaysActivities[i].identifier);
      } else
      {
        if (DEBUG_MESSAGES)
          println(DEBUG_PREFIX + "Item " + row.getString("Name") + " on date " + row.getString("CreateDate") + " not equal to today's date " + todaysdate);
      }
    }
    return todaysActivities;
  }

  //********* This function gets the summary of the last week's activities from the database
  // ******** YOU MUST UPDATE THE DATABASE (LoadActivitiesFromDatabase) JUST BEFORE CALLING THIS

  public MyBuckets[] LoadBucketsFromDatabase() {
    MyBuckets[] dbBuckets = new MyBuckets[7];

    //This version gets the last seven days and fills the buckets in a fixed manner (bucket 0 is always monday, 6, Sunday)
    //get today's bucket number (cache it so we aren't calculating all the time)
    int todaysBucket = todaysWeekday();


    //for each bucket
    for (int b = 0; b<dbBuckets.length; b++) {
      //initialize the bucket
      dbBuckets[b] = new MyBuckets();

      //calculate the date that we will use for each bucket
      if (b <= todaysBucket) {
        //this date is in the past or today
        dbBuckets[b].date = DateOffsetFromToday(b - todaysBucket);
      } else if (b > todaysBucket) {
        //this date would be inthe future, so get the date from last week instead
        dbBuckets[b].date = DateOffsetFromToday((b - todaysBucket)-7);
      }

      //set the bucket's weekday from the date - This is actually the convoluted way to do it, since the bucket's number corresponds, but this is more robust to change
      int bucketDateYear = PApplet.parseInt(dbBuckets[b].date.substring(0, 4));
      int bucketDateMonth = PApplet.parseInt(dbBuckets[b].date.substring(5, dbBuckets[b].date.indexOf(".", 5)));
      int bucketDateDay = PApplet.parseInt(dbBuckets[b].date.substring(dbBuckets[b].date.indexOf(".", 5)+1));
      dbBuckets[b].weekday = dayName[weekday(bucketDateYear, bucketDateMonth, bucketDateDay)];

      if (DEBUG_MESSAGES)
        println(DEBUG_PREFIX + "Bucket " + b + " has date " + dbBuckets[b].date + " and weekday " + dbBuckets[b].weekday);

      //get all the Activities for this bucket's date
      //This walks through the table object, but could be altered to walk through the fakedatabase array...
      //convert the table to the output array format
      for (TableRow row : table.rows ()) {

        //get the date from this element
        String thisActivitiesDate = row.getString("CreateDate");

        //this if statement is used to filter data
        if (row.getString("CreateDate").equals(dbBuckets[b].date) == true) {    //This method is necessary because it's not possible to compare strings using the equality operator (==). 
          //add a row to the array
          dbBuckets[b].myBucketsActivities = (MyActivities[]) expand(dbBuckets[b].myBucketsActivities, dbBuckets[b].myBucketsActivities.length + 1);  //set array size to 1 bigger
          int i = dbBuckets[b].myBucketsActivities.length - 1; //get the index of the new (last) array element

          //Create a blank activity at the new element
          dbBuckets[b].myBucketsActivities[i] = new MyActivities();

          //populate the acticity with data from the table row
          dbBuckets[b].myBucketsActivities[i].identifier = row.getInt("Identifier");
          dbBuckets[b].myBucketsActivities[i].name = row.getString("Name");
          dbBuckets[b].myBucketsActivities[i].weekday = row.getString("Weekday");
          dbBuckets[b].myBucketsActivities[i].date = row.getString("CreateDate");
          dbBuckets[b].myBucketsActivities[i].timeIn_h = row.getInt("timeIn_h");
          dbBuckets[b].myBucketsActivities[i].timeIn_m = row.getInt("timeIn_m");
          dbBuckets[b].myBucketsActivities[i].time_h = row.getFloat("time_h");
          dbBuckets[b].myBucketsActivities[i].connectScore = row.getInt("connectScore");
          dbBuckets[b].myBucketsActivities[i].contribScore = row.getInt("contribScore");
          dbBuckets[b].myBucketsActivities[i].vitalScore = row.getInt("vitalScore");
          //the booleans are stored as Ints in the table, so we need to convert them back
          dbBuckets[b].myBucketsActivities[i].connectApplic = (row.getInt("connectApplic") == 1) ? true : false;
          dbBuckets[b].myBucketsActivities[i].contribApplic = (row.getInt("contribApplic") == 1) ? true : false;
          dbBuckets[b].myBucketsActivities[i].vitalApplic = (row.getInt("vitalApplic") == 1) ? true : false;

          if (DEBUG_MESSAGES)
            println(DEBUG_PREFIX + dbBuckets[b].myBucketsActivities[i].name + " (" + dbBuckets[b].myBucketsActivities[i].weekday + ") has an ID of " + dbBuckets[b].myBucketsActivities[i].identifier + " in bucket " + b );
        } else
        {
          if (DEBUG_MESSAGES)
            println(DEBUG_PREFIX + "Item " + row.getString("Name") + " on date " + row.getString("CreateDate") + " not equal to bucket's date " + dbBuckets[b].date);
        }
      }

      //blank out the statistics (just in case, this should be redundant...
      dbBuckets[b].totalTime_h = 0;
      dbBuckets[b].connectTime = 0;
      dbBuckets[b].contribTime = 0; 
      dbBuckets[b].vitalTime = 0;
      dbBuckets[b].connectVal = 0; 
      dbBuckets[b].contribVal = 0;
      dbBuckets[b].vitalVal = 0;

      //Calculate the statistics for this bucket dbBuckets[b] based on it's activities dbBuckets[b].myBucketsActivities[a]
      if (dbBuckets[b].myBucketsActivities.length > 0) {
        for (int a = 0; a< dbBuckets[b].myBucketsActivities.length; a++) {
          //update all four times
          dbBuckets[b].totalTime_h = dbBuckets[b].totalTime_h + dbBuckets[b].myBucketsActivities[a].time_h;
          if (dbBuckets[b].myBucketsActivities[a].connectApplic){
            dbBuckets[b].connectTime = dbBuckets[b].connectTime + dbBuckets[b].myBucketsActivities[a].time_h;
          }
          if (dbBuckets[b].myBucketsActivities[a].contribApplic) {
            dbBuckets[b].contribTime = dbBuckets[b].contribTime + dbBuckets[b].myBucketsActivities[a].time_h;
          }
          if (dbBuckets[b].myBucketsActivities[a].vitalApplic) {
            dbBuckets[b].vitalTime = dbBuckets[b].vitalTime + dbBuckets[b].myBucketsActivities[a].time_h;
        }
      }
      
        //now that we know the total times of each kind of bucket, we can make the time-weighted scaled score
        for (int a = 0; a< dbBuckets[b].myBucketsActivities.length; a++) {
          //the contribution of a single activity  is scaled by what part of the total time it was of that bucket type
          if (dbBuckets[b].myBucketsActivities[a].connectApplic){
            dbBuckets[b].connectVal = dbBuckets[b].connectVal + (dbBuckets[b].myBucketsActivities[a].connectScore*(dbBuckets[b].myBucketsActivities[a].time_h/dbBuckets[b].connectTime));
          }
          if (dbBuckets[b].myBucketsActivities[a].contribApplic){
            dbBuckets[b].contribVal = dbBuckets[b].contribVal + (dbBuckets[b].myBucketsActivities[a].contribScore*(dbBuckets[b].myBucketsActivities[a].time_h/dbBuckets[b].contribTime));
          }
          if (dbBuckets[b].myBucketsActivities[a].vitalApplic){
            dbBuckets[b].vitalVal = dbBuckets[b].vitalVal + (dbBuckets[b].myBucketsActivities[a].vitalScore*(dbBuckets[b].myBucketsActivities[a].time_h/dbBuckets[b].vitalTime));
          }
        }        
      }
      
      if (DEBUG_MESSAGES) {
        println(DEBUG_PREFIX + "Bucket " + b + " has total times of " + dbBuckets[b].totalTime_h + ", " + dbBuckets[b].connectTime + ", " + dbBuckets[b].contribTime + ", " + dbBuckets[b].vitalTime);
        println(DEBUG_PREFIX + "Bucket " + b + " has total scores of " + dbBuckets[b].connectVal + ", " + dbBuckets[b].contribVal + ", " + dbBuckets[b].vitalVal);
      }
      
      
      
      
    }



    return dbBuckets;
  } 

  //********* This function configures the database (call during setup)
  public void initialize(String context) {

    //get right filename
    filename = dataPath(ANDROID_FILENAME);
    //if (DEBUG_MESSAGES)
      println(DEBUG_PREFIX + filename);

    File file = new File(filename);
    if (!file.exists()) {
      table = new Table();
      table.addColumn("Identifier");
      table.addColumn("Name");
      table.addColumn("Weekday");
      table.addColumn("CreateDate");
      table.addColumn("timeIn_h");
      table.addColumn("timeIn_m");
      table.addColumn("time_h");
      table.addColumn("connectScore");
      table.addColumn("contribScore");
      table.addColumn("vitalScore");
      table.addColumn("connectApplic");
      table.addColumn("contribApplic");
      table.addColumn("vitalApplic");

      saveTable(table, filename);

      if (DEBUG_MESSAGES)
        println(DEBUG_PREFIX + "File Created");
    } else {
      if (DEBUG_MESSAGES)
        println(DEBUG_PREFIX + "Database found");
    }
  }

  //private functions, Variables and constants used by this class after this point
  //Private because they shouldn't be directly accessed from outside this class. the class methods/functions above do the work.
  
  private int weekday(int y, int m, int d) {
  // adapted from http://forum.processing.org/two/discussion/comment/11012/#Comment_11012
  // y = 4 digit year
  // m = month (January = 1 : December = 12)
  // d = day in month
  // Returns 0 = Monday .. 6 = Sunday
    if (m < 3) {
      m += 12;
      y--;
    }
    return ((d + PApplet.parseInt((m+1)*2.6f) +  y + PApplet.parseInt(y/4) + 6*PApplet.parseInt(y/100) + PApplet.parseInt(y/400) + 6) - 1 )% 7;
  }

  //only calulates offsets from today, not an arbitrary date
  private String DateOffsetFromToday(int offset) {
    //adapted from http://forum.processing.org/one/topic/date-time-functions#25080000001364219.html
    Date d = new Date();
    long timestamp = d.getTime() + (86400000 * offset);
    String date = new java.text.SimpleDateFormat("yyyy.M.d").format(timestamp);
    return date;
  }

  private MyActivities[] fakedatabase = new MyActivities[0];     //The fake database variable itself (shouldn't be called outside this class)
  private Table table;
  private String filename;

  //Constants
  private final String BASE_FILENAME = "FakeDatabase.csv";
  private final String ANDROID_FILENAME = "//sdcard/GLPdata/" + BASE_FILENAME;
  private final Boolean DEBUG_MESSAGES = false;
  private final String DEBUG_PREFIX = "Database debug: ";
  private final String[] dayName = {
    "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"
  };
}

class MyActivities {
  
//   println(myActivities[0].name);               //get activity name from database structure
//   println(myActivities[0].weekday);            //day of week (full - Monday, not M)
//   println(myActivities[0].timeIn_h);           //user-entered hours 
//   println(myActivities[0].timeIn_m);           //user-entered minutes
//   println(myActivities[0].time_h);             //total time calculated in hours (as a decimal - need to convert to hh:mm format or read from time_In vars if you want it that way)
//   println(myActivities[0].connectScore);       //user score for connection
//   println(myActivities[0].contribScore);       //user score for contribution
//   println(myActivities[0].vitalScore);         //user score for vitality
//   println(myActivities[0].connectApplic);      //checkbox state for connection - if false, then ignore any score in connection field
//   println(myActivities[0].contribApplic);      //checkbox state for contribution - if false, then ignore any score in contribution field 
//   println(myActivities[0].vitalApplic);        //checkbox state for vitality - if false, then ignore any score in vitality field
  
  //MyActivities class to hold all accumulated user data (for spreadsheet) and communicate with database
  //define variables and class here, send to database, then read in complete array from database after functions are run
  
  //declare data types to be stored
  int identifier; //unique identifier to be created in database
  String name; //from user in newact page
  String weekday; //recorded by database/on way to database
  String date;  //recorded by database/on way to database   //*******check variable class********
  int timeIn_h; //from user in newact page 
  int timeIn_m;  //from user in newact page
  float time_h;  //calculated from mytimein_m, mytimein_h
  int connectScore;  //from user in newact page from -2 to 2
  int contribScore;   //from user in newact page
  int vitalScore;     //from user in newact page
  boolean connectApplic;
  boolean contribApplic;
  boolean vitalApplic;
  
  //Class constructor function When prepopulating fields
  MyActivities(String _name, int _timeIn_h, int _timeIn_m, int _connectScore, int _contribScore, int _vitalScore,  boolean _connectApplic,  boolean _contribApplic,  boolean _vitalApplic) {
    identifier = 0;
    name = _name;
    weekday = "B";
    date = "11-22-2345";
    timeIn_h = _timeIn_h;
    timeIn_m = _timeIn_m;
    time_h = 0;
    connectScore = _connectScore;
    contribScore = _contribScore;
    vitalScore = _vitalScore; 
    connectApplic = _connectApplic;
    contribApplic = _contribApplic;
    vitalApplic = _vitalApplic;
  }
  
  //Class constructor function for a blank item
  MyActivities() {
    identifier = 0;
    name = "NoName";
    weekday = "X";
    date = "20001332";
    timeIn_h = 0;
    timeIn_m = 0;
    time_h = 0;
    connectScore = 0;
    contribScore = 0;
    vitalScore = 0; 
    connectApplic = false;
    contribApplic = false;
    vitalApplic = false;
  }
  
}
  
 



class MyBuckets {
  
  //   println(myBuckets[0].weekday);                      //get the weekday for this bucket ("Monday" "Tuesday", etc.)
  //   println(myBuckets[0].date);                         //get the date that this bucket represents. String formatted as yyyy.mm.dd  - if month is 1 digit, there is no padding! (2015.9.1) 
  //   println(myBuckets[0].totalTime_h);                  //total of all time recorded for day summarized
  //   println(myBuckets[0].connectTime);                  //total time spent for each bucket during the day summarized
  //   println(myBuckets[0].contribTime); 
  //   println(myBuckets[0].vitalTime);
  //   println(myBuckets[0].connectVal);                   //Weighted average (based on time) of the values for connection 
  //   println(myBuckets[0].contribVal);
  //   println(myBuckets[0].vitalVal);  

  //   println(myBuckets[0].myBucketsActivities.length);    //The number of activities summarized by this bucket  
  //   println(myBuckets[0].myBucketsActivities[0]);        //an activity from the bucket
  //   println(myBuckets[0].myBucketsActivities[0].name);               //get activity name from database structure
  //   println(myBuckets[0].myBucketsActivities[0].weekday);            //day of week (full - Monday, not M)
  //   println(myBuckets[0].myBucketsActivities[0].timeIn_h);           //user-entered hours 
  //   println(myBuckets[0].myBucketsActivities[0].timeIn_m);           //user-entered minutes
  //   println(myBuckets[0].myBucketsActivities[0].time_h);             //total time calculated in hours (as a decimal - need to convert to hh:mm format or read from time_In vars if you want it that way)
  //   println(myBuckets[0].myBucketsActivities[0].connectScore);       //user score for connection
  //   println(myBuckets[0].myBucketsActivities[0].contribScore);       //user score for contribution
  //   println(myBuckets[0].myBucketsActivities[0].vitalScore);         //user score for vitality
  //   println(myBuckets[0].myBucketsActivities[0].connectApplic);      //checkbox state for connection - if false, then ignore any score in connection field
  //   println(myBuckets[0].myBucketsActivities[0].contribApplic);      //checkbox state for contribution - if false, then ignore any score in contribution field 
  //   println(myBuckets[0].myBucketsActivities[0].vitalApplic);        //checkbox state for vitality - if false, then ignore any score in vitality field
   
  
  
  //summary array with total values for each day in the past week
  //define variables and class here, initialize by reading in from database (do summation on local phone database)
  
  String weekday; //recorded by database/on way to database
  String date; 
  float totalTime_h;  //total of all time recorded for day summarized
  float connectTime; //total time spent for each bucket during the day summarized
  float contribTime; 
  float vitalTime;
  float connectVal;  //sum(value*time)/totaltime for all activities
  float contribVal;
  float vitalVal;
  
  MyActivities[] myBucketsActivities = new MyActivities[0];  //For storing all of this bucket's activites for easier lookups
  
  //Class constructor function
  MyBuckets() {
    weekday = "B";
    totalTime_h = 0;
    connectTime = 0;
    contribTime = 0;
    vitalTime = 0;
    connectVal = 0;
    contribVal = 0;
    vitalVal = 0; 
  }
  
}
public void Submit() {
  print("the following text was submitted :");
  activityText = actin.getText();
  hourText = hoursin.getText();
  minText = minsin.getText();
  println(activityText);
  println(hourText);
  println(minText);
  saveValue = 0;
  
  MyActivities myActivity = new MyActivities(activityText, PApplet.parseInt(hourText), PApplet.parseInt(minText),sliderAVal-3,sliderBVal-3,sliderCVal-3,check1On,check2On,check3On);
  myDatabase.SaveActivityToDatabase(myActivity);
  
  myActivities = myDatabase.LoadActivitiesFromDatabase();
  myActivitiesToday = myDatabase.GetTodaysActivities();
  myBuckets = myDatabase.LoadBucketsFromDatabase();
  
  //clear the input fields back to default
//  actin.get(Textfield.class,"actin").clear();
//  hoursin.get(Textfield.class,"hoursin").clear();
//  minsin.get(Textfield.class,"minsin").clear();
  actin.setText("");
  hoursin.setText("");
  minsin.setText("");
  
  sliderAVal = 0;
  sliderBVal = 0;
  sliderCVal = 0;
  check1On = true;
  check2On = true;
  check3On = true;
}  

public void drawheader() {
 
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
  
  int menuHighlight, menuActive, menuInactive; //Highlight is mouse-over, Active is currently selected page, Inactive is non-selected page
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
  text(home,(0 + 16  ),(75 ),320/4,(24 )); 
  
  String log = "Log";
  text(log,(320/4 + 25  ),(75 ),320/4,(24 )); 
  
  String activ = "+Activity";
  text(activ,(2*320/4 + 6  ),(75 ), 320/4,(24 ));
  
  String weekly = "Weekly";
  text(weekly,(3* 320/4 + 12  ),(75 ), 320/4,(24 ));

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
  








public void drawtextbox() {


    actin = new APEditText(PApplet.parseInt(30*scaleX), PApplet.parseInt(135*scaleY), PApplet.parseInt(255*scaleX), PApplet.parseInt(38*scaleY)); //create a textfield from x- and y-pos., width and height
    hoursin = new APEditText(PApplet.parseInt(113*scaleX), PApplet.parseInt(196*scaleY), PApplet.parseInt(37*scaleX), PApplet.parseInt(38*scaleY)); //create a textfield from x- and y-pos., width and height
    minsin = new APEditText(PApplet.parseInt(163*scaleX), PApplet.parseInt(196*scaleY), PApplet.parseInt(37*scaleX), PApplet.parseInt(38*scaleY)); //create a textfield from x- and y-pos., width and height

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
public void home() {
 
 drawheader(); 
  
  //placeholder for pie chart
  noStroke();
//  fill(44,160,137);
//  ellipse( 320/2,(220 ),180  ,180 ); //ellipse dimensions given in radius, not diameter
  
  //get today's bucket number
  
  //get today's bucket statistics to calculate percents
  
//  println(myBuckets[1].connectTime);
//  println(myBuckets[1].contribTime);
//  println(myBuckets[1].vitalTime);
  
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
 
  if (myBuckets[day].connectVal < -1.5f )
    fill(slider1Color); //full red
  else if (myBuckets[day].connectVal < -0.5f )
    fill(slider2Color); //orange red
  else if (myBuckets[day].connectVal < .5f )
    fill(slider3Color); //yellow
  else if (myBuckets[day].connectVal < 1.5f )
    fill(slider4Color); //yellow green
  else
    fill(slider5Color); //full green     
  rect(186  ,348 , (myBuckets[day].connectVal * 21.25f) + 42.5f,10);  

  if (myBuckets[day].contribVal < -1.5f )
    fill(slider1Color); //full red
  else if (myBuckets[day].contribVal < -0.5f )
    fill(slider2Color); //orange red
  else if (myBuckets[day].contribVal < .5f )
    fill(slider3Color); //yellow
  else if (myBuckets[day].contribVal < 1.5f )
    fill(slider4Color); //yellow green
  else
    fill(slider5Color); //full green     
  rect(186  ,382,(myBuckets[day].contribVal * 21.25f) + 42.5f,10); 

  if (myBuckets[myDatabase.todaysWeekday()].vitalVal < -1.5f )
    fill(slider1Color); //full red
  else if (myBuckets[day].vitalVal < -0.5f )
    fill(slider2Color); //orange red
  else if (myBuckets[day].vitalVal < .5f )
    fill(slider3Color); //yellow
  else if (myBuckets[day].vitalVal < 1.5f )
    fill(slider4Color); //yellow green
  else
    fill(slider5Color); //full green     
  rect(186  ,418,(myBuckets[day].vitalVal * 21.25f) + 42.5f, 10);
 }
public void logpg(int value) {


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
      text(activity, posX + (9 ),                 posY+3 , 86 , 20 );  
      text(time,     posX + (9 )+ 63 ,            posY+3 , 40 , 20 );
      text(connect,  posX + (9 )+ (63+54) ,       posY+3 , 66 , 20 );
      text(contrib,  posX + (9 )+ (63+54+68) ,    posY+3 , 70 , 20 );
      text(vital,    posX + (9 )+ (63+54+68+58) , posY+3 , 46 , 20 );
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
        
        if (myActivitiesToday[0].connectApplic == true)
        {
          switch (myActivitiesToday[s].connectScore) {
            case -2:
              fill(slider1Color);  //full red
              rect(connectcellXpos,cellYpos-4,70 , 20);
              fill(235);
              text("-",connectcellXpos,cellYpos+2);
            break;
            
            case -1:
              fill(slider2Color);  //orange red
              rect(connectcellXpos,cellYpos-4, 70 , 20);
              fill(235);
              text("-",connectcellXpos,cellYpos+2);
            break;
            
            case 0: 
              fill(slider3Color); //yellow
              rect(connectcellXpos,cellYpos-4,70 , 20);
            break;
            
            case 1: 
              fill(slider4Color); //yellow green
              rect(connectcellXpos,cellYpos-4,70 , 20);
              fill(235);
              text("+",connectcellXpos,cellYpos+2);
            break;
            
            case 2:
              fill(slider5Color); //full green 
              rect(connectcellXpos,cellYpos-4,70 , 20);
              fill(235);
              text("+",connectcellXpos,cellYpos+2);
            break;
          }
       
          }
          else if (myActivitiesToday[s].connectApplic == false) {
            fill(255); 
            rect(connectcellXpos,cellYpos,70 , 20);
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
    int plusHighlight, plusNormal;
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



//If the mouse is clicked, display text in the console 
//*****************change to load the Weekly Quantity page************************* 

public void mouseClicked() {
   if ((pageValue == 5) && (topValue == 1)) { //if clicking inside top radiobutton circle
     pageValue = 4;
     }
   
   else if ((pageValue == 4) && (bottomValue == 1)) {  //if clicking inside bottom radiobutton circle
     pageValue = 5;
   }
   
   else if ((plusValue == 1) && (pageValue == 2)) {
     pageValue = 3;
     saveValue = 0;
   }
   
   else if (homeValue == 1) {
     pageValue = 1;
   }
   
   else if (logValue == 1) {
     pageValue = 2;
   }
   
   else if (activValue == 1) {
     pageValue = 3;
   }
   
   else if (weeklyValue == 1) {
     pageValue = 4;
   }
   
  
   if ((pageValue == 3) && (saveValue == 1)) {
     pageValue = 2;
     Submit();
   }
   
   if ((pageValue == 3) && (sliderApos > 0)) {
     sliderAVal = sliderApos;
     println(sliderAVal + " mouseclicked");     
   }
   
   if ((pageValue == 3) && (sliderBpos > 0)) {
     sliderBVal = sliderBpos;
     println(sliderBVal + " mouseclicked");
   }
     
   if ((pageValue == 3) && (sliderCpos > 0)) {
     sliderCVal = sliderCpos;
     println(sliderCVal + " mouseclicked");
   }  
       
   if ((pageValue == 3) && (check1Over == true)) {
     check1Click = true;
//     println(check1Click + "check1Click mouseclick");
   } 
      
   if ((pageValue == 3) && (check2Over == true)) {
     check2Click = true;
//     println(check2Click + "check2Click mouseclick");
   } 
     
   if ((pageValue == 3) && (check3Over == true)) {
     check3Click = true;
//     println(check3Click + "check3Click mouseclick");
   } 
   
   else {
 //    println("outside button");
   }
}
public void newact(int value) {

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
  int checkHighlight, checkNormal;
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
  
  int saveHighlight, saveNormal;
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


//void slider(int x, int y, int xlength, int ylength, int sliderValIn) {
public void slider() {
  
//  sliderApos = 0;
//  sliderBpos = 0;
//  sliderCpos = 0;
  
  boolean sliderAOver=false, sliderBOver=false, sliderCOver=false;
  boolean slider1Over = false, slider2Over =false, slider3Over = false,slider4Over =false, slider5Over=false;
//  sliderAVal = 0;
//  sliderBVal= 0;
//  sliderCVal = 0;
  
if (check1On == true)  {
  

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
public void sliderReadIn() {
  
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



      
public void weeklyqual(int value) {

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
  strokeWeight(0.5f);
  noFill();
  ellipseMode(CENTER); //choose center as coordinate location
  ellipse(212, 394, 15, 15); 
  ellipse(212, 422, 15, 15);
  noStroke();
  fill(155);
  ellipse(212, 394, 9, 9);

  String quality = "Quality";
  String quantity = "Quantity";
  fill(0);
  textFont(font24, 14);
  text(quality, 225, 399);
  text(quantity, 225, 427);


  //Check for mouse over top radio button, highlight outside ring if mouse detected.
  //first, set some variables
  float topX = 212 ;
  float topY = 394 ;
  float topDiameter = 15 ;

  float bottomX = 212 ;
  float bottomY = 422 ;
  float bottomDiameter = 15 ;

  int bottomHighlight, bottomNormal;
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
    ellipse(bottomX, bottomY, 15, 15 );

    //set value variable to 1, so that the mouseClicked function will know to save the data
    bottomValue = 1;
    topValue = 0;
  }

  if (bottomOver == false) {
    fill(255);
    stroke(bottomNormal);
    ellipse(bottomX, bottomY, 15, 15 );
    //set value variable to 0, so that the mouseClicked function will know to save the data
    bottomValue = 0;
  }
}

public void weeklyquant(int value) {
  
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
  rotate(3*PI/2.0f);       //rotate the grid for the text around its origin
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
    text(PApplet.parseInt(weeklymax) +" hours", 35, 320-180+5);  //180 pixels above the x axis
    
        
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
  strokeWeight(0.5f);
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
    
    int topHighlight, topNormal;
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

}
