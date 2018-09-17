
/***************** GLOBALS  ********************************************************/
int ballPos_X, ballPos_Y, ballWidth, ballHeight, ballHorizontalSpeed, ballVerticalSpeed, ballCentre; 
int ballBottomSurface , ballLeftSurface, ballRightSurface;
/* For paddle */
int paddlePos_X, paddlePos_Y, paddleWidth, paddleHeight, paddleHorizontalSpeed; 
boolean movePaddleLeft, movePaddleRight;
int paddleTopSurface, paddleRightEdge, paddleLeftEdge;

/* Colors for Game */
color blackColor = color(0,0,0);
color whiteColor = color(255,255,255);
color redColor   = color( 255,0,0);
color greyColor  = color( 160,160,160);
color greenColor = color(0,153,0);
color blueColor  = color(0,0,170);

/* Set the speed of ball */
final int horizontalStepSize =2; //3         =======================>  change ball's horizontal speed here.
final int verticalStepSize  = 3; //4         ========================> change ball's Vertical speed here.
final int paddleHorizontalStepSize  = 5;//   ========================> change paddle's Horizotal position stes size here.
 
/* Game Score and statistics */
boolean gameOver = false, gameStarted =false;
int gameScore = 0;
/***************** PROGRAM **************************************************************/
void setup(){
  size(500,500);   /*  width and height of screen */
  background(whiteColor); 
  
  /*  initial ball postion is center of screen */
  ballPos_X= width/2; 
  ballPos_Y= height/2;
  
  ballWidth= 40; /* width of ellipse ( i.e ball)   */
  ballHeight= 40; /* height of ellipse  ( i.e ball) */
  ballHorizontalSpeed = horizontalStepSize;  
  ballVerticalSpeed = verticalStepSize;     
  ballCentre = ballWidth/2;  /* Get the centre of ball */  
       
   /* Palce horizontal paddle at bottom of screen  */
   rectMode(CENTER);  
   paddlePos_X =width/2;  /* X pos of paddle from left corner */
   paddlePos_Y =height - 40;   /* paddle y pos from the top as reference */
   paddleWidth = 100;  /* witdth of paddle  */
   paddleHeight = 20;  /* thickness or height of paddle  */
   paddleHorizontalSpeed = paddleHorizontalStepSize ;
  
}
//==================================
void drawBall(){ 
  
  fill(redColor); /*  fill the ball with color */
  ellipse(ballPos_X,ballPos_Y,ballWidth,ballHeight); 
}

//===================================

