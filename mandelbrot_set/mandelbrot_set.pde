int maxIteration = 100;

float limit = 1;
float xmin = -limit;
float xmax = limit;
float ymin = -limit;
float ymax = limit;

void setup() {
  size(800, 800);
  loadPixels();
  drawMandelbrot();
}

void draw() {
}

void drawMandelbrot() {
  for (int px = 0; px < width; px++) {
    for (int py = 0; py < height; py++) {

      float x0 = map(px, 0, width, xmin, xmax);
      float y0 = map(py, 0, height, ymin, ymax);

      float x = 0;
      float y = 0;
      int iteration = 0;
      while (x*x + y*y < 2*2 && iteration < maxIteration) {
        float xtemp = x*x - y*y + x0;
        y = 2*x*y+y0;
        x = xtemp;
        iteration++;
      }

      float bright = map(iteration, 0, maxIteration, 0, 255);
      int col = color(bright);

      pixels[px + py * width] = col;
    }
  }
  updatePixels();
}
void mouseClicked() {
  // Move along x and y
  float newWidth = (xmax - xmin) / 2;
  float newHeight = (ymax - ymin) / 2;
  float mouseXPos = map(mouseX, 0, width, xmin, xmax);
  float mouseYPos = map(mouseY, 0, height, ymin, ymax);
  xmin = mouseXPos - newWidth;
  xmax = mouseXPos + newWidth;
  ymin = mouseYPos - newHeight;
  ymax = mouseYPos + newHeight;

  drawMandelbrot();
}


void mouseWheel(MouseEvent event) {
  float zoomFactor = 0.1;
  float e = event.getCount();
  if (e > 0) {
    // Zoom in
    float newWidth = (xmax - xmin) * (1 - zoomFactor);
    float newHeight = (ymax - ymin) * (1 - zoomFactor);
    float centerX = map(mouseX, 0, width, xmin, xmax);
    float centerY = map(mouseY, 0, height, ymin, ymax);
    xmin = centerX - newWidth / 2;
    xmax = centerX + newWidth / 2;
    ymin = centerY - newHeight / 2;
    ymax = centerY + newHeight / 2;
  } else if (e < 0) {
    // Zoom out
    float newWidth = (xmax - xmin) * (1 + zoomFactor);
    float newHeight = (ymax - ymin) * (1 + zoomFactor);
    float centerX = map(mouseX, 0, width, xmin, xmax);
    float centerY = map(mouseY, 0, height, ymin, ymax);
    xmin = centerX - newWidth / 2;
    xmax = centerX + newWidth / 2;
    ymin = centerY - newHeight / 2;
    ymax = centerY + newHeight / 2;
  }

  drawMandelbrot();
}

void keyPressed() {
  if (key == 'r' || key == 'R') {
    xmin = -limit;
    xmax = limit;
    ymin = -limit;
    ymax = limit;
    drawMandelbrot();
  }
}
