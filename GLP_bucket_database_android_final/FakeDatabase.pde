import java.util.Date;

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
    myActivity.time_h = ((float)myActivity.timeIn_h + ((float)myActivity.timeIn_m / 60.0));

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
      int bucketDateYear = int(dbBuckets[b].date.substring(0, 4));
      int bucketDateMonth = int(dbBuckets[b].date.substring(5, dbBuckets[b].date.indexOf(".", 5)));
      int bucketDateDay = int(dbBuckets[b].date.substring(dbBuckets[b].date.indexOf(".", 5)+1));
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
    return ((d + int((m+1)*2.6) +  y + int(y/4) + 6*int(y/100) + int(y/400) + 6) - 1 )% 7;
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