void draw(){ 

    background(whiteColor); 
    drawBall();  
    moveBall();
    gameStatus_n_Scores();
    checkIfBallHitsScreenEdges();
    drawPaddle();
    movePaddle();
    limitPaddleMovement();
    checkPaddleBallCollision_n_takeAction();
  
}
//=====================================================
void  moveBall(){
    ballPos_X= ballPos_X + ballHorizontalSpeed;
    ballPos_Y= ballPos_Y + ballVerticalSpeed;
}
//==================================================
void checkIfBallHitsScreenEdges(){
  
    /*  check the x and y position of ball and apply the necessary direction change */
    if ( ballPos_X > width - ballCentre){ /* ie if X pos of ball  crosses the  right side of screen. */
        ballHorizontalSpeed = - ballHorizontalSpeed;
    }else if ( ballPos_X < 0 + ballCentre ){
        ballHorizontalSpeed = - ballHorizontalSpeed;
    }   
     
    if ( ballPos_Y > height - ballCentre){  /* ie if Y pos of ball crosses the screen's bottom side */
      
      ballVerticalSpeed = - ballVerticalSpeed;      
      gameOver = true;
      gameScore = 0; 
      setup();
      ballHorizontalSpeed = 0; // stop the ball movement
      ballVerticalSpeed   = 0; // stop the ball movement
      
    } else if ( ballPos_Y < 0 + ballCentre ){
      ballVerticalSpeed = - ballVerticalSpeed;
    }
}
//===================================
void drawPaddle(){
  
    fill(blackColor) ; 
    rect(paddlePos_X,paddlePos_Y,paddleWidth,paddleHeight);
  
}
//===================================
void keyPressed(){ //<>//
  
   if ( keyCode == LEFT ){ /* Is left arrow key( ie page left key) pressed ?  */ 
      movePaddleLeft = true;
    }
    
    if ( keyCode == RIGHT){ /* Is right arrow key( ie page right key) pressed ?  */ 
      movePaddleRight = true;
    }
    /* Afetr game over, check if user has pressed the space bar key and if yes, restart game with random movement of ball */
   if ( key == ' ') {  /* Is space bar key pressed ?  */ 
   
         if  (gameStarted == false) {            //<>//
           gameStarted = true;  
           setup();           
         } else if (gameOver == true) {            //<>//
            gameOver = false;  
            setup();            
            
            /*  Select a random vertical and horizontal direction for ball */
            int [] multiplierSet ={-1, 1};             
            ballHorizontalSpeed =    ballHorizontalSpeed * multiplierSet[int(random(-0.5,4)) % 2];          //<>//
             ballVerticalSpeed =  verticalStepSize   * multiplierSet[int(random(-0.5,4)) % 2];            
        }   
    }
   
}
//====================================================================
void gameStatus_n_Scores(){
    if ( gameStarted == false){
      ballHorizontalSpeed =0;
      ballVerticalSpeed =  0;    
    }
    else if (gameStarted == true && gameOver == false)  {
      fill(greyColor) ;
      textSize(18);
      text("Game Score: "+ gameScore, 5,20);   
    }
    
    if ( gameOver == true) {
     /* Display Game over message */
       fill(redColor) ;
       //textAlign(CENTER,CENTER);
       textSize(30);
       text("GAME OVER! ",150,70);
       textSize(20);
       text("Press SpaceBar key to restart", 100 ,120);
    }
        
    if (gameStarted == false) {
      /* Display Game Start message */
       fill(greenColor) ;
       //textAlign(CENTER,CENTER);
       textSize(30);
       text("Welcome to SQUASH Game ",60,70);
       fill(blueColor) ;
       textSize(20);
       text("1. Use Left-Right Arrow keys to move Paddle", 30 ,120);     
       text("2. Press SpaceBar key to Start/Restart game", 30 ,150);
    }
  }
//========================================================
void keyReleased(){
    if ( keyCode == LEFT ){
      movePaddleLeft = false;
    }
    
     if ( keyCode == RIGHT){
      movePaddleRight= false;
    }
}
//========================================================
void movePaddle(){
   if(  movePaddleLeft == true){
    paddlePos_X = paddlePos_X -  paddleHorizontalSpeed;
  } else if (  movePaddleRight == true){
    paddlePos_X = paddlePos_X +  paddleHorizontalSpeed;
  }
}
//========================================================

/* Ensure that the paddle does not move beyond  programm screen */
void limitPaddleMovement(){
    if( paddlePos_X < paddleWidth/2){    
        paddlePos_X = paddlePos_X + paddleHorizontalSpeed;
    }
   /* If paddleXPos <  PaddleWidth/2, then stop the paddle (because paddle goes beyond the left side of screen) */
   if( paddlePos_X < paddleWidth/2){    
       paddlePos_X = paddlePos_X + paddleHorizontalSpeed;
    }
  /* If (paddleXPos + PaddleWidth/2)  is greater than width of screen, 
   * then stop the paddle (because paddle goes beyond the right side of screen) 
   */
   if( paddlePos_X +  paddleWidth/2 > width)
       paddlePos_X = paddlePos_X - paddleHorizontalSpeed;  
}
//==================================================================================
void checkPaddleBallCollision_n_takeAction(){
  /* Calculate if there is a collision between ball and paddle and take necessary action. */
  paddleTopSurface  = paddlePos_Y - paddleHeight/2;
  ballBottomSurface = ballPos_Y + ballHeight/2;
  paddleRightEdge   = paddlePos_X + paddleWidth/2;
  paddleLeftEdge    = paddlePos_X - paddleWidth/2;
  ballLeftSurface   = ballPos_X - ballWidth/2;
  ballRightSurface  = ballPos_X+ ballWidth/2;
   
    if (paddleTopSurface <  ballBottomSurface &&   ballLeftSurface < paddleRightEdge  &&  ballRightSurface > paddleLeftEdge ){
        ballVerticalSpeed = - ballVerticalSpeed;
        /* If the ball is bounced back by paddle successfully, then increment the score */
        gameScore ++;
    } 
  
}
