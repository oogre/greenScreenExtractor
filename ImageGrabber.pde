class ImageGrabber {
  SyphonClient client;
  PImage workingImg;
  PImage img;
  ImageGrabber(PApplet parent) {
    client = new SyphonClient(parent);
    img = createImage(1, 1, ARGB);
    workingImg = createImage(1, 1, ARGB);
    
  }
  void update() {
    if (client.newFrame()) {
      workingImg = client.getImage(workingImg); // load the pixels array with the updated image info (slow)
      //img = client.getImage(img, false); // does not load the pixels array (faster)
      if (workingImg != null) {
        img = workingImg;
      }
    }
  }
}