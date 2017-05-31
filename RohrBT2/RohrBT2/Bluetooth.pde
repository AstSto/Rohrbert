import processing.serial.*; //<>//
Serial myPort;
boolean firstContact = false;

float yaw, pitch, roll, distance, hole;
int [] irSensor = new int [40];
String[] data = new String[44];
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
      //println(inString);
    }

    // LIEST Daten ein
    try {


      String[] data = splitTokens(inString, "q");
      // println("YAW: "+data[0]);
      yaw = ((float(data[0]))* PI);
      //  println("ROLL: "+data[1]);
      //  println("PITCH: "+data[2]);
      pitch = ((float(data[1]))* PI);
      roll = ((float(data[2]))* PI);
      distance = ((float(data[3]))/360*56*PI);

      if (msgArduino==3) {
        for (int i=4; i<44; i++) {
          irSensor[i-4] =int(data[i]);
        }
      } else {

        for (int i=0; i<40; i++) {
          irSensor[i] = 0;
        }
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