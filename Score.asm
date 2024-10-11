include Irvine32.inc
include Header.inc

SCORE_OFFSET = 3d

.code 
DrawScore proc,
     textcolor: dword,
     color: dword,
	boardTopOffset: dword,
	boardLeftEdgeOffset: dword,
     boardWidth: dword,
	boardHeight: dword,
	borderWidth: dword,
	space: ptr byte,
     p1:ptr dword,
     p2:ptr dword,
     p1str: ptr dword,
     p2str: ptr dword
     
     pushad
     ; ---------------------- set color
     mov eax, color
     add eax, textcolor
	call SetTextColor
     
     ; error below
     mov dl, byte PTR boardLeftEdgeOffset
     mov dh, byte PTR boardTopOffset
     add dh, byte PTR boardHeight
     add dh, 1d
     call Gotoxy

                                                  ; score 1
     mov ecx, SCORE_OFFSET
sc1:
     mov edx, space
     call WriteString
     loop sc1
     
     pushad
     mov edx, p1str
     call WriteString
     mov eax, p1
     call WriteDec
     popad
                                                       ; score 2
     mov ecx, boardWidth
     sub ecx, 17d * 2
     sub ecx, SCORE_OFFSET
     sub ecx, 3                                   ; per each dec printed
sc2:
     mov edx, space
     call WriteString
     loop sc2
     
     mov edx, p2str
     call WriteString
     mov eax, p2
     call WriteDec

     mov ecx, SCORE_OFFSET
sc3:                                           
     mov edx, space
     call WriteString
     loop sc3

     popad
     ret
DrawScore endp
end
