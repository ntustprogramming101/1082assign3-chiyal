PImage bg, title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhog, soldier, cabbage, life;
PImage soil8x24,soil0, soil1, soil2, soil3, soil4, soil5, stone1 ,stone2;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

int grid = 80;
int groundhogX = grid*4;
int groundhogY = grid;
int groundhogSpeed = 5;
final int IDLE = 0, GO_DOWN1 = 1, GO_DOWN2 = 2, GO_RIGHT = 3, GO_LEFT = 4;

int status = IDLE;
boolean moving = false;

int lifeScore = 2;
int heartBorder = 10;
int heartInterval = 70;

int soilY;
boolean liLevelGround = false;
boolean LevelGround = false;

int soldierLevel = (floor(random(4))+2)*grid;
int soldierX = -50;
int soilderXSpeed = 5;
boolean isCrack = true;
int supTime = 0, addTime = 1;

int cabbageX =(floor(random(8)))*grid;
int cabbageY =(floor(random(4))+2)*grid;
boolean cabbageImerge = true;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

void setup() {
  size(640, 480, P2D);
  // Enter your setup code here (please put loadImage() here or your game will lag like crazy)
  bg = loadImage("img/bg.jpg");
  title = loadImage("img/title.jpg");
  gameover = loadImage("img/gameover.jpg");
  startNormal = loadImage("img/startNormal.png");
  startHovered = loadImage("img/startHovered.png");
  restartNormal = loadImage("img/restartNormal.png");
  restartHovered = loadImage("img/restartHovered.png");
  groundhog = loadImage("img/groundhogIdle.png");
  soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  cabbage = loadImage("img/cabbage.png");
  soldier = loadImage("img/soldier.png");
  life = loadImage("img/life.png");
}

