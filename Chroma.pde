class Chroma {
  PImage output;
  PVector target;
  PVector targetPos;
  float treshold = 10000;
  Chroma() {
    output = createImage(1, 1, ARGB);
    target = new PVector();
    targetPos = new PVector();
  }
  void setTarget(int x, int y) {
    targetPos.set(x, y);
    int c = get(x, y);
    target.set(
      c >> 16 & 0xFF, 
      c >> 8 & 0xFF, 
      c >> 0 & 0xFF
    );
    target = RGBtoHSB(target);
    println(target);
  }
  void setTreshold(float t){
    treshold = t;
  }
  PImage update(PImage input) {
    if (input == null) return output;
    if (output.width != input.width || output.height != input.height) output = createImage(input.width, input.height, ARGB);
    input.loadPixels();
    output.loadPixels();
    for (int i = 0; i < input.pixels.length; i ++) {
      int a = input.pixels[i] >> 24 & 0xFF;
      int r = input.pixels[i] >> 16 & 0xFF;
      int g = input.pixels[i] >> 8 & 0xFF;
      int b = input.pixels[i] >> 0 & 0xFF;
      PVector current = RGBtoHSB(r, g, b);
      float dd = abs(current.x - target.x);
      output.pixels[i] = color(r, g, b, a * (dd < treshold ? 0 : 255));
    }
    input.updatePixels();
    output.updatePixels();
    return output;
  }
  
  void drawTarget(){
    ellipseMode(CENTER);
    stroke(255);
    strokeWeight(5);
    fill(target.x, target.y, target.z);
    ellipse(targetPos.x, targetPos.y, 20, 20);
  }
}