import processing.serial.*;
Serial myPort;
boolean firstContact = false;

float yaw, pitch, roll, distance, hole;
int [] irSensor = new int [40];
String[] data = new String[43];
String[] data2 = new String[4];
byte msgArduino = 5;
byte oldMessage = 5;


void serialEvent (Serial myPort) {

  String inString = myPort.readStringUntil('\n');
  if (inString != null)                                //stellt ersten Kontakt her
  {
    println(inString);
    if (firstContact == false) {
      inString = trim(inString);
      if (inString.equals("A")) {
        myPort.clear();
        firstContact = true;
        myPort.write('4');
        myPort.clear();
        println("contact");
      }
    } else {

      //Kontakt hergestellt, SENDET
      println(inString);
    }

    // LIEST Daten ein
    try {

      if (msgArduino==3) {
        String[] data = splitTokens(inString, "q");
        // println("YAW: "+data[0]);
        yaw = round((float(data[0]))* PI);
        //  println("ROLL: "+data[1]);
        //  println("PITCH: "+data[2]);
        pitch = round((float(data[1]))* PI);
        roll = round((float(data[2]))* PI);
        distance = round((float(data[3]))/360*56*PI);
        for (int i=4; i<44; i++) {
          irSensor[i-4] = round((int(data[i])));
        }
      } else {
        String[] data2 = splitTokens(inString, "q");
        // println("YAW: "+data[0]);
        yaw = round((float(data2[0]))* PI);
        //  println("ROLL: "+data[1]);
        //  println("PITCH: "+data[2]);
        pitch = round((float(data2[1]))* PI);
        roll = round((float(data2[2]))* PI);
        distance = round((float(data2[3]))/360*56*PI);
      }


      if (stop==false) {
        roboterposfullen();              // hier werden die Eigentlichen Roboterpunkte in eine ArrayListe umgewandelt
      }
      // println("distance: "+data[3]);
      //  println("hole: "+data[4]);
    } //try
    catch (Exception e) {
      e.printStackTrace();
    }//catch
  }
}


//https://learn.sparkfun.com/tutorials/connecting-arduino-to-processing/