void Submit() {
  print("the following text was submitted :");
  activityText = actin.get(Textfield.class,"actin").getText();
  hourText = hoursin.get(Textfield.class,"hoursin").getText();
  minText = minsin.get(Textfield.class,"minsin").getText();
  
  //Handle default values in case the user didn't add anything
  if (hourText.equals("hh"))
    hourText = "0";
  if (minText.equals("mm"))
    minText = "0";
  
  println(activityText + "," + hourText + "," + minText);
  saveValue = 0;
  
  MyActivities myActivity = new MyActivities(activityText, int(hourText), int(minText),sliderAVal-3,sliderBVal-3,sliderCVal-3,check1On,check2On,check3On);
  myDatabase.SaveActivityToDatabase(myActivity);
  
  myActivities = myDatabase.LoadActivitiesFromDatabase();
  myActivitiesToday = myDatabase.GetTodaysActivities();
  myBuckets = myDatabase.LoadBucketsFromDatabase();
  
  //clear the input fields back to default
  actin.get(Textfield.class,"actin").clear();
  hoursin.get(Textfield.class,"hoursin").clear();
  minsin.get(Textfield.class,"minsin").clear();
  
  sliderAVal = 0;
  sliderBVal = 0;
  sliderCVal = 0;
  check1On = true;
  check2On = true;
  check3On = true;
}  

