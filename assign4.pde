PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogLeft, groundhogRight, groundhogDown;
PImage bg, life, cabbage, stone1, stone2, soilEmpty;
PImage soldier;
PImage soil0, soil1, soil2, soil3, soil4, soil5;
PImage[][] soils, stones;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;
int YAxis =0;
final int YArea1 =1, YArea2 =2;

final int GRASS_HEIGHT = 15;
final int SOIL_COL_COUNT = 8;
final int SOIL_ROW_COUNT = 24;
final int SOIL_SIZE = 80;
final int GRID = 80;
final int CABBAGE_Q =6;
final int SOLDIER_Q =6;

int[][] soilHealth;

final int START_BUTTON_WIDTH = 144;
final int START_BUTTON_HEIGHT = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

float [] cabbageX, cabbageY, soldierX, soldierY;
float soldierSpeed = 2f;

float playerX, playerY;
int playerCol, playerRow;
final float PLAYER_INIT_X = 4 * SOIL_SIZE;
final float PLAYER_INIT_Y = - SOIL_SIZE;
boolean leftState = false;
boolean rightState = false;
boolean downState = false;
int playerHealth = 2;
final int PLAYER_MAX_HEALTH = 5;
int playerMoveDirection = 0;
int playerMoveTimer = 0;
int playerMoveDuration = 15;

int lifeImageX;
int lifeImageY;
int soldier1X, soldier2X, soldier3X, soldier4X, soldier5X, soldier6X;
int soldier1Y, soldier2Y, soldier3Y, soldier4Y, soldier5Y, soldier6Y;
int speedX= 6;

boolean demoMode = false;

