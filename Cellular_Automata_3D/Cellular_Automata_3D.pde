int[][][] matrix; // 3D matrix
int resolution = 20; // Size of each cube
int cubeSize = 400; // Size of the entire cube

void setup() {
  size(800, 800, P3D);
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
  lights();
  translate(width / 2, height / 2, -cubeSize/2); // Center the matrix

  // Rotate the matrix based on time
  float angle = radians(frameCount);
  //rotateX(angle);
  rotateY(angle*2);
  //rotateZ(angle);


  // Display the matrix
  for (int i = 0; i < matrix.length; i++) {
    for (int j = 0; j < matrix[0].length; j++) {
      for (int k = 0; k < matrix[0][0].length; k++) {
        int x = i * resolution - cubeSize / 2;
        int y = j * resolution - cubeSize / 2;
        int z = k * resolution - cubeSize / 2;

        if (matrix[i][j][k] == 1) {
          //fill(0, 100);
          fill(50);
        } else {
          noFill();
          //fill(255, 10);
        }

        // Draw a cube representing the matrix
        pushMatrix();
        noStroke();
        translate(x, y, z);
        box(resolution);
        popMatrix();
      }
    }
  }
}

int countNeighbors(int[][][] matrix, int i, int j, int k) {
  int count = 0;
  int cols = matrix.length;
  int rows = matrix[0].length;
  int layers = matrix[0][0].length;
  
  // Loop through the neighbors
  for (int di = -1; di <= 1; di++) {
    for (int dj = -1; dj <= 1; dj++) {
      for (int dk = -1; dk <= 1; dk++) {
        // Skip the center cell
        if (di == 0 && dj == 0 && dk == 0) continue;
        
        // Calculate neighbor indices
        int ni = i + di;
        int nj = j + dj;
        int nk = k + dk;
        
        // Check if the neighbor is within bounds and has a value of 1
        if (ni >= 0 && ni < cols && nj >= 0 && nj < rows && nk >= 0 && nk < layers && matrix[ni][nj][nk] == 1) {
          count++;
        }
      }
    }
  }
  
  return count;
}
