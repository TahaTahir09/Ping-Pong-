include Irvine32.inc
include Header.inc
.code
DrawFrame proc,
    color: dword,
	boardTopOffset: dword,
	boardLeftEdgeOffset: dword,
    boardWidth: dword,
	boardHeight: dword,
	borderWidth: dword,
	space: ptr byte
	pushad
	     
	; first, the top border
     ; set the the background color
	mov eax, color
	call SetTextColor
    mov eax, boardTopOffset
    mov ebx, boardLeftEdgeOffset
	mov dh, al
	mov dl, bl
	call Gotoxy
	mov edx, space
	mov ecx, 2
L0: push ecx
	mov ecx, borderWidth
L1: push ecx
	mov ecx, boardWidth
L2: call WriteString	
	loop L2
	pop ecx
	loop L1
	pop ecx
    push eax
    push edx
    add eax, boardHeight
    mov dh, al
	mov dl, bl
	call Gotoxy
    pop edx
    pop eax
	loop L0

	mov eax, 0
	call SetTextColor
    mov edx, 0
    call Gotoxy
	popad
	ret
DrawFrame endp
end
	
	
