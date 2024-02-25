import peasy.*;

PeasyCam cam;

int DIM = 100;
ArrayList<PVector> mandelbulb = new ArrayList<PVector>();

void setup() {
  size(800, 800, P3D);
  cam = new PeasyCam(this, 800);
  int maxIterations = 5;
  int n = 6;
  for (int i = 0; i < DIM; i++) {
    for (int j = 0; j < DIM; j++) {
      boolean edge = false;
      for (int k = 0; k < DIM; k++) {

        // original x,y,z are the c
        float x = map(i, 0, DIM, -1, 1);
        float y = map(j, 0, DIM, -1, 1);
        float z = map(k, 0, DIM, -1, 1);

        PVector v = new PVector(x, y, z);
        int iteration = 0;

        while (true) {

          // this is for v^n
          float r = sqrt(v.x*v.x+v.y*v.y+v.z*v.z);
          float phi = atan2(v.y, v.x);
          float theta = atan2(sqrt(v.x*v.x+v.y*v.y), v.z);
          float xn = pow(r, n) * sin(n*theta) * cos(n*phi);
          float yn = pow(r, n) * sin(n*theta) * sin(n*phi);
          float zn = pow(r, n) * cos(n*theta);

          v.x = xn+x;
          v.y = yn+y;
          v.z = zn+z;

          iteration++;
          if (r>2) {
            if (edge) {
              edge = false;
            }
            break;
          }
          if (iteration>maxIterations) {
            if (!edge) {
              edge = true;
              mandelbulb.add(new PVector(x, y, z));
            }
            break;
          }
        }
      }
    }
  }
}

void draw() {
  background(0);
  for (PVector point : mandelbulb) {
    stroke(255);
    strokeWeight(1);
    point(point.x*100, point.y*100, point.z*100);
  }
}