int [] soilEmptyX, soilEmptyY;
int [][] soilEmpties ;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	groundhogIdle = loadImage("img/groundhogIdle.png");
	groundhogLeft = loadImage("img/groundhogLeft.png");
	groundhogRight = loadImage("img/groundhogRight.png");
	groundhogDown = loadImage("img/groundhogDown.png");
	life = loadImage("img/life.png");
	soldier = loadImage("img/soldier.png");
	cabbage = loadImage("img/cabbage.png");

	soilEmpty = loadImage("img/soils/soilEmpty.png");

	// Load soil images used in assign3 if you don't plan to finish requirement #6
	soil0 = loadImage("img/soil0.png");
	soil1 = loadImage("img/soil1.png");
	soil2 = loadImage("img/soil2.png");
	soil3 = loadImage("img/soil3.png");
	soil4 = loadImage("img/soil4.png");
	soil5 = loadImage("img/soil5.png");

	// Load PImage[][] soils
	soils = new PImage[6][5];
	for(int i = 0; i < soils.length; i++){
		for(int j = 0; j < soils[i].length; j++){
			soils[i][j] = loadImage("img/soils/soil" + i + "/soil" + i + "_" + j + ".png");
		}
	}
  
	// Load PImage[][] stones
	stones = new PImage[2][5];
	for(int i = 0; i < stones.length; i++){
		for(int j = 0; j < stones[i].length; j++){
			stones[i][j] = loadImage("img/stones/stone" + i + "/stone" + i + "_" + j + ".png");
		}
	}

	// Initialize player
	playerX = PLAYER_INIT_X;
	playerY = PLAYER_INIT_Y;
	playerCol = (int) (playerX / SOIL_SIZE);
	playerRow = (int) (playerY / SOIL_SIZE);
	playerMoveTimer = 0;
	playerHealth = 2;

  lifeImageX = 10;
  lifeImageY = 10;

	// Initialize soilHealth
	soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
	for(int i = 0; i < soilHealth.length; i++){
		for (int j = 0; j < soilHealth[i].length; j++) {
			// 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
			soilHealth[i][j] = 15;
		}
	}

	// Initialize soidiers and their position
  soldierX = new float [6];
  for(int i=0; i<soldierX.length; i++){
    soldierX[i] = floor(random(8)) *SOIL_SIZE;
  }
  soldier1X = floor(random(0,8))  *SOIL_SIZE;
  soldier2X = floor(random(0,8))  *SOIL_SIZE;
  soldier3X = floor(random(0,8))  *SOIL_SIZE;
  soldier4X = floor(random(0,8))  *SOIL_SIZE;
  soldier5X = floor(random(0,8))  *SOIL_SIZE;
  soldier6X = floor(random(0,8))  *SOIL_SIZE;
  
  soldier1Y = floor(random(0,4))  *SOIL_SIZE;  
  soldier2Y = floor(random(4,8))  *SOIL_SIZE;
  soldier3Y = floor(random(8,12)) *SOIL_SIZE;  
  soldier4Y = floor(random(12,16))*SOIL_SIZE;
  soldier5Y = floor(random(16,20))*SOIL_SIZE;  
  soldier6Y = floor(random(20,24))*SOIL_SIZE;
  
  //soldierX = new float [SOLDIER_Q];
  //soldierY = new float [SOLDIER_Q];
  
  //for(int i=0; i< soldierX.length; i++){
  //  soldierX[i] = floor(random(8)) *SOIL_SIZE;
  //}
  //for(int i=0; i< soldierY.length; i++){
  //  soldierY[i] = floor(random(0,4)) *SOIL_SIZE;
  //  soldierY[i] = floor(random(4,8)) *SOIL_SIZE;
  //  soldierY[i] = floor(random(8,12)) *SOIL_SIZE;
  //  soldierY[i] = floor(random(12,16)) *SOIL_SIZE;
  //  soldierY[i] = floor(random(16,20)) *SOIL_SIZE;
  //  soldierY[i] = floor(random(20,24)) *SOIL_SIZE;
  //  //soldierY[i] = floor(random(24))*GRID;
  //}

	// Initialize cabbages and their position
  cabbageX = new float [CABBAGE_Q];
  cabbageY = new float [CABBAGE_Q];
  
  for(int i=0; i< CABBAGE_Q; i++){
    for(int j=0; j<= 1+floor(random(1)); j++){ // 1 layer get 1 cabbage
      int pick = (int)random(4) + i*4; // every kind of soil(4 layers = 1 area) get 1 cabbage
      cabbageX [i] = (int) random(0,8)*GRID;
      cabbageY [i] = pick*GRID;
    }  
  }
  
  
  // soilEmpty

  //soilEmptyX = new int [2];
  //for(int i=0; i< soilEmptyX.length; i++){
  //  i = (int) random(2);
  //  soilEmptyX[i] = floor(random(0,8));
  //}
    
  //soilEmptyY = new int [24];
  //for(int i=0; i< soilEmptyY.length; i++){
  //  soilEmptyY[i] = floor(random(1,24)); 
  //}
  
  //for(int i=0; i<8; i++){
  //int pick = 1+(int)random(2); // randomly get 1 or 2
  
  //  for(int j=0; j<pick; j++){ // following the picked number, to set X and Y
  //    soilEmptyX[j] = floor(random(8));
  //    soilEmptyY[j] = floor(random(1,24));      
  //  }
  //}
  
  
  // soil empty
 
  for(int x=1; x <= 1+ floor(random(0,2)); x++){ // 1 layer get 1-2 empty     
    for(int y=1; y<24 ;y++){
      int pick = floor(random(0,8)); // the position of the empty
      soilHealth[pick][y] =0;
      
      //soilEmptyX[pick] = pick;
      //soilEmptyY[y] = y;
      //image(soilEmpty, pick*GRID,y*GRID);
    }
  }

}

