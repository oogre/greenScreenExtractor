import codeanticode.syphon.*;
import controlP5.*;

ImageGrabber grabber;
Chroma chroma, chroma2;
UI ui;
Edger edger;
Cropper cropper, cropper2;

boolean saveFlag = false;
String actionName = "";
int [] crop;
int w = 480;
int h = 320;
int m = 10;

void setup() {
  size(1440, 960, P3D);
  grabber = new ImageGrabber(this);
  chroma = new Chroma();
  chroma2 = new Chroma();
  ui = new UI(this);
  edger = new Edger();
  cropper = new Cropper();
  cropper2 = new Cropper();
  crop = new int [4];
}
void mousePressed() {
  if (mouseX > m && mouseY > m && mouseX < m + w && mouseY < m + h) {
    ui.cropArea[0] = mouseX;
    ui.cropArea[1] = mouseY;
    crop[0]= ((mouseX-m) * grabber.img.width) / w ;
    crop[1]= ((mouseY-m) * grabber.img.height) / h ;
  }
}
void mouseDragged() {
  if (mouseX > m && mouseY > m && mouseX < m + w && mouseY < m + h) {
    ui.cropArea[2] = mouseX;
    ui.cropArea[3] = mouseY;
    crop[2]= ((mouseX-m) * grabber.img.width) / w ;
    crop[3]= ((mouseY-m) * grabber.img.height) / h ;
  }
}
void mouseReleased() {
  if (   mouseX > m + m + w 
    &&   mouseY > m 
    &&   mouseX < m + m + w + w
    &&   mouseY < m + h ) {
    if (mouseButton == LEFT) {
      chroma.setTarget(mouseX, mouseY);
    } else {
      chroma2.setTarget(mouseX, mouseY);
    }
  }
}
void draw() {
  background(0);
  grabber.update();
  cropper.update(crop, grabber.img);
  chroma.update(cropper.output);
  chroma2.update(chroma.output);
  edger.update(chroma2.output);
  cropper2.update(edger.rect, chroma2.output);
  
  pushMatrix();
  
  translate(10, 10);
  image(grabber.img, 0, 0, w, h);
  translate(10, 0);
  translate(480, 0);
  image(cropper.output, 0, 0, 
    cropper.output.width * w / grabber.img.width, 
    cropper.output.height * h / grabber.img.height);
  pushMatrix();
  translate(10, 0);
  translate(480, 0);
  image(chroma.output, 0, 0, 
    chroma.output.width * w / grabber.img.width, 
    chroma.output.height * h / grabber.img.height);
  translate(0, 10);
  translate(0, 320);
  image(chroma2.output, 0, 0, 
    chroma2.output.width * w / grabber.img.width, 
    chroma2.output.height * h / grabber.img.height);
  popMatrix();
  translate(0, 10);
  translate(0, 320);
  image(cropper2.output, 0, 0, 
    cropper2.output.width * w / grabber.img.width, 
    cropper2.output.height * h / grabber.img.height);
  popMatrix();
  
  chroma.drawTarget();
  chroma2.drawTarget();
  ui.draw();
  if(saveFlag){
    String name = ui.cp5.get(Textfield.class, "input").getText();
    cropper2.output.save("../anims/"+name+"/"+frameCount+".png");
  }
  
}