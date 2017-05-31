 //<>//
//Testfunktion, welche die 3 Winkel anzeigen soll
void showValues() {
  serialEvent(myPort);
  background(218, 218, 218); //grey
  font = createFont("Arial", 14);
  fill(0);
  textSize(70);
  textSize(40);
  textAlign(LEFT);
  text("yaw "+round(yaw* 180 / 2), 350, 300);
  text("pitch "+round(pitch* 180 / 2), 350, 400);
  text("roll "+round(roll* 180 / 2), 350, 500);
  //
} // func


void lochpos() {
}

int lochbestimmung() {
  //vorderer Sensorkranz rechts
  int summeKranz1R=0;
  int kranz = 0;
  for (int i=0; i<9; i++) {      //irSensor.length    muss alten Wert speichern -> (schauen, ob der alte wert wieder kleiner, gleichbleibend, oder größer wird (-> bestimmt Lochgröße)
    summeKranz1R=+irSensor[i];
  }
  if (summeKranz1R!=0) {
    kranz = 1;
  }

  //vorderer Sensorkranz links
  int summeKranz1L=0;
  for (int i=10; i<19; i++) {      //irSensor.length
    summeKranz1L=+irSensor[i];
  }
  if (summeKranz1L!=0) {
    kranz = 1;
  }

  //hinterer Sensorkranz rechts
  int summeKranz2R=0;
  for (int i=20; i<29; i++) {      //irSensor.length
    summeKranz2R=+irSensor[i];
  }
  if (summeKranz2R!=0) {
    kranz = 2;
  }

  //hinterer Sensorkranz links
  int summeKranz2L=0;
  for (int i=30; i<39; i++) {      //irSensor.length
    summeKranz2L=+irSensor[i];
  }
  if (summeKranz2L!=0) {
    kranz = 2;
  }
  return kranz;
}//fct

float getWinkelvorne() {
  int summe = 0;
  int anz = 0;
  int mittelwert = 0;
  for (int i=0; i<19; i++) {
    if (irSensor[i]!=0) {
      summe += i;
      anz ++;
    }
  }
  if (anz !=0) {
    mittelwert = summe/ anz;
    if (mittelwert < 10 ) { // rechter kranz aktiv
      mittelwert = (mittelwert / 10 * 90 +20);//Sensor 0 =20° 9=110°, 10=-20°, 19 = 110°
    } else {  // links aktiv
      mittelwert = -((mittelwert -10)/ 10 *90 +20);
    }
    return mittelwert / 360 * TWO_PI;
  } else {
    return -1;
  }
}


float getWinkelhinten() {
  int summe = 0;
  int anz = 0;
  int mittelwert = 0;
  for (int i=19; i<39; i++) {
    if (irSensor[i]!=0) {
      summe += i;
      anz ++;
    }
  }
  if (anz !=0) {
    mittelwert = summe/ anz;
    if (mittelwert < 30 ) { // rechter kranz aktiv
      mittelwert = ((mittelwert-20) / 10 * 90 +20); // -20 damit im Bereich von 0..10 --> durch 10 --> 0..1 * 90 weil gesuchter bereich + 20 weil ofset
    } else {  // links aktiv
      mittelwert = -((mittelwert -30)/ 10 *90 +20);
    }
    return mittelwert / 360 * TWO_PI;
  } else {
    return -1;
  }
}

float getDurchvorne() {
  int anz = 0;
  for (int i=0; i<19; i++) {
    if (irSensor[i]!=0) {
      anz ++;
    }
  }
  return anz;
}

float getDurchhinten() {
  int anz = 0;
  for (int i=19; i<39; i++) {
    if (irSensor[i]!=0) {
      anz ++;
    }
  }
  return anz;
}

void kreuz() {       //bekommt Winkel des Lochs übertragen
  strokeWeight(4);
  stroke(0, 0, 255);
  // stroke (255,153,0); //orange
  // stroke (153,0,204); //lila
  pushMatrix();
  translate(-pos.x, -pos.y, -pos.z); //schiebt es in den Mittelpunkt
  strokeWeight(1);
  popMatrix();
}