void draw() {

	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

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

	    // CAREFUL!
	    // Because of how this translate value is calculated, the Y value of the ground level is actually 0
		pushMatrix();
		translate(0, max(SOIL_SIZE * -18, SOIL_SIZE * 1 - playerY));

		// Ground

		fill(124, 204, 25);
		noStroke();
		rect(0, -GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil

		for(int i = 0; i < soilHealth.length; i++){
			for (int j = 0; j < soilHealth[i].length; j++) {

				// Change this part to show soil and stone images based on soilHealth value
				// NOTE: To avoid errors on webpage, you can either use floor(j / 4) or (int)(j / 4) to make sure it's an integer.
				int areaIndex = floor(j / 4);
				image(soils[areaIndex][4], i * SOIL_SIZE, j * SOIL_SIZE);
      }
		}

    // Stone    
    // layer 1-8
    for(int i=0; i< soilHealth.length; i++){      
      image(stones[0][4], i*GRID, i*GRID);
      soilHealth[i][i] = 30;
    }
    //for(int m=0; m< soilEmptyX.length; m++){
    //  for(int n=0; n< soilEmptyY.length; n++){
    //    m = floor(random(8));
    //    n = floor(random(1,24));
    //    image(soilEmpty, m*GRID, n*GRID);
    //  }
    //}
    
    //for(int i=0; i< soilEmptyX.length; i++){
    //  for(int j=0; j< 24; j++){
    //  image(soilEmpty, soilEmptyX[i]*GRID, soilEmptyY[j]*GRID);
    //  soilHealth[i][j] =0;
    //  }
    //}   
   
     
    // layer 9-16
    for(int i=0; i< soilHealth.length ; i++){
      for(int j=8; j<16 && j>7; j++){
        if(i%4 ==1 || i%4 ==2){
          if(j%4 ==0 || j%4 ==3){
          image(stones[0][4], i*GRID, j*GRID);
          soilHealth[i][j] =30;
          }
        }
        if(i%4 ==0 || i%4 == 3){
          if(j%4 ==1 || j%4 ==2){
          image(stones[0][4], i*GRID, j*GRID);
          soilHealth[i][j] =30;
          }
        }        
      }
    }
    
    // layer 17-24
    for(int i=0; i< soilHealth.length; i++){
      for(int j=16; j>15 && j<soilHealth[i].length; j++){
        if(i%3 !=0){
          if(j%3 ==1){
          image(stones[0][4],i*GRID, j*GRID);
          soilHealth[i][j] =30;
          }
        }
        if(i%3 !=2){
          if(j%3==2){
          image(stones[0][4], i*GRID, j*GRID);
          soilHealth[i][j] =30;
          }
        }
        if(i%3 !=1){
          if(j%3 ==0){
          image(stones[0][4], i*GRID, j*GRID);
          soilHealth[i][j] =30;
          }
        }
        // Stone2
        if(i%3 ==2){
          if(j%3 ==1){
            image(stones[1][4], i*GRID, j*GRID);
            soilHealth[i][j] =45;
          }
        }
        if(i%3 ==1){
          if(j%3 ==2){
          image(stones[1][4], i*GRID, j*GRID);
          soilHealth[i][j] =45;
          }
        }
        if(i%3 ==0){
          if(j%3 ==0){
          image(stones[1][4], i*GRID, j*GRID);
          soilHealth[i][j] =45;
          }
        }
      }
    }
    
    // Empty soil    
    for(int y=1; y<24 ;y++){
      for(int x=0; x<= 1+(int)random(2); x++){
        int pick = floor(random(0,8));
     
        //soilHealth[pick][y] =0;
        image(soilEmpty, pick*GRID, y*GRID);
      }  
    }
      
		// Cabbages
		// > Remember to check if playerHealth is smaller than PLAYER_MAX_HEALTH!
    for(int i=0; i< CABBAGE_Q; i++){
      image(cabbage, cabbageX[i], cabbageY[i]);
    }
    
    // AABB hit
    for(int i=0; i< cabbageX.length; i++){
      if(playerHealth>0 && playerHealth< PLAYER_MAX_HEALTH){
        if(cabbageX[i] < playerX+GRID && cabbageX[i]+GRID > playerX && cabbageY[i] < playerY+GRID && cabbageY[i]+GRID > playerY){
          cabbageX[i] = -100;
          cabbageY[i] = -100;
          playerHealth ++;
          if(playerHealth >5){
            playerHealth = 5;
          }
        }
      }
    }

    
    // Soldier
    image(soldier, soldier1X, soldier1Y);
    image(soldier, soldier2X, soldier2Y);
    image(soldier, soldier3X, soldier3Y);
    image(soldier, soldier4X, soldier4Y);
    image(soldier, soldier5X, soldier5Y);
    image(soldier, soldier6X, soldier6Y);
    soldier1X +=speedX;
    soldier2X +=speedX;
    soldier3X +=speedX;
    soldier4X +=speedX;
    soldier5X +=speedX;
    soldier6X +=speedX;
    if(soldier1X > width){soldier1X = -100;}
    if(soldier2X > width){soldier2X = -100;}
    if(soldier3X > width){soldier3X = -100;}
    if(soldier4X > width){soldier4X = -100;}
    if(soldier5X > width){soldier5X = -100;}
    if(soldier6X > width){soldier6X = -100;}
    
    if(soldier1X < playerX+80 && soldier1X+80 > playerX && soldier1Y < playerY+80 && soldier1Y+80 > playerY){
      playerX = PLAYER_INIT_X;
      playerY = PLAYER_INIT_Y;
      playerHealth --;

      playerCol = (int) (playerX / SOIL_SIZE);
      playerRow = (int) (playerY / SOIL_SIZE);
      playerMoveTimer = 0;
    }
    if(soldier2X < playerX+80 && soldier2X+80 > playerX && soldier2Y < playerY+80 && soldier2Y+80 > playerY){
      playerX = PLAYER_INIT_X;
      playerY = PLAYER_INIT_Y;
      playerHealth --;
      playerCol = (int) (playerX / SOIL_SIZE);
      playerRow = (int) (playerY / SOIL_SIZE);
      playerMoveTimer = 0;
    }
    if(soldier3X < playerX+80 && soldier3X+80 > playerX && soldier3Y < playerY+80 && soldier3Y+80 > playerY){
      playerX = PLAYER_INIT_X;
      playerY = PLAYER_INIT_Y;
      playerHealth --;
      playerCol = (int) (playerX / SOIL_SIZE);
      playerRow = (int) (playerY / SOIL_SIZE);
      playerMoveTimer = 0;
    }
    if(soldier4X < playerX+80 && soldier4X+80 > playerX && soldier4Y < playerY+80 && soldier4Y+80 > playerY){
      playerX = PLAYER_INIT_X;
      playerY = PLAYER_INIT_Y;
      playerHealth --;
      playerCol = (int) (playerX / SOIL_SIZE);
      playerRow = (int) (playerY / SOIL_SIZE);
      playerMoveTimer = 0;
    }
    if(soldier5X < playerX+80 && soldier5X+80 > playerX && soldier5Y < playerY+80 && soldier5Y+80 > playerY){
      playerX = PLAYER_INIT_X;
      playerY = PLAYER_INIT_Y;
      playerHealth --;
      playerCol = (int) (playerX / SOIL_SIZE);
      playerRow = (int) (playerY / SOIL_SIZE);
      playerMoveTimer = 0;
    }
    if(soldier6X < playerX+80 && soldier6X+80 > playerX && soldier6Y < playerY+80 && soldier6Y+80 > playerY){
      playerX = PLAYER_INIT_X;
      playerY = PLAYER_INIT_Y;
      playerHealth --;
      playerCol = (int) (playerX / SOIL_SIZE);
      playerRow = (int) (playerY / SOIL_SIZE);
      playerMoveTimer = 0;
    }
    
    if(playerHealth <= 0){
      gameState = GAME_OVER;
    }
    
    
    //for(int i=0; i< soldierX.length; i++){
    //  for(int j=0; j< soldierY.length; j++){
    //    image(soldier, soldierX[i], soldierY[j]);
        
    //    //if(j>=0 && j<4){
    //    //  image(soldier, soldierX[i], soldierY[j]);
    //    //}
    //    //if(j>=4 && j<8) {image(soldier, soldierX[i], soldierY[j]);}
    //    println(soldierX[i]+","+soldierY[j] );
    //  }
    //}

		// Groundhog

		PImage groundhogDisplay = groundhogIdle;

		// If player is not moving, we have to decide what player has to do next
		if(playerMoveTimer == 0){

			// HINT:
			// You can use playerCol and playerRow to get which soil player is currently on

			// Check if "player is NOT at the bottom AND the soil under the player is empty"
			// > If so, then force moving down by setting playerMoveDirection and playerMoveTimer (see downState part below for example)
			// > Else then determine player's action based on input state

			if(leftState){

				groundhogDisplay = groundhogLeft;

				// Check left boundary
				if(playerCol > 0){

					// HINT:
					// Check if "player is NOT above the ground AND there's soil on the left"
					// > If so, dig it and decrease its health
					// > Else then start moving (set playerMoveDirection and playerMoveTimer)

					playerMoveDirection = LEFT;
					playerMoveTimer = playerMoveDuration;

				}

			}else if(rightState){

				groundhogDisplay = groundhogRight;

				// Check right boundary
				if(playerCol < SOIL_COL_COUNT - 1){

					// HINT:
					// Check if "player is NOT above the ground AND there's soil on the right"
					// > If so, dig it and decrease its health
					// > Else then start moving (set playerMoveDirection and playerMoveTimer)

					playerMoveDirection = RIGHT;
					playerMoveTimer = playerMoveDuration;

				}

			}else if(downState){

				groundhogDisplay = groundhogDown;

				// Check bottom boundary

				// HINT:
				// We have already checked "player is NOT at the bottom AND the soil under the player is empty",
				// and since we can only get here when the above statement is false,
				// we only have to check again if "player is NOT at the bottom" to make sure there won't be out-of-bound exception
				if(playerRow < SOIL_ROW_COUNT - 1){

					// > If so, dig it and decrease its health

					// For requirement #3:
					// Note that player never needs to move down as it will always fall automatically,
					// so the following 2 lines can be removed once you finish requirement #3

					playerMoveDirection = DOWN;
					playerMoveTimer = playerMoveDuration;

				}
			}

		}

		// If player is now moving?
		// (Separated if-else so player can actually move as soon as an action starts)
		// (I don't think you have to change any of these)

		if(playerMoveTimer > 0){

			playerMoveTimer --;
			switch(playerMoveDirection){

				case LEFT:
				groundhogDisplay = groundhogLeft;
				if(playerMoveTimer == 0){
					playerCol--;
					playerX = SOIL_SIZE * playerCol;
				}else{
					playerX = (float(playerMoveTimer) / playerMoveDuration + playerCol - 1) * SOIL_SIZE;
				}
				break;

				case RIGHT:
				groundhogDisplay = groundhogRight;
				if(playerMoveTimer == 0){
					playerCol++;
					playerX = SOIL_SIZE * playerCol;
				}else{
					playerX = (1f - float(playerMoveTimer) / playerMoveDuration + playerCol) * SOIL_SIZE;
				}
				break;

				case DOWN:
				groundhogDisplay = groundhogDown;
				if(playerMoveTimer == 0){
					playerRow++;
					playerY = SOIL_SIZE * playerRow;
				}else{
					playerY = (1f - float(playerMoveTimer) / playerMoveDuration + playerRow) * SOIL_SIZE;
				}
				break;
			}

		}

		image(groundhogDisplay, playerX, playerY);

		// Soldiers
		// > Remember to stop player's moving! (reset playerMoveTimer)
		// > Remember to recalculate playerCol/playerRow when you reset playerX/playerY!
		// > Remember to reset the soil under player's original position!

		// Demo mode: Show the value of soilHealth on each soil
		// (DO NOT CHANGE THE CODE HERE!)

		if(demoMode){	

			fill(255);
			textSize(26);
			textAlign(LEFT, TOP);

			for(int i = 0; i < soilHealth.length; i++){
				for(int j = 0; j < soilHealth[i].length; j++){
					text(soilHealth[i][j], i * SOIL_SIZE, j * SOIL_SIZE);
				}
			}

		}

		popMatrix();

		// Health UI

    for (int i=0; i<playerHealth; i++){
      if(i<5){
      image(life, lifeImageX+70*i, lifeImageY);
      }
    }

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;

				// Initialize player
				playerX = PLAYER_INIT_X;
				playerY = PLAYER_INIT_Y;
				playerCol = (int) (playerX / SOIL_SIZE);
				playerRow = (int) (playerY / SOIL_SIZE);
				playerMoveTimer = 0;
				playerHealth = 2;

				// Initialize soilHealth
				soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
				for(int i = 0; i < soilHealth.length; i++){
					for (int j = 0; j < soilHealth[i].length; j++) {
						 // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
						soilHealth[i][j] = 15;
					}
				}

				// Initialize soidiers and their position
        soldier1X = floor(random(0,8))  *SOIL_SIZE;
        soldier2X = floor(random(0,8))  *SOIL_SIZE;
        soldier3X = floor(random(0,8))  *SOIL_SIZE;
        soldier4X = floor(random(0,8))  *SOIL_SIZE;
        soldier5X = floor(random(0,8))  *SOIL_SIZE;
        soldier6X = floor(random(0,8))  *SOIL_SIZE;
        
        soldier1Y = floor(random(0,4))  *SOIL_SIZE;  
        soldier2Y = floor(random(4,8))  *SOIL_SIZE;
        soldier3Y = floor(random(8,12)) *SOIL_SIZE;  
        soldier4Y = floor(random(12,16))*SOIL_SIZE;
        soldier5Y = floor(random(16,20))*SOIL_SIZE;  
        soldier6Y = floor(random(20,24))*SOIL_SIZE;

				// Initialize cabbages and their position
        for(int i=0; i< CABBAGE_Q; i++){          
          cabbageX [i] = (int) random(0,8)*GRID;
          cabbageY [i] = (int) (Math.random()*24)*GRID;
        }
        				
			}

		}else{
			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);
		}
		break;
		
	}
}

void keyPressed(){
	if(key==CODED){
		switch(keyCode){
			case LEFT:
			leftState = true;
			break;
			case RIGHT:
			rightState = true;
			break;
			case DOWN:
			downState = true;
			break;
		}
	}else{
		if(key=='b'){
			// Press B to toggle demo mode
			demoMode = !demoMode;
		}
	}
}

void keyReleased(){
	if(key==CODED){
		switch(keyCode){
			case LEFT:
			leftState = false;
			break;
			case RIGHT:
			rightState = false;
			break;
			case DOWN:
			downState = false;
			break;
		}
	}
}
