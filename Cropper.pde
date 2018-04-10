class Cropper{
  PImage output;
  Cropper(){
    output = createImage(1, 1, ARGB);
  }
  PImage update(int[] edge, PImage input) {
    if (input == null) return output;
    if(edge[0] > edge[2]){
      int t = edge[2];
      edge[2] = edge[0];
      edge[0] = t;
    }
    
    if(edge[1] > edge[3]){
      int t = edge[3];
      edge[3] = edge[1];
      edge[1] = t;
    }
    output = input.get(edge[0], edge[1], edge[2]-edge[0], edge[3]-edge[1]);
    return output;
  }
}