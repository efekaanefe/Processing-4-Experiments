int[][][] matrix; // 3D matrix
int resolution = 20; // Size of each cube
int cubeSize = 100; // Size of the entire cube

void setup() {
  size(400, 400, P3D);
  int cols = cubeSize / resolution;
  int rows = cubeSize / resolution;
  int layers = cubeSize / resolution; // Number of layers in the matrix
  matrix = new int[cols][rows][layers];

  // Initialize matrix with random 1s and 0s
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      for (int k = 0; k < layers; k++) {
        matrix[i][j][k] = int(random(2));
      }
    }
  }
}

void draw() {
  background(255);
  translate(width / 2, height / 2, -10); // Center the matrix

  // Rotate the matrix based on time
  float angle = radians(frameCount);
  rotateX(angle);
  rotateY(angle);
  rotateZ(angle);

  // Display the matrix
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[0].length; j++) {
      for (int k = 0; k < matrix[0][0].length; k++) {
        int x = i * resolution - cubeSize / 2;
        int y = j * resolution - cubeSize / 2;
        int z = k * resolution;

        if (matrix[i][j][k] == 1) {
          fill(0); // Set color to black with alpha transparency
        } else {
          fill(255); // Set color to white with alpha transparency
        }

        // Draw a cube representing the matrix
        pushMatrix();
        translate(x, y, z);
        box(resolution);
        popMatrix();
      }
    }
  }
}
