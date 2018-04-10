class UI {
  ControlP5 cp5;
  int [] cropArea;
  String textValue = "";
  UI(PApplet parent) {
    cropArea = new int [4];
    cp5 = new ControlP5(parent);

    cp5.addSlider("chroma.1.treshold")
      .setRange(0, 1)
      .setValue(50)
      .setPosition(1010, 30)
      .setSize(100, 20)
      .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) {
          chroma.setTreshold(theEvent.getController().getValue());
        }
      });

    cp5.addSlider("chroma.2.treshold")
      .setRange(0, 1)
      .setValue(50)
      .setPosition(1010, 360)
      .setSize(100, 20)
      .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) {
          chroma2.setTreshold(theEvent.getController().getValue());
        }
      });

    cp5.addSlider("Edger")
      .setRange(0, 255)
      .setValue(10)
      .setPosition(20 + 480, 40 + 320)
      .setSize(100, 20)
      .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) {
          edger.setTreshold(theEvent.getController().getValue());
        }
      });
    cp5.addTextfield("input")
      .setPosition(20, 40 + 320)
      .setSize(200, 40)
      .setFont(createFont("arial", 20))
      .setColor(color(255))
      .setAutoClear(false);
      
    cp5.addBang("REC")
      .setPosition(220, 40 + 320)
      .setSize(80, 40)
      .addCallback(new CallbackListener() {
        public void controlEvent(CallbackEvent theEvent) {
          if(100 ==theEvent.getAction()) {
            if(saveFlag) {
              ui.cp5.get(Textfield.class, "input").clear();
              saveFlag = false;
            } else if(!ui.cp5.get(Textfield.class, "input").getText().equals("")) {
              saveFlag = true;
            }
            theEvent.getController().setLabel(!saveFlag ? "REC" : "STOP");
          }
        }
      })
      .getCaptionLabel()
      .align(ControlP5.CENTER, ControlP5.CENTER);
  }
  void draw() {
    noFill();
    stroke(255);
    strokeWeight(2);
    beginShape(QUAD);
    vertex(cropArea[0], cropArea[1]);
    vertex(cropArea[2], cropArea[1]);
    vertex(cropArea[2], cropArea[3]);
    vertex(cropArea[0], cropArea[3]);
    endShape();
  }
}