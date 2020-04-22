final int GAME_START = 0, LIFE_1 = 1, LIFE_2 = 2, LIFE_3 = 3, LIFE_4 = 4, LIFE_5 = 5, GAME_OVER = 4, GAME_WIN = 5;
int gameState = GAME_START;

final int GH_IDLE_STATE = 5, GH_DOWN_STATE = 6, GH_LEFT_STATE = 7, GH_RIGHT_STATE = 8;
int keyState = GH_IDLE_STATE;

boolean moving = true;

final int GRASS_HEIGHT = 15;
final int START_BUTTON_W = 144;
final int START_BUTTON_H = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

final int lifeX = 70;
int grid = 80;
int gridX = 80;
int gridY = 80;

int soilStart = grid*2;
int soilLevel1 = soilStart + grid*4;
int soilLevel2 = soilLevel1 + grid*4;
int soilLevel3 = soilLevel2 + grid*4;
int soilLevel4 = soilLevel3 + grid*4;
int soilLevel5 = soilLevel4 + grid*4;
int soilEnd = soilLevel5 + grid*4;


int skyToGround  = grid*2; // sky to ground distancedistance
int soldierX;
int groundhogIdleImgX, groundhogIdleImgY;
int groundhogSpeed = 80/16;  //framerate 60 to framerate 15

float soldierY = grid * floor(random (2, 6));  //random place
float cabbageX = grid * floor(random (0, 8)); 
float cabbageY = grid * floor(random (2, 6)); 


PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage bg, soil8x24, soil0, soil1, soil2, soil3, soil4, soil5, life, stone1, stone2;
PImage groundhogIdle, groundhogDown, groundhogLeft, groundhogRight, soldier, cabbage;

// For debug function; DO NOT edit or remove this!
int playerHealth = 0;
float cameraOffsetY = 0;
boolean debugMode = false;

//boolean upPressed = false;
boolean downPressed, leftPressed, rightPressed = false;
boolean noPressed = true;