void draw() {
    /* ------ Debug Function ------ 
      Please DO NOT edit the code here.
      It's for reviewing other requirements when you fail to complete the camera moving requirement.
    */
    if (debugMode) {
      pushMatrix();
      translate(0, cameraOffsetY);
    }
    /* ------ End of Debug Function ------ */
    
  switch (gameState) {

    case GAME_START: // Start Screen
    image(title, 0, 0);
    if(START_BUTTON_X + START_BUTTON_W > mouseX && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY && START_BUTTON_Y < mouseY){
      image(startHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
        gameState = GAME_RUN;
        mousePressed = false;
      }
    }else{
      image(startNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;

    case GAME_RUN: // In-Game
    // Background
    image(bg, 0, 0);
    // Sun
    stroke(255,255,0);
    strokeWeight(5);
    fill(253,184,19);
    ellipse(590,50,120,120);
    // Grass
    fill(124, 204, 25);
    noStroke();
    rect(0, 160 - GRASS_HEIGHT - soilY, width, GRASS_HEIGHT);
    
    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
         for (int y=grid*2 ; y<=grid*6 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil0, x, y-soilY); }}
         for (int y=grid*6 ; y<=grid*10 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil1, x, y-soilY); }}
         for (int y=grid*10 ; y<=grid*14 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil2, x, y-soilY); }}
         for (int y=grid*14 ; y<=grid*18 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil3, x, y-soilY); }}
         for (int y=grid*18 ; y<=grid*22 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil4, x, y-soilY); }}
         for (int y=grid*22 ; y<=grid*26 ; y+=grid){
           for (int x=0 ; x<width ; x+=grid){
             image(soil5, x, y-soilY); }}
             
    // stone
         for (int i=0 ; i<=8 ; i++){
           image(stone1, grid*i, grid*(i+2)-soilY);}
           
         for (int X=0 ; X<=8 ; X+=1){
           if (X==0 || X==3 || X==4 || X==7){
             for (int Y=0 ; Y<=8 ; Y+=1){
               if (Y==1 || Y==2 || Y==5 || Y==6){
                 image(stone1, grid*X, grid*(Y+10)-soilY);}}
           }else{
             for (int Y=0 ; Y<=8 ; Y+=1){
                   if (Y==0 || Y==3 || Y==4 || Y==7){
                     image(stone1, grid*X, grid*(Y+10)-soilY);}}
            }
         }
         for (int H=0 ; H<=8 ; H+=1){
           for (int A=1 ; A<=13; A+=3){image(stone1, grid*(A-H), grid*(H+18)-soilY);image(stone1, grid*(A-H+1), grid*(H+18)-soilY);}
           for (int A=2 ; A<=14 ; A+=3){image(stone2, grid*(A-H), grid*(H+18)-soilY);}
         }
    // Player
        image(groundhog,groundhogX, groundhogY);
        if (soilY>=1600){LevelGround = true;}
        if (soilY>=160){liLevelGround = true;}
        switch(status){
          case IDLE:
            groundhog = loadImage("img/groundhogIdle.png");
            moving = false;
            break;
          case GO_LEFT:
            groundhogX-=groundhogSpeed;
            groundhog = loadImage("img/groundhogLeft.png");
            if (groundhogX%grid==0){status=IDLE;}
            break;
          case GO_RIGHT:
            groundhogX+=groundhogSpeed;
            groundhog = loadImage("img/groundhogRight.png");
            if (groundhogX%grid==0){status=IDLE;}
            break;
          case GO_DOWN1:
            groundhog = loadImage("img/groundhogDown.png");
            soilY+=groundhogSpeed;
            cabbageY-=groundhogSpeed;
            soldierLevel-=groundhogSpeed;
            if (soilY%grid==0){status=IDLE;}
            break;
          case GO_DOWN2:
            groundhogY+=groundhogSpeed;
            groundhog = loadImage("img/groundhogDown.png");
            if (groundhogY%grid==0){status=IDLE;}
            break;
        }
    //cabbage
        if (cabbageImerge == true){
          image(cabbage ,cabbageX,cabbageY);
          if (cabbageY<0){cabbageImerge = false;}
          if (cabbageX < groundhogX+grid && cabbageX+grid > groundhogX &&
              cabbageY < groundhogY+grid && cabbageY+grid > groundhogY){
            lifeScore += 1;
            cabbageImerge = false;
          }
        }else{
            if(soilY%grid==0 && liLevelGround == true){
              cabbageX =(floor(random(8)))*grid;
              cabbageY =(floor(random(6)))*grid;
              cabbageImerge = true;
            }else if(soilY%grid==0 && liLevelGround == false){
              cabbageX =(floor(random(8)))*grid;
              cabbageY =(floor(random(4))+2)*grid;
              cabbageImerge = true;
            } 
         }
    //soilder
        soldierX += soilderXSpeed;
        image(soldier, soldierX, soldierLevel);
        if (soldierX > 640){
          soldierX = -50;
          if(soilY%grid==0 && liLevelGround == true){
          soldierLevel = floor(random(6))*grid;}
          if(soilY%grid==0 && liLevelGround == false){
          soldierLevel = floor(random(4)+2)*grid;}
        }

    //when soldier meet groundhog
    if (isCrack == true){
        if (soldierX < groundhogX+80 && soldierX+80 > groundhogX &&
            soldierLevel < groundhogY+80 && soldierLevel+grid > groundhogY){
         lifeScore -= 1;
         isCrack = false;
        }
     }
    if (isCrack == false){
       groundhogX = grid*4;
       groundhogY = grid;
       soilY = 0;
       soldierX = -50;
       soldierLevel = floor(random(4)+2)*grid;
       cabbageX =(floor(random(8)))*grid;
       cabbageY =(floor(random(4))+2)*grid;
       cabbageImerge = true;
       liLevelGround = false;
       LevelGround = false;
       status=IDLE;
       isCrack = true;
    }

    // Health UI
       if (lifeScore == 0){gameState = GAME_OVER;noTint();}
       for(int i =0; i<=4; i+=1){
         if (lifeScore > i){image(life, heartBorder+(heartInterval)*i,10);}
         }
       if (lifeScore > 5){lifeScore = 5;}

    break;

    case GAME_OVER: // Gameover Screen
    noTint();
    isCrack = true;
    image(gameover, 0, 0);
    
    if(START_BUTTON_X + START_BUTTON_W > mouseX
      && START_BUTTON_X < mouseX
      && START_BUTTON_Y + START_BUTTON_H > mouseY
      && START_BUTTON_Y < mouseY) {
      image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
      if(mousePressed){
       //initialize game
       lifeScore = 2;
       groundhogX = grid*4;
       groundhogY = grid;
       soilY = 0;
       soldierX = -50;
       soldierLevel = floor(random(4)+2)*grid;
       cabbageX =(floor(random(8)))*grid;
       cabbageY =(floor(random(4))+2)*grid;
       cabbageImerge = true;
       liLevelGround = false;
       LevelGround = false;
       status=IDLE;
       gameState = GAME_RUN;
      }
    }else{
      image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
    }
    break;
  }

    // DO NOT REMOVE OR EDIT THE FOLLOWING 3 LINES
    if (debugMode) {
        popMatrix();
    }
}

void keyPressed(){
  // Add your moving input code here
  if (key == CODED) {
    switch (keyCode) {
      case DOWN:
        if (LevelGround == false && moving == false){
          status=GO_DOWN1;moving = true;}
        if (groundhogY < height-grid &&LevelGround == true && moving == false){
          status=GO_DOWN2;;moving = true;}
        break;
      case LEFT:
        if (groundhogX > 0 && moving == false){
          status=GO_LEFT;;moving = true;}
        break;
      case RIGHT:
        if (groundhogX < width-grid && moving == false){
          status=GO_RIGHT;;moving = true;}
        break;
    }
  }
  // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 50;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 50;
      break;

      case 'a':
      if(lifeScore > 0) lifeScore --;
      break;

      case 'd':
      if(playerHealth < 5) lifeScore ++;
      break;
    }
}

void keyReleased(){
}
