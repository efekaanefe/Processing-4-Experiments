// TODOs and bugs:
// visuals are not good, no animation or color
// when starting with every cell alive, the symmetry isn't obeyed when applying rules

int[][][] matrix; // 3D matrix
int[][][] matrixCopy;
int resolution = 10; // Size of each cube
int cubeSize = 400; // Size of the entire cube

int rows = cubeSize / resolution;
int cols = cubeSize / resolution;
int layers = cubeSize / resolution;

int countLimit = 5; // apply rules for n frames
int countForRules = 0;

int minRangeForLiveCell = 3; // defines the zone a cell lives
int maxRangeForLiveCell = 8;
int minRangeForDeadCell = 6;
int maxRangeForDeadCell = 10;

void setup() {
  size(800, 800, P3D);
  frameRate(75);

  matrix = new int[rows][cols][layers];
  matrixCopy = new int[rows][cols][layers];

  // Initialize matrix with random 1s and 0s
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      for (int k = 0; k < layers; k++) {
        if (int(random(100))<3) {
          matrix[i][j][k] = 1;
        } else {
          matrix[i][j][k] = 0;
        }
        matrixCopy[i][j][k] = matrix[i][j][k];
      }
    }
  }
}

void draw() {
  background(255);
  lights();
  translate(width / 2, height / 2, -cubeSize/2); // Center the matrix
  float angle = radians(frameCount);
  //rotateX(angle);
  rotateY(angle*1);
  //rotateZ(angle);

  // Display and update the matrix
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      for (int k = 0; k < layers; k++) {
        
        if (countForRules == countLimit) {
          // Rules
          int neighborCount = countNeighbors(matrix, i, j, k);
          int currentCellValue = matrix[i][j][k];

          matrixCopy[i][j][k] = 0;
          if (currentCellValue == 1) {
            if (neighborCount >= minRangeForLiveCell && neighborCount <= maxRangeForLiveCell) {
              matrixCopy[i][j][k] = 1;
            }
          } else { // dead cell
            if (neighborCount >= minRangeForDeadCell && neighborCount <= maxRangeForDeadCell) {
              matrixCopy[i][j][k] = 1;
            }
          }
        }

        // Drawing
        if (matrix[i][j][k] == 1) {
          fill(50);
        } else {
          noFill();
        }

        int x = i * resolution - cubeSize / 2;
        int y = j * resolution - cubeSize / 2;
        int z = k * resolution - cubeSize / 2;

        // Draw a cube representing the matrix
        pushMatrix();
        noStroke();
        translate(x, y, z);
        box(resolution);
        popMatrix();
      }
    }
  }
  matrix = matrixCopy;
  if (countForRules == countLimit) {
    countForRules = 0;
  }
  countForRules++;
}

int countNeighbors(int[][][] matrix, int i, int j, int k) {
  int count = 0;

  for (int di = -1; di <= 1; di++) {
    for (int dj = -1; dj <= 1; dj++) {
      for (int dk = -1; dk <= 1; dk++) {
        // Skip the center cell
        if (di == 0 && dj == 0 && dk == 0) continue;

        int ni = i + di;
        int nj = j + dj;
        int nk = k + dk;

        if (ni >= 0 && ni < cols
          && nj >= 0
          && nj < rows
          && nk >= 0 && nk < layers
          && matrix[ni][nj][nk] == 1) {
          count++;
        }
      }
    }
  }

  return count;
}
