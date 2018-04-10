PVector RGBtoHSB(int r, int g, int b) {
  return RGBtoHSB(new PVector (r, g, b)); 
}
  PVector RGBtoHSB(PVector input) {
  float hue, saturation, brightness;
  int r = (int)input.x;
  int g = (int)input.y;
  int b = (int)input.z;
  PVector output = new PVector();
  int cmax = (r > g) ? r : g;
  if (b > cmax) cmax = b;
  int cmin = (r < g) ? r : g;
  if (b < cmin) cmin = b;
  brightness = ((float) cmax) / 255.0f;
  if (cmax != 0)
    saturation = ((float) (cmax - cmin)) / ((float) cmax);
  else
    saturation = 0;
  if (saturation == 0)
    hue = 0;
  else {
    float redc = ((float) (cmax - r)) / ((float) (cmax - cmin));
    float greenc = ((float) (cmax - g)) / ((float) (cmax - cmin));
    float bluec = ((float) (cmax - b)) / ((float) (cmax - cmin));
    if (r == cmax)
      hue = bluec - greenc;
    else if (g == cmax)
      hue = 2.0f + redc - bluec;
    else
      hue = 4.0f + greenc - redc;
    hue = hue / 6.0f;
    if (hue < 0)
      hue = hue + 1.0f;
  }
  output.x = hue;
  output.y = saturation;
  output.z = brightness;
  return output;
}