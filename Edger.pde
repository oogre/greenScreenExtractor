class Edger {
  PImage output;
  int [] rect;
  float treshold = 10;
  Edger() {
    rect = new int[4];
    output = createImage(1, 1, ARGB);
  }

  void setTreshold(float t){
    treshold = t;
  }
  
  int getY1(PImage input) {
    for (int y = 0, c = 0; y < input.height; y ++) {
      for (int x = 0; x < input.width; x ++) {
        if (128 < (input.pixels[x+y*input.width] >> 24 & 0xFF)) {
          c++;
        }
        if (c > treshold)return y;
      }
    }
    return 0;
  }
  int getY2(PImage input) {
    for (int y = input.height-1, c = 0; y >= 0; y --) {
      for (int x = 0; x < input.width; x ++) {
        if (128 < (input.pixels[x+y*input.width] >> 24 & 0xFF)) {
          c++;
        }
        if (c > treshold)return y;
      }
    }
    return 0;
  }
  int getX1(PImage input) {
    for (int x = 0, c = 0; x < input.width; x ++) {
      for (int y = 0; y < input.height; y ++) {
        if (128 < (input.pixels[x+y*input.width] >> 24 & 0xFF)) {
          c++;
        }
        if (c > treshold)return x;
      }
    }
    return 0;
  }
  int getX2(PImage input) {
    for (int x = input.width-1, c = 0; x >= 0; x --) {
      for (int y = 0; y < input.height; y ++) {
        if (128 < (input.pixels[x+y*input.width] >> 24 & 0xFF)) {
          c++;
        }
        if (c > treshold)return x;
      }
    }
    return 0;
  }

  int [] update(PImage input) {
    input.loadPixels();
    rect[0] = getX1(input);
    rect[1] = getY1(input);
    rect[2] = getX2(input);
    rect[3] = getY2(input);
    input.updatePixels();
    return rect;
  }
}