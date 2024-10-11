include Irvine32.inc
include Header.inc

.code 
DrawInitialPaddles proc,
     color: dword,
	player1X: PTR dword,						; x-coord
	player1Y: PTR dword,						; y-coord
	player2X: PTR dword,						; x-coord
	player2Y: PTR dword,						; y-coord
	paddleHeight: dword,
     space: ptr byte
     
     pushad
     
     ; draw initial pong paddle player 1

     mov eax, [player1X]
     mov dl, byte PTR [eax]
     mov eax, [player1Y]
     mov dh, byte PTR [eax]
     mov eax, [paddleHeight]
     mov ecx, [eax]
initialDrawP1:
     call Gotoxy
     mov eax, color
     call SetTextColor

     push edx
     mov edx, space
     call WriteString
     pop edx
     dec dh
     loop initialDrawP1

     mov eax, 0
     call SetTextColor
     popad

     ; finish draw initial pong paddle player 1

     ; draw initial pong paddle player 2
     pushad
     mov eax, [player2X]
     mov dl, byte PTR [eax]
     mov eax, [player2Y]
     mov dh, byte PTR [eax]
     mov eax, [paddleHeight]
     mov ecx, [eax]
initialDrawP2:
     call Gotoxy
     mov eax, color
     call SetTextColor

     push edx
     mov edx, space
     call WriteString
     pop edx
     dec dh
     loop initialDrawP2

     mov eax, 0
     call SetTextColor
     popad

     ; finish draw initial pong paddle player 2

     mov dl, 0
     mov dh, 0
     call Gotoxy
     
     pushad

     ret
DrawInitialPaddles endp
end
