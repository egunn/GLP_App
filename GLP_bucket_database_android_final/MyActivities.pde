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
  
 



