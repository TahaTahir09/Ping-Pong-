DrawFrame proto,
    color: dword,
    boardTopOffset: dword,
	boardLeftEdgeOffset: dword,
    boardWidth: dword,
	boardHeight: dword,
	borderWidth: dword,
	space: ptr byte

DrawInitialPaddles proto,
    color: dword,
	p1coordx: PTR dword,						; x-coord
	p1coordy: PTR dword,						; y-coord
	p2coordx: PTR dword,						; x-coord
	p2coordy: PTR dword,						; y-coord
	paddleHeight: dword,
     space: ptr byte

CheckMovement proto,
    color: dword,
	p1coordx: PTR dword,						; x-coord
	p1coordy: PTR dword,						; y-coord
	p2coordx: PTR dword,						; x-coord
	p2coordy: PTR dword,						; y-coord
	paddleHeight: dword,
	roomUpperBorder: dword,
	roomLowerBorder: dword
 
DrawBall proto,
     color: dword,
     xCoordBall: ptr dword,
     yCoordBall: ptr dword,
     xRun: ptr dword,
	yRise: ptr dword

DrawScore proto,
    textcolor: dword,
    color: dword,
	boardTopOffset: dword,
	boardLeftEdgeOffset: dword,
    boardWidth: dword,
	boardHeight: dword,
	borderWidth: dword,
	space: ptr byte,
    p1score: ptr dword,
    p2score: ptr dword,
    p1string: ptr dword,
    p2string: ptr dword

 UpdateBall proto,
    xCoordBall: ptr dword,
    yCoordBall: ptr dword,
    color: dword,
    xRun: ptr dword,
	yRise: ptr dword,
	space: ptr byte,
	boardTopOffset: dword,
	boardHeight: dword,
    leftPaddleX: dword,
    leftPaddleY: dword,
    rightPaddleX: dword,
    rightPaddleY: dword,
	paddleHeight: dword
	
ResetBall proto,
	xCoordBall: ptr dword,
	yCoordBall: ptr dword,
	newXCoordBall: dword,
	newYCoordBall: dword,
	xRun: ptr dword,
	yRise: ptr dword
 
Chill proto,
     duration: dword
