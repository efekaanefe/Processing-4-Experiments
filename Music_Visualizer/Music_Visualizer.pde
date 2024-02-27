import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

int numGroups = 50;
float rectSpacing = 4;

float[] groupAverages;

void setup() {
  size(900, 500);

  minim = new Minim(this);
  player = minim.loadFile("Daft Punk - Robot Rock.mp3");
  fft = new FFT(player.bufferSize(), player.sampleRate());
  player.play();

  groupAverages = new float[numGroups];
}

void draw() {
  background(42);

  fft.forward(player.mix);

  int bandsPerGroup = fft.specSize() / numGroups;

  for (int i = 0; i < numGroups; i++) {
    float sum = 0;
    int start = i * bandsPerGroup;
    int end = (i + 1) * bandsPerGroup;

    for (int j = start; j < end; j++) {
      sum += fft.getBand(j);
    }

    groupAverages[i] = sum / bandsPerGroup;
  }

  float rectWidth = width/2 / numGroups;
  float rectHeightScale = height / 8;
  float totalRectWidth = numGroups * rectWidth + (numGroups - 1) * rectSpacing;
  float startX = (width - totalRectWidth) / 2;

  fill(150, 0, 0); // bar color
  strokeWeight(3); 

  for (int i = 1; i < numGroups; i++) { // index 1 is usually too high, cheating...
    float x = startX + i * (rectWidth + rectSpacing);
    float y = height / 2 - groupAverages[i] * rectHeightScale / 2;
    rect(x, y, rectWidth, groupAverages[i] * rectHeightScale);
  }
}
