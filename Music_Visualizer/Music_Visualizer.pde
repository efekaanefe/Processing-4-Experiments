import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;
FFT fft;

void setup() {
  size(800, 400);
  
  minim = new Minim(this);
  
  player = minim.loadFile("Daft Punk - Robot Rock.mp3");
  
  fft = new FFT(player.bufferSize(), player.sampleRate());
  
  player.play();
}

void draw() {
  fft.forward(player.mix);
  
  int bands = fft.specSize();
  
  for (int i = 0; i < bands; i++) {
    float mag = fft.getBand(i);
    println("Magnitude value for band " + i + ": " + mag);
  }
  
  // Add your drawing code here
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
