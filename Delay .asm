include Irvine32.inc
include Header.inc

.code 
Chill proc,
	duration: dword
     pushad
	mov eax, duration
	call Delay
    popad
	ret
Chill endp
end