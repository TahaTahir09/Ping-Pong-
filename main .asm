include Irvine32.inc
include macros.inc
include Header.inc

; game board and frame data
BOARD_TOP_OFFSET equ 5d
BOARD_LEFT_EDGE_OFFSET equ 15d
BOARD_WIDTH equ 72d
BOARD_HEIGHT equ 20d
BORDER_WIDTH equ 1d
GUI_TEXT_COLOR equ (white)
GUI_COLOR equ (blue * 16)
PADDLE_COLOR equ (white * 16)
BALL_COLOR equ (white * 16)

FRAME_RATE equ 150d

.data

    BufferSize EQU 255
    Buffer BYTE 255 DUP (?)
    p1 BYTE "Player #1",0
    p2 BYTE "Player #2",0
    FileName BYTE "player_details.txt", 0
    PromptName BYTE "Enter player name = ",0
    PromptAge BYTE "Enter player age = ",0
    PromptGender BYTE "Enter player gender (M/F) = ",0
    PromptContact BYTE "Enter player contact = ",0
    NewLine BYTE "--",0
    DashLine BYTE "-----------------------------------------------------------------------------------------------", 0


welcome byte "hey", 0
gameSpeed dword 1h

;prototypes
roomUpperBorder dword (BOARD_TOP_OFFSET)
roomLowerBorder dword (BOARD_TOP_OFFSET + BOARD_HEIGHT)

; ball and paddle tracking
xCoordBall dword BOARD_LEFT_EDGE_OFFSET
yCoordBall dword BOARD_TOP_OFFSET + 2
xRun dword 1
yRise dword 1

; character
space byte " ", 0

player1X dword (BOARD_LEFT_EDGE_OFFSET)
player1Y dword (BOARD_TOP_OFFSET + (BOARD_HEIGHT / 2))
player2X dword (BOARD_LEFT_EDGE_OFFSET + BOARD_WIDTH - 1)
player2Y dword (BOARD_TOP_OFFSET + (BOARD_HEIGHT / 2))

paddleHeight dword 4h

playerColor dword (lightBlue * 16)
ballColor dword (lightBlue * 16)
guiColor dword (blue * 16)
p1scoreString byte "Player 1 score: ", 0
p2scoreString byte "Player 2 score: ", 0
p1score dword 0
p2score dword 0

.code


main proc
    
    call header
    call space_
    mWrite "Fetching Player Data ...."
    call space_
    
    ; Open the file for appending
    mov edx, OFFSET FileName
    mov ecx, 4 ; Open for appending
    call OpenInputFile
    mov ebx, eax ; Save file handle in ebx

    mWrite "Player #1",0
    call space_
    call input

    call clrscr

    call header
    call space_
    mWrite "Fetching Player Data ...."
    call space_
    mWrite "Player #2"
    call space_
    call input

    ; Close the file
    mov eax, ebx ; Use the file handle saved in ebx
    call CloseFile

    call clrscr
     mov eax, 0
     call SetTextColor
     invoke DrawFrame, GUI_COLOR, BOARD_TOP_OFFSET, BOARD_LEFT_EDGE_OFFSET, BOARD_WIDTH, BOARD_HEIGHT, BORDER_WIDTH, addr space

     invoke DrawInitialPaddles, PADDLE_COLOR, addr player1X, addr player1Y, addr player2X, addr player2Y, addr paddleHeight, addr space

     mov ecx, 1
MainLoop:
     invoke UpdateBall, addr xCoordBall, addr yCoordBall, BALL_COLOR, addr xRun, addr yRise, addr space, BOARD_TOP_OFFSET, BOARD_HEIGHT, player1X, player1Y, player2X, player2Y, paddleHeight     
     
     inc ecx                                           ; increment ecx to keep the loop going...when the ball goes out of bounds, set ecx to 0 so the inner loop can finish
     invoke Chill, FRAME_RATE

                                                       ; check for movement and redraw paddle accordingly
     invoke CheckMovement, PADDLE_COLOR, addr player1x, addr player1Y, addr player2X, addr player2y, paddleHeight, roomUpperBorder, roomLowerBorder
	jmp ML3
ML2:
    jmp MainLoop 
ML3:

     invoke DrawScore, GUI_TEXT_COLOR, GUI_COLOR, BOARD_TOP_OFFSET, BOARD_LEFT_EDGE_OFFSET, BOARD_WIDTH, BOARD_HEIGHT, BORDER_WIDTH, addr space, p1score, p2score, addr p1scoreString, addr p2scoreString 
     
     loop ML2
	
	
     exit
main endp
space_ PROC
    call crlf
    call crlf
    ret
space_ ENDP
input PROC

    ; Input player details
    mov edx, OFFSET PromptName
    call WriteString
    call Read
    mov eax, ebx ; File handle
    mov ecx, SIZEOF PromptName
    call Write

    mov edx, OFFSET PromptAge
    call WriteString
    call Read
    mov eax, ebx
    mov ecx, SIZEOF PromptAge
    call Write

    mov edx, OFFSET PromptGender
    call WriteString
    call Read
    mov eax, ebx
    mov ecx, SIZEOF PromptGender
    call Write

    mov edx, OFFSET PromptContact
    call WriteString
    call Read
    mov eax, ebx
    mov ecx, SIZEOF PromptContact
    call Write

ret
input ENDP

Write PROC
    ; Write the string to the file
    call WriteToFile
    ret
Write ENDP

Read PROC
    ; Read string
    mov edx, OFFSET Buffer ; Buffer
    mov ecx, BufferSize ; Buffer size
    call ReadString
    ret
Read ENDP



header PROC
    mov dl, 50
    mov dh, 0
    call gotoxy
    mWrite "WELCOME TO GAME"

    mov dl, 40
    mov dh, 1
    call gotoxy
    mWrite "COAL PROJECT BY TAHA - TIMOTHEUS - ANAS"
    ret
header ENDP
end main