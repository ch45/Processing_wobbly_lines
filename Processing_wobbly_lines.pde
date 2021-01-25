static final int BACKGROUND_COLOUR = 100;
static final int LINE_COLOUR = 200;

WobblyLine[] linesArr = new WobblyLine[3];

public void settings() {
  size (720, 480);
}

public void setup() {
  linesArr[0] = new WobblyLine( 10, width - 10,     height / 4, 2 * height / 3, 100,  5);
  linesArr[1] = new WobblyLine( 10, width - 10, 2 * height / 4, 2 * height / 3, 100,  3);
  linesArr[2] = new WobblyLine( 10, width - 10, 3 * height / 4, 2 * height / 3, 100,  7);
  frameRate(60);
}

public void draw() {
  background(BACKGROUND_COLOUR);
  linesArr[0].draw(
    0.1f + frameCount * 0.005f, 2.1f + frameCount * 0.005f,
    0.1f + frameCount * 0.01f, 0.2f + frameCount * 0.01f);

  linesArr[1].draw(
    0.1f + frameCount * 0.01f, 50.1f + frameCount * 0.01f,
    0.1f + frameCount * 0.01f, 0.2f + frameCount * 0.01f);

  linesArr[2].draw(
    0.1f + frameCount * 0f, 5.1f + frameCount * 0f,
    0.1f + frameCount * 0.05f, 1.1f + frameCount * 0.05f);
}

class WobblyLine {
  int startX;
  int endX;
  int endXPlusOne;
  int middleY;
  int wobbleHeight;
  int numPoints;
  int numLines;

  WobblyLine(int startX, int endX, int middleY, int wobbleHeight, int numPoints, int numLines) {
    this.startX = startX;
    this.endX = endX;
    this.middleY = middleY;
    this.wobbleHeight = wobbleHeight;
    this.numPoints = numPoints;
    this.numLines = numLines;
    endXPlusOne = endX + (endX - startX) / (numPoints);
  }

  void draw(float noiseStartX, float noiseEndX, float noiseStartY, float noiseEndY) {
    float noiseEndXPlusOne = noiseEndX + (noiseEndX - noiseStartX) / numPoints;
    float noiseEndYPlusOne = noiseEndY + (noiseEndY - noiseStartY) / numLines;
    float startY = middleY - 1.0f * (numLines - 1);
    float endYPlusOne = middleY + 1.0f * ( numLines + 1);
    stroke(LINE_COLOUR);

    for (int j = 0; j < numLines; j++) {
      int x2 = 0;
      int y2 = 0;
      int y = (int)map(j, 0, numLines, startY, endYPlusOne);
      float nY = map(j, 0, numLines, noiseStartY, noiseEndYPlusOne);
      for (int k = 0; k < numPoints; k++) {
        int x1 = (int)map(k, 0, numPoints, startX, endXPlusOne);
        float nX = map(k, 0, numPoints, noiseStartX, noiseEndXPlusOne);
        float offset = noise(nX, nY) - 0.5f;
        int y1 = (int)(y + offset * wobbleHeight / 2.0f);
        if (k > 0) {
          line(x1, y1, x2, y2);
        }
        x2 = x1;
        y2 = y1;
      }
    }
  }
}

