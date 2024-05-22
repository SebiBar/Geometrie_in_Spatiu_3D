import controlP5.*; //Interfata utilizator
ControlP5 cp5;

ColorPicker cp; // Pentru interfata
boolean wireframe = true; // Modul de afisare

int numVertices = 5; // varfuri poligon
float baseRadius = 100; // Raza poligonului de bază
float heightP = 150; // Inaltimea piramidei

// Variabile pentru transformari
PVector translation = new PVector(150, 0, 0); // Translatia
PVector rotation = new PVector(8, 0, 0); // Rotatia
float scaleFactor = 1.0; // Scala

color baseColor;
color pyramidColor;

void setup() {              //SETUP
  size(1000, 600, P3D);
  
  cp5 = new ControlP5(this);
  cp5.addSlider("setNumVertices") // Numar de laturi
     .setPosition(10, 55)
     .setSize(100, 20)
     .setRange(3, 10)
     .setNumberOfTickMarks(8)
     .setValue(3);
  cp5.addSlider("setHeight") // Inaltime piramida
     .setPosition(10, 95)
     .setSize(100, 20)
     .setRange(1, 500)
     .setValue(150);
  cp5.addSlider("setRadius") // Raza poligon
     .setPosition(10, 135)
     .setSize(100, 20)
     .setRange(1, 300)
     .setValue(100);
  cp5.addButton("wireframe") // Afisare schelet sau nu
     .setValue(0)
     .setPosition(10,300)
     .setSize(100,20)
     ;
  cp = cp5.addColorPicker("setBaseColor") // Culoare baza
     .setPosition(10, 350)
     .setColorValue(color(255, 0, 128, 255))
     ;
  cp = cp5.addColorPicker("setPyramidColor") // Culoare piramida
     .setPosition(10, 440)
     .setColorValue(color(0, 128, 255, 255))
     ;
}

void draw() {                //DRAW
  background(255);
  lights();

  //Aplicam transformarile si desenam
  pushMatrix();
  
  translate(width/2 + translation.x, height/2 + translation.y, translation.z);
  rotateX(rotation.x);
  rotateY(rotation.y);
  rotateZ(rotation.z);
  scale(scaleFactor);
  drawPyramid();
  drawBase();
  popMatrix();
  
  //Actualizam interfata text fara transformari
  displayInfo();
}

void drawBase() {                 //DRAW BASE
  if (wireframe)
  {
    stroke(baseColor);
    noFill();
  }
  else
  {
    stroke(0);
    fill(baseColor);
  }
  beginShape();
  for (int i = 0; i < numVertices; i++) {
    float angle = TWO_PI / numVertices * i;
    float x = cos(angle) * baseRadius;
    float y = sin(angle) * baseRadius;
    vertex(x, y, 0);
  }
  endShape(CLOSE);
}

void drawPyramid() {             // DRAW PYRAMID
  if (wireframe)
  {
    stroke(pyramidColor);
    noFill();
  }
  else
  {
    noStroke();
    fill(pyramidColor);
  }
  // Desenare fata piramidei
  beginShape();
  for (int i = 0; i < numVertices; i++) {
    float angle = TWO_PI / numVertices * i;
    float x = cos(angle) * baseRadius;
    float y = sin(angle) * baseRadius;
    vertex(x, y, 0);
  }
  vertex(0, 0, heightP);
  endShape(CLOSE);
  
  if (wireframe)
  {
    stroke(pyramidColor);
    noFill();
  }
  else
  {
    noStroke();
    fill(pyramidColor);
  }
  
  // Desenare laturi externe
  for (int i = 0; i < numVertices; i++) {
    beginShape();
    float angle1 = TWO_PI / numVertices * i;
    float x1 = cos(angle1) * baseRadius;
    float y1 = sin(angle1) * baseRadius;
    float angle2 = TWO_PI / numVertices * ((i + 1) % numVertices);
    float x2 = cos(angle2) * baseRadius;
    float y2 = sin(angle2) * baseRadius;
    vertex(x1, y1, 0);
    vertex(x2, y2, 0);
    vertex(0, 0, heightP);
    endShape(CLOSE);
  }
}

void displayInfo() {               // DISPLAY INFO
  fill(0);
  textSize(16);
  textAlign(LEFT);
  text("Piramida:", 10, 25);
  text("Numărul de vârfuri ale poligonului: " + numVertices, 10, 45);
  text("Raza bazei: " + baseRadius, 10, 130);
  text("Înălțime: " + heightP, 10, 90);
  text("Translație: " + translation, 10, 170);
  text("-Trageți cu mouse-ul pentru schimbarea poziției", 10, 190);
  text("Rotație: " + rotation, 10, 210);
  text("-Folosiți săgețile tastaturii pentru rotire", 10, 230);
  text("Scala: " + scaleFactor, 10, 250);
  text("-Folosiți tastele +/= si - pentru a schimba scala", 10, 270);
  text("Mod de afisare wireframe: " + wireframe, 10, 290);
  text("Culoarea bazei:", 10, 340);
  text("Culoarea piramidei:", 10, 430);
}

// miscarea piramidei
void mouseDragged() {
  if (!cp5.isMouseOver()) //atunci cand mouseul nu e pe interfata
  {
    translation.x += (mouseX - pmouseX);
    translation.y += (mouseY - pmouseY);
  }
}

void keyPressed() {
  // rotire si scalare
  if (keyCode == UP) {
    rotation.x += radians(12);
  } else if (keyCode == DOWN) {
    rotation.x -= radians(12);
  } else if (keyCode == LEFT) {
    rotation.y += radians(12);
  } else if (keyCode == RIGHT) {
    rotation.y -= radians(12);
  } else if (key == '+' || key=='=') {
    scaleFactor += 0.1;
  } else if (key == '-') {
    scaleFactor -= 0.1;
  }
}

// functionalitatea interfetei

void setNumVertices(float value) {
  numVertices = (int)value;
}
void setHeight(float value) {
  heightP = value;
}
void setRadius(float value) {
  baseRadius = (int)value;
}
void wireframe() {
  wireframe = !wireframe;
}
void setBaseColor(int clr) {
  baseColor = color(clr);
}

void setPyramidColor(int clr) {
  pyramidColor = color(clr);
}
