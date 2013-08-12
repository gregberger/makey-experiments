class Sphere {
  private color c;
  private float r;
  private float x;
  private float y;
  private float z;
  public Sphere(color _c) {
    c = _c;
  }
  public Sphere(float _x, float _y, float _r, int _c) {
    c= _c;
    r = _r;
    x = _x;
    y = _y;
  }
  public Sphere() {
    c = color(0, 0, 0);
    r = 5;
    x = width/2;
    y = height/2;
  }

  public Sphere setColor(color _c) {
    c = _c; 
    return this;
  }

  public Sphere setPosX(float _x) {
    x = _x; 
    return this;
  }

  public Sphere setPosY(float _y) {
    y = _y; 
    return this;
  }
  public Sphere setPosZ(float _z) {
    z = _z;
    return this;
  }

  public Sphere setSize(float _r) {
    r = _r;
    return this;
  }

  public Sphere grow() {
    if (r <= 100)
      r++;
    return this;
  }

  public Sphere shrink() {
    if (r >= 10)
      r--; 
    return this;
  }

  public Sphere draw() {
    if(abs(r) < 0.1) return this;
    pushMatrix();
    noStroke();
    fill(c);
    translate(x, y, z);

    // ellipse(x,y,r*2,r*2);
    sphere(r*2);
    popMatrix();
    return this;
  }
}

