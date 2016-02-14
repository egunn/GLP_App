void Submit() {
  print("the following text was submitted :");
  activityText = actin.getText();
  hourText = hoursin.getText();
  minText = minsin.getText();
  println(activityText);
  println(hourText);
  println(minText);
  saveValue = 0;
  
  MyActivities myActivity = new MyActivities(activityText, int(hourText), int(minText),sliderAVal-3,sliderBVal-3,sliderCVal-3,check1On,check2On,check3On);
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

