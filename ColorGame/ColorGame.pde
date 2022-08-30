int activeColor = 0;
int number;
int score;
int highScore;

Table save;

float ranR;
float ranG;
float ranB;

String chosenR = "";
String chosenG = "";
String chosenB = "";

void setup() {
  size(500, 400);
  randomColor();
  save = loadTable("Save.csv", "header");
  highScore = save.getInt(0, "highScore");
}

void randomColor() {
  ranR = random(255);
  println("Red: " + ranR);
  ranG = random(255);
  println("Green: " + ranG);
  ranB = random(255);
  println("Blue: " + ranB);

  background(ranR, ranG, ranB);
}

void draw() {
  fill(255);
  stroke(255);
  square(0, 300, 500);

  textSize(30);
  fill(0);
  text("Red: " + chosenR, 40, 360);
  text("Green: " + chosenG, 180, 360);
  text("Blue: " + chosenB, 350, 360);

  fill(ranR, ranG, ranB);
  stroke(ranR, ranG, ranB);
  square(0, 0, 50);

  textSize(20);
  fill(0);
  text(highScore, 10, 30);

  if (activeColor == 0) {
    fill(255, 0, 0);
    stroke(255, 0, 0);
    rect(40, 370, 55, 5);
  }
  if (activeColor == 1) {
    fill(0, 255, 0);
    stroke(0, 255, 0);
    rect(180, 370, 85, 5);
  }
  if (activeColor == 2) {
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rect(350, 370, 65, 5);
  }
}

void keyPressed() {
  if (key == 'r') {
    highScore = 1000;
  }

  if (keyCode == RIGHT && activeColor != 2) {
    activeColor++;
  }
  if (keyCode == LEFT && activeColor != 0) {
    activeColor--;
  }

  if (keyCode != LEFT && keyCode != RIGHT && keyCode != ENTER && keyCode != BACKSPACE && key != 'r') {
    switch (activeColor) {
    case 0:
      chosenR += key;
      break;
    case 1:
      chosenG += key;
      break;
    case 2:
      chosenB += key;
      break;
    default:

      break;
    }
  }

  switch (activeColor) {
  case 0:
    if (keyCode == BACKSPACE) {
      chosenR = chosenR.substring(0, chosenR.length() - 1);
    }
    break;
  case 1:
    if (keyCode == BACKSPACE) {
      chosenG = chosenG.substring(0, chosenG.length() - 1);
    }
    break;
  case 2:
    if (keyCode == BACKSPACE) {
      chosenB = chosenB.substring(0, chosenB.length() - 1);
    }
    break;
  default:

    break;
  }

  if (keyCode == ENTER) {
    score += abs(int(ranR) - Integer.valueOf(chosenR));
    score += abs(int(ranG) - Integer.valueOf(chosenG));
    score += abs(int(ranB) - Integer.valueOf(chosenB));

    println(score);

    textSize(50);
    fill(0);
    text("Score: " + score, 150, 180);

    if (score < highScore) {
      highScore = score;
      save.setInt(0, "highScore", highScore);
      saveTable(save, "data/Save.csv");
    }
  }
}
