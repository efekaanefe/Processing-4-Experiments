import ddf.minim.*;

Minim minim;
AudioPlayer player;

void setup() {
  size(800, 400);
  
  minim = new Minim(this);
  player = minim.loadFile("Daft Punk - Robot Rock.mp3");
  player.play();
}

void draw() {
  background(255);
  // Add your drawing code here
}

void stop() {
  player.close();
  minim.stop();
  super.stop();
}