void setup() {
  frameRate(60);
	size(640, 480, P2D);
	// Enter your setup code here (please put loadImage() here or your game will lag like crazy)
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	soil8x24 = loadImage("img/soil8x24.png");
  soil0 = loadImage("img/soil0.png");
  soil1 = loadImage("img/soil1.png");
  soil2 = loadImage("img/soil2.png");
  soil3 = loadImage("img/soil3.png");
  soil4 = loadImage("img/soil4.png");
  soil5 = loadImage("img/soil5.png");
  life = loadImage("img/life.png");
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");
  
  soldier = loadImage("img/soldier.png");
  cabbage = loadImage("img/cabbage.png");
  
  groundhogIdle = loadImage("img/groundhogIdle.png");
  groundhogDown = loadImage("img/groundhogDown.png");
  groundhogLeft = loadImage("img/groundhogLeft.png");
  groundhogRight = loadImage("img/groundhogRight.png"); 
  
  groundhogIdleImgY = height / 6;
  groundhogIdleImgX = width / 8 - grid;
  
  playerHealth = 2;  //life*2
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
    downPressed = false;
    leftPressed = false;
    rightPressed = false;
		image(title, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = LIFE_2;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}

		break;
    case LIFE_3: // In-Game

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
    rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    //image(soil8x24, 0, 160);

    //soil level 0
    for(int soil0Y = soilStart; soil0Y < soilLevel1; soil0Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil0, soilX, soil0Y);    
      }
    }
    //soil level 1
    for(int soil1Y = soilLevel1; soil1Y < soilLevel2; soil1Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil1, soilX, soil1Y);    
      }
    }
    //soil level 2
    for(int soil2Y = soilLevel2; soil2Y < soilLevel3; soil2Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil2, soilX, soil2Y);    
      }
    }
    //soil level 3
    for(int soil3Y = soilLevel3; soil3Y < soilLevel4; soil3Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil3, soilX, soil3Y);    
      }
    }
    //soil level 4
    for(int soil4Y = soilLevel4; soil4Y < soilLevel5; soil4Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil4, soilX, soil4Y);    
      }
    }
    //soil level 5
    for(int soil5Y = soilLevel5; soil5Y < soilEnd; soil5Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil5, soilX, soil5Y);    
      }
    }
    
     // level 1
     float x3 = 0, y3 = gridY; 
     for(int i=0; i<8; i++){
        x3 = i* grid;
        image(stone1, x3, y3 + grid);
        y3 += grid;
     }   
    
     // level 3 & 4 stones
     for(int y2 = soilLevel2; y2 < soilLevel4; y2 += grid){
        for(int x2 = 0; x2 < grid*8; x2 += grid){
  
          if(x2 == grid || x2 == grid*2 || x2 == grid*5 || x2 == grid*6){
             if (y2 == soilLevel2 || y2 == soilLevel2 + grid*3 || y2 == soilLevel3 || y2 == soilLevel3 + grid*3 ){
              image(stone1, x2, y2);
             }
           }
         else if(x2 == 0 || x2 == grid*3 || x2 == grid*4 || x2 == grid*7){
                if(y2 == soilLevel2 + grid || y2 == soilLevel2 + grid*2 || y2 == soilLevel3 + grid || y2 == soilLevel3 + grid*2 ){
                image(stone1, x2, y2);
                }
           } 
        }
     }
     
     // level4 & 5 stones
     for(int y2 = soilLevel4; y2 < soilEnd; y2 += grid){
        for(int x2 = 0; x2 < grid*8; x2 += grid){
  
          if(x2 == grid || x2 == grid*2 || x2 == grid*4 || x2 == grid*5 || x2 == grid*7){
             if (y2 == soilLevel4 || y2 == soilLevel4 + grid*3 || y2 == soilLevel4 + grid*6 ){
              image(stone1, x2, y2);
               if(x2 == grid*2|| x2 == grid*5 ){
                image(stone2, x2, y2);
               }
             }
           }
          if(x2 == 0 || x2 == grid || x2 == grid*3 || x2 == grid*4 || x2 == grid*6 || x2 == grid*7){
             if (y2 == soilLevel4 + grid || y2 == soilLevel4 + grid*4 || y2 == soilLevel4 + grid*7 ){
              image(stone1, x2, y2);
               if(x2 == grid || x2 == grid*4 || x2 == grid*7 ){
                image(stone2, x2, y2);
               }
             }
           }
          if(x2 == 0 || x2 == grid*2 || x2 == grid*3 || x2 == grid*5 || x2 == grid*6){
             if (y2 == soilLevel4 + grid*2 || y2 == soilLevel4 + grid*5){
              image(stone1, x2, y2);
               if(x2 == 0 || x2 == grid*3 || x2 == grid*6 ){
                image(stone2, x2, y2);
               }
             }
           }
        }
     }
    
    image(cabbage, cabbageX, cabbageY);
    
    image(soldier, soldierX, soldierY);
    soldierX = soldierX + 4; //set the soldier moving speeds
    
    //set soldier moving cycle
    if(soldierX>640){
     soldierX = -80; //emerge from the left
     }       
    
    //add the life and cabbage disappear 
    if(groundhogIdleImgX + grid*4 +80 > cabbageX && groundhogIdleImgX + grid*4 < cabbageX + 80){
      if(groundhogIdleImgY + 80 > cabbageY && groundhogIdleImgY < cabbageY + 80){
         cabbageX = -80;
         playerHealth += 1;
         gameState = LIFE_4; 
       }
     }
     
    //when soldier meet the groundhog
     if(groundhogIdleImgX + grid*4 + 80 >= soldierX && groundhogIdleImgX + grid*4 <= soldierX + 80){
       if(groundhogIdleImgY + 80 > soldierY && groundhogIdleImgY < soldierY + 80){ 
          keyState = GH_IDLE_STATE;
          groundhogIdleImgY = height / 6;
          groundhogIdleImgX = width / 8 - grid;
          playerHealth -= 1;
          gameState = LIFE_2;
          noPressed = true;
       }
     }
    
    switch (keyState){      
      case GH_IDLE_STATE:
           if(noPressed == true){
           image(groundhogIdle, groundhogIdleImgX + grid*4, groundhogIdleImgY);  //place groundhog at the 5th grid
           }
           
      break;
      case GH_DOWN_STATE:
           if(groundhogIdleImgX %80 == 0){  
             noPressed = false;
             leftPressed = false;
             rightPressed = false;
             image(groundhogDown, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgY += groundhogSpeed;
             
           if(groundhogIdleImgY %80 == 0){
             downPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
         
      break;
      case GH_LEFT_STATE: 
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             rightPressed = false;
             downPressed = false;
             image(groundhogLeft, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX -= groundhogSpeed;
       
           if(groundhogIdleImgX %80 == 0){
             leftPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}

      break;  
      case GH_RIGHT_STATE:
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             leftPressed = false;
             downPressed = false;
             image(groundhogRight, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX += groundhogSpeed;
         
           if(groundhogIdleImgX %80 == 0){
             rightPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
       break;
    }
       
    // Player

    // Health UI
    for(int i = 10; i < lifeX * playerHealth; i += lifeX){
    image(life, i, 10);
    }
    
    break;
		case LIFE_2: // In-Game

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
		rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
		//image(soil8x24, 0, 160);

    //soil level 0
    for(int soil0Y = soilStart; soil0Y < soilLevel1; soil0Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil0, soilX, soil0Y);    
      }
    }
    //soil level 1
    for(int soil1Y = soilLevel1; soil1Y < soilLevel2; soil1Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil1, soilX, soil1Y);    
      }
    }
    //soil level 2
    for(int soil2Y = soilLevel2; soil2Y < soilLevel3; soil2Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil2, soilX, soil2Y);    
      }
    }
    //soil level 3
    for(int soil3Y = soilLevel3; soil3Y < soilLevel4; soil3Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil3, soilX, soil3Y);    
      }
    }
    //soil level 4
    for(int soil4Y = soilLevel4; soil4Y < soilLevel5; soil4Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil4, soilX, soil4Y);    
      }
    }
    //soil level 5
    for(int soil5Y = soilLevel5; soil5Y < soilEnd; soil5Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil5, soilX, soil5Y);    
      }
    }
    
     // level 1
     float x = 0, y = gridY; 
     for(int i=0; i<8; i++){
        x = i* grid;
        image(stone1, x, y + grid);
        y += grid;
     }   
    
     // level 3 & 4 stones
     for(int y2 = soilLevel2; y2 < soilLevel4; y2 += grid){
        for(int x2 = 0; x2 < grid*8; x2 += grid){
  
          if(x2 == grid || x2 == grid*2 || x2 == grid*5 || x2 == grid*6){
             if (y2 == soilLevel2 || y2 == soilLevel2 + grid*3 || y2 == soilLevel3 || y2 == soilLevel3 + grid*3 ){
              image(stone1, x2, y2);
             }
           }
         else if(x2 == 0 || x2 == grid*3 || x2 == grid*4 || x2 == grid*7){
                if(y2 == soilLevel2 + grid || y2 == soilLevel2 + grid*2 || y2 == soilLevel3 + grid || y2 == soilLevel3 + grid*2 ){
                image(stone1, x2, y2);
                }
           } 
        }
     }
     
     // level4 & 5 stones
     for(int y2 = soilLevel4; y2 < soilEnd; y2 += grid){
        for(int x2 = 0; x2 < grid*8; x2 += grid){
  
          if(x2 == grid || x2 == grid*2 || x2 == grid*4 || x2 == grid*5 || x2 == grid*7){
             if (y2 == soilLevel4 || y2 == soilLevel4 + grid*3 || y2 == soilLevel4 + grid*6 ){
              image(stone1, x2, y2);
               if(x2 == grid*2|| x2 == grid*5 ){
                image(stone2, x2, y2);
               }
             }
           }
          if(x2 == 0 || x2 == grid || x2 == grid*3 || x2 == grid*4 || x2 == grid*6 || x2 == grid*7){
             if (y2 == soilLevel4 + grid || y2 == soilLevel4 + grid*4 || y2 == soilLevel4 + grid*7 ){
              image(stone1, x2, y2);
               if(x2 == grid || x2 == grid*4 || x2 == grid*7 ){
                image(stone2, x2, y2);
               }
             }
           }
          if(x2 == 0 || x2 == grid*2 || x2 == grid*3 || x2 == grid*5 || x2 == grid*6){
             if (y2 == soilLevel4 + grid*2 || y2 == soilLevel4 + grid*5){
              image(stone1, x2, y2);
               if(x2 == 0 || x2 == grid*3 || x2 == grid*6 ){
                image(stone2, x2, y2);
               }
             }
           }
        }
     }
            
    image(cabbage, cabbageX, cabbageY);
    
    image(soldier, soldierX, soldierY);
    soldierX = soldierX + 4; //set the soldier moving speeds
    
    //set soldier moving cycle
    if(soldierX>640){
     soldierX = -80; //emerge from the left
     }   
    
    //add the life and cabbage disappear 
    if(groundhogIdleImgX + grid*4 +80 > cabbageX && groundhogIdleImgX + grid*4 < cabbageX + 80){
      if(groundhogIdleImgY + 80 > cabbageY && groundhogIdleImgY < cabbageY + 80){
         cabbageX = -80;
         playerHealth += 1;
         gameState = LIFE_3; 
       }
     }
     
    //when soldier meet the groundhog
     if(groundhogIdleImgX + grid*4 + 80 >= soldierX && groundhogIdleImgX + grid*4 <= soldierX + 80){
       if(groundhogIdleImgY + 80 > soldierY && groundhogIdleImgY < soldierY + 80){ 
          keyState = GH_IDLE_STATE;
          groundhogIdleImgY = height / 6;
          groundhogIdleImgX = width / 8 - grid;
          playerHealth -= 1;
          gameState = LIFE_1;
          noPressed = true;
       }
     }
    
    switch (keyState){      
      case GH_IDLE_STATE:
           if(noPressed == true){
           image(groundhogIdle, groundhogIdleImgX + grid*4, groundhogIdleImgY);  //place groundhog at the 5th grid
           }
           
      break;
      case GH_DOWN_STATE:
           if(groundhogIdleImgX %80 == 0){  
             noPressed = false;
             leftPressed = false;
             rightPressed = false;
             image(groundhogDown, groundhogIdleImgX + grid*4, groundhogIdleImgY);  
             
             //the coding here cannot work
               //if(moving == false){
               //  groundhogIdleImgY += groundhogSpeed; 
               //   if(groundhogIdleImgY %80 == 0){
               //      downPressed = false;
               //      noPressed = true;
               //      keyState = GH_IDLE_STATE;
               //    } 
               // }  
                       
             if(moving == true){
             soilStart -= groundhogSpeed;
             soilLevel1 -= groundhogSpeed;
             soilLevel2 -= groundhogSpeed;
             soilLevel3 -= groundhogSpeed;
             soilLevel4 -= groundhogSpeed;
             soilLevel5 -= groundhogSpeed;
             soilEnd -= groundhogSpeed;
             soldierY -= groundhogSpeed;
             cabbageY -= groundhogSpeed;
             gridY -= groundhogSpeed;
              if(groundhogIdleImgY >= soilLevel5-grid){
               moving = false;
              }
            }

          if(soilStart %80 == 0){
             downPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }    
         }
         
      break;
      case GH_LEFT_STATE: 
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             rightPressed = false;
             downPressed = false;
             image(groundhogLeft, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX -= groundhogSpeed;
       
           if(groundhogIdleImgX %80 == 0){
             leftPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}

      break;  
      case GH_RIGHT_STATE:
           if(groundhogIdleImgY %80 == 0){ 
             noPressed = false;
             leftPressed = false;
             downPressed = false;
             image(groundhogRight, groundhogIdleImgX + grid*4, groundhogIdleImgY);
             groundhogIdleImgX += groundhogSpeed;
         
           if(groundhogIdleImgX %80 == 0){
             rightPressed = false;
             noPressed = true;
             keyState = GH_IDLE_STATE;
           }}
       break;
    }
       
		// Player

		// Health UI
    for(int i = 10; i < lifeX * playerHealth; i += lifeX){
    image(life, i, 10);
    }
    
		break;
    case LIFE_1:
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
    rect(0, 160 - GRASS_HEIGHT, width, GRASS_HEIGHT);

    // Soil - REPLACE THIS PART WITH YOUR LOOP CODE!
    //image(soil8x24, 0, 160);

    //soil level 0
    for(int soil0Y = soilStart; soil0Y < soilLevel1; soil0Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil0, soilX, soil0Y);    
      }
    }
    //soil level 1
    for(int soil1Y = soilLevel1; soil1Y < soilLevel2; soil1Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil1, soilX, soil1Y);    
      }
    }
    //soil level 2
    for(int soil2Y = soilLevel2; soil2Y < soilLevel3; soil2Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil2, soilX, soil2Y);    
      }
    }
    //soil level 3
    for(int soil3Y = soilLevel3; soil3Y < soilLevel4; soil3Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil3, soilX, soil3Y);    
      }
    }
    //soil level 4
    for(int soil4Y = soilLevel4; soil4Y < soilLevel5; soil4Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil4, soilX, soil4Y);    
      }
    }
    //soil level 5
    for(int soil5Y = soilLevel5; soil5Y < soilEnd; soil5Y += grid){
      for(int soilX = 0; soilX < grid*8; soilX += grid){
      image(soil5, soilX, soil5Y);    
      }
    }
    
     // level 1
     float x1 = 0, y1 = gridY; 
     for(int i=0; i<8; i++){
        x1 = i* grid;
        image(stone1, x1, y1 + grid);
        y1 += grid;
     }   
    
     // level 3 & 4 stones
     for(int y2 = soilLevel2; y2 < soilLevel4; y2 += grid){
        for(int x2 = 0; x2 < grid*8; x2 += grid){
  
          if(x2 == grid || x2 == grid*2 || x2 == grid*5 || x2 == grid*6){
             if (y2 == soilLevel2 || y2 == soilLevel2 + grid*3 || y2 == soilLevel3 || y2 == soilLevel3 + grid*3 ){
              image(stone1, x2, y2);
             }
           }
         else if(x2 == 0 || x2 == grid*3 || x2 == grid*4 || x2 == grid*7){
                if(y2 == soilLevel2 + grid || y2 == soilLevel2 + grid*2 || y2 == soilLevel3 + grid || y2 == soilLevel3 + grid*2 ){
                image(stone1, x2, y2);
                }
           } 
        }
     }
     
     // level4 & 5 stones
     for(int y2 = soilLevel4; y2 < soilEnd; y2 += grid){
        for(int x2 = 0; x2 < grid*8; x2 += grid){
  
          if(x2 == grid || x2 == grid*2 || x2 == grid*4 || x2 == grid*5 || x2 == grid*7){
             if (y2 == soilLevel4 || y2 == soilLevel4 + grid*3 || y2 == soilLevel4 + grid*6 ){
              image(stone1, x2, y2);
               if(x2 == grid*2|| x2 == grid*5 ){
                image(stone2, x2, y2);
               }
             }
           }
          if(x2 == 0 || x2 == grid || x2 == grid*3 || x2 == grid*4 || x2 == grid*6 || x2 == grid*7){
             if (y2 == soilLevel4 + grid || y2 == soilLevel4 + grid*4 || y2 == soilLevel4 + grid*7 ){
              image(stone1, x2, y2);
               if(x2 == grid || x2 == grid*4 || x2 == grid*7 ){
                image(stone2, x2, y2);
               }
             }
           }
          if(x2 == 0 || x2 == grid*2 || x2 == grid*3 || x2 == grid*5 || x2 == grid*6){
             if (y2 == soilLevel4 + grid*2 || y2 == soilLevel4 + grid*5){
              image(stone1, x2, y2);
               if(x2 == 0 || x2 == grid*3 || x2 == grid*6 ){
                image(stone2, x2, y2);
               }
             }
           }
        }
     }
    
    image(cabbage, cabbageX, cabbageY);
    
    image(soldier, soldierX, soldierY);
    soldierX = soldierX + 4; //set the soldier moving speeds
    
    //set soldier moving cycle
    if(soldierX>640){
     soldierX = -80; //emerge from the left
     }   
  
      //add the life and cabbage disappear 
      if(groundhogIdleImgX + grid*4 +80 > cabbageX && groundhogIdleImgX + grid*4 < cabbageX + 80){
        if(groundhogIdleImgY + 80 > cabbageY && groundhogIdleImgY < cabbageY + 80){
           cabbageX = -80;
           playerHealth += 1;
           gameState = LIFE_2; 
         }
       }
       
      //when soldier meet the groundhog
       if(groundhogIdleImgX + grid*4 + 80 >= soldierX && groundhogIdleImgX + grid*4 <= soldierX + 80){
         if(groundhogIdleImgY + 80 > soldierY && groundhogIdleImgY < soldierY + 80){ 
            keyState = GH_IDLE_STATE;
            groundhogIdleImgY = height / 6;
            groundhogIdleImgX = width / 8 - grid;
            gameState = GAME_OVER;       
            noPressed = true;
         }
       }
      
       switch (keyState){      
        case GH_IDLE_STATE:
             if(noPressed == true){
             image(groundhogIdle, groundhogIdleImgX + grid*4, groundhogIdleImgY);  //place groundhog at the 5th grid
             }
             
        break;
        case GH_DOWN_STATE:
             if(groundhogIdleImgX %80 == 0){  
               noPressed = false;
               leftPressed = false;
               rightPressed = false;
               image(groundhogDown, groundhogIdleImgX + grid*4, groundhogIdleImgY);
               groundhogIdleImgY += groundhogSpeed;
             
             if(groundhogIdleImgY %80 == 0){
               downPressed = false;
               noPressed = true;
               keyState = GH_IDLE_STATE;
             }}
           
        break;
        case GH_LEFT_STATE: 
             if(groundhogIdleImgY %80 == 0){ 
               noPressed = false;
               rightPressed = false;
               downPressed = false;
               image(groundhogLeft, groundhogIdleImgX + grid*4, groundhogIdleImgY);
               groundhogIdleImgX -= groundhogSpeed;
             
             if(groundhogIdleImgX %80 == 0){
               leftPressed = false;
               noPressed = true;
               keyState = GH_IDLE_STATE;
             }}
  
        break;  
        case GH_RIGHT_STATE:
             if(groundhogIdleImgY %80 == 0){ 
               noPressed = false;
               leftPressed = false;
               downPressed = false;
               image(groundhogRight, groundhogIdleImgX + grid*4, groundhogIdleImgY);
               groundhogIdleImgX += groundhogSpeed;
           
             if(groundhogIdleImgX %80 == 0){
               rightPressed = false;
               noPressed = true;
               keyState = GH_IDLE_STATE;
             }}
         break;
      }

    // Player

    // Health UI
    for(int i = 10; i < lifeX * playerHealth; i += lifeX){
    image(life, i, 10);
    }

    break; 
		case GAME_OVER: // Gameover Screen
    downPressed = false;
    leftPressed = false;
    rightPressed = false;
		image(gameover, 0, 0);

		if(START_BUTTON_X + START_BUTTON_W > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_H > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
         float restartSoldierY = grid * floor(random (2, 6));
         float restartCabbageX = grid * floor(random (1, 8));
         float restartCabbageY = grid * floor(random (2, 6)); 
         soldierY = restartSoldierY;
         cabbageX = restartCabbageX;
         cabbageY = restartCabbageY;
        playerHealth = 2;
				gameState = LIFE_2;
				mousePressed = false;
				// Remember to initialize the game here!
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
  if(key == CODED){
    switch (keyCode){
      //case UP:
      //upPressed = true;
      //  if(upPressed){
      //  groundhogIdleImgY -= grid;
      //  }
      //  //boundary detection
      //  if(groundhogIdleImgY <= grid){
      //  groundhogIdleImgY = grid;
      //  }
      //break;
      case DOWN:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){    
        //boundary detection
        if(groundhogIdleImgY <= height - grid*2){
          downPressed = true;
          keyState = GH_DOWN_STATE;
        }
      }
      break;
      case LEFT:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        //boundary detection
        if(groundhogIdleImgX + grid*3 >= 0){
          leftPressed = true;
          keyState = GH_LEFT_STATE;
        }   
      }
      break;
      case RIGHT:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        //boundary detection
        if(groundhogIdleImgX + grid*6 <= width){
          rightPressed = true;
          keyState = GH_RIGHT_STATE;
        }   
      }
      break;   
    }
  }
 
    // DO NOT REMOVE OR EDIT THE FOLLOWING SWITCH/CASES
    switch(key){
      case 'w':
      debugMode = true;
      cameraOffsetY += 25;
      break;

      case 's':
      debugMode = true;
      cameraOffsetY -= 25;
      break;

      case 'a':
      if(playerHealth > 0) playerHealth --;
      break;

      case 'd':
      if(playerHealth < 5) playerHealth ++;
      break;
    }
}

void keyReleased(){  
    if(key == CODED){
    switch(keyCode){
      case DOWN:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        if(downPressed == false){ 
        keyState = GH_IDLE_STATE;
        }
      }
      break;
      case LEFT:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        if(leftPressed == false){ 
        keyState = GH_IDLE_STATE;
        }
      }
      break;
      case RIGHT:
      if(groundhogIdleImgX %80 == 0 && groundhogIdleImgY %80 == 0){
        if(rightPressed == false){ 
        keyState = GH_IDLE_STATE;
        }
      }
      break;
    }
  }
}
