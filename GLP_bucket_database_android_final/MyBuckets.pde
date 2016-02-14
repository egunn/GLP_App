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
