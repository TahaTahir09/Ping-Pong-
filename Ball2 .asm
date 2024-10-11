include Irvine32.inc
include Header.inc

.code
UpdateBall proc,
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
	
	; xCoordBall - the current absolute x coordinate of the ball 
	; yCoordBall - the current absolute y coordinate of the ball
	; xRun - the x (horizontal) component of the ball's velocity
	; yRise - the y (vertical) component of the ball's velocity
	; note : a positive yRise value translates to downward motion of the ball on the consoloe and vice-versa
	
	                                        ; save the state of the registers from the time of the function call
	pushad
	
	                                        ; if the ball goes outside the board, reset the ball
	mov eax, xCoordBall
	mov ebx, rightPaddleX
	add ebx, 20
	cmp [eax], ebx
	ja Reset
	mov ebx, leftPaddleX
	sub ebx, 5
	cmp [eax], ebx
	ja CollisionTesting
Reset:
	mov eax, boardTopOffset
	add eax, 2
	mov ebx, leftPaddleX
	add ebx, 2
	invoke ResetBall, xCoordBall, yCoordBall, ebx, eax, xRun, yRise
	jmp Finish
	
CollisionTesting:
                                             ; if the ball is beyond the paddles
     mov eax, xCoordBall
	mov ebx, rightPaddleX
	cmp [eax], ebx
	ja UpdateCoords
	mov ebx, leftPaddleX
	cmp [eax], ebx
	jb UpdateCoords

                                             ; check whether the ball is touching either frame
                                             ; bottom frame
	mov eax, [yCoordBall]
	mov ebx, boardTopOffset
	add ebx, boardHeight
     dec ebx
	cmp [eax], ebx
	jb NotTouchingBottom
	mov eax, [yRise]
	neg dword ptr [eax]
	
NotTouchingBottom:
	                                        ; top frame
     mov eax, [yCoordBall]
	mov ebx, boardTopOffset
	inc ebx
	cmp [eax], ebx
	ja NotTouchingTop
	mov eax, [yRise]
	neg dword ptr [eax]
	
NotTouchingTop:
	                                       
	mov eax, rightPaddleX
	mov ebx, eax
	dec ebx
	mov eax, [xCoordBall]
	cmp [eax], ebx
	jb NotTouchingRightPaddle
	                                      
	mov eax, rightPaddleY
	mov ebx, eax
	mov eax, [yCoordBall]
	cmp [eax], ebx
	ja NotTouchingRightPaddle
	                                        
	mov eax, rightPaddleY
	mov ebx, eax
	sub ebx, paddleHeight
	mov eax, [yCoordBall]
	cmp [eax], ebx
	jb NotTouchingRightPaddle
	mov eax, [xRun]
	neg dword ptr [eax]
	
NotTouchingRightPaddle:
	                                       
	mov eax, leftPaddleX
	mov ebx, eax
    add ebx, 2
	mov eax, [xCoordBall]
	cmp [eax], ebx
	ja NotTouchingLeftPaddle
	                                        
	mov eax, leftPaddleY
	mov ebx, eax
	mov eax, [yCoordBall]
	cmp [eax], ebx
	ja NotTouchingLeftPaddle
	                                        
	mov eax, leftPaddleY
	mov ebx, eax
	sub ebx, paddleHeight
	mov eax, [yCoordBall]
	cmp [eax], ebx
	jb NotTouchingLeftPaddle
	mov eax, [xRun]
	neg dword ptr [eax]
	
NotTouchingLeftPaddle:
UpdateCoords:
	                                        
	mov eax, [xRun]
     mov ebx, [eax]
     mov eax, [xCoordBall]
     add ebx, [eax]
	mov [eax], ebx
	                                        ; y
	mov eax, [yRise]
	mov ebx, [eax]
	mov eax, [yCoordBall]
	add ebx, [eax]
	mov [eax], ebx
	
	                                        
	mov ebx, [xCoordBall]
	mov dl, byte ptr [ebx]
	mov ebx, [yCoordBall]
	mov dh, byte ptr [ebx]
	call Gotoxy
	
	                                        
	mov eax, color
	call SetTextColor
	
	                                        
	mov edx, space
	call WriteString
	
	                                        
	mov eax, black * 16
	call SetTextColor

                                            
     mov eax, [xCoordBall]
     mov ebx, [eax]
     mov eax, [xRun]
     sub ebx, [eax]
                                             
     mov eax, [xCoordBall]
     mov [eax], ebx

	                                        
     mov eax, [yCoordBall]
	mov ebx, [eax]
	mov eax, [yRise]
	sub ebx, [eax]
	mov eax, [yCoordBall]
     mov [eax], ebx

                                             
     mov ebx, [xCoordBall]
	mov dl, [ebx]
	mov ebx, [yCoordBall]
	mov dh, [ebx]
	call Gotoxy
	
	                                        
	mov edx, space
	call WriteString
	
	                                        
	mov eax, [xRun]
     mov ebx, [eax]
     mov eax, [xCoordBall]
     add ebx, [eax]
	mov [eax], ebx
	                                        
	mov eax, [yRise]
	mov ebx, [eax]
	mov eax, [yCoordBall]
	add ebx, [eax]
	mov [eax], ebx
	
                                             
     mov edx, 0
     call Gotoxy
Finish:
	                                        ; restore the state of the registers from the time of the function call
	popad
	ret

UpdateBall endp
end
	
	
