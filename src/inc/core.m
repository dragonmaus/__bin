%ifndef CORE_M
%define CORE_M

%macro cextern 1
	extern	%1
%endmacro

%macro cglobal 1
	global	%1
%endmacro

%macro cinvoke 1-*
	%assign a (%0 - 1)
	%assign s 0
	%if a > 6
		%if (a % 2) == 1
			sub	rsp, 8
			%assign s ((a - 5) * 8)
		%else
			%assign s ((a - 6) * 8)
		%endif
		%rep (a - 6)
			%rotate -1
			push	qword %1
		%endrep
	%endif
	%if a > 5
		%rotate -1
		minmov	r9, %1
	%endif
	%if a > 4
		%rotate -1
		minmov	r8, %1
	%endif
	%if a > 3
		%rotate -1
		minmov	rcx, %1
	%endif
	%if a > 2
		%rotate -1
		minmov	rdx, %1
	%endif
	%if a > 1
		%rotate -1
		minmov	rsi, %1
	%endif
	%if a > 0
		%rotate -1
		minmov	rdi, %1
	%endif
	%rotate -1
	call	%1
	%if s > 0
		add	rsp, s
	%endif
%endmacro

%macro invoke 1-*
	%assign a (%0 - 1)
	%if a > 6
		%rep (a - 6)
			%rotate -1
			push	qword %1
		%endrep
	%endif
	%if a > 5
		%rotate -1
		minmov	r9, %1
	%endif
	%if a > 4
		%rotate -1
		minmov	r8, %1
	%endif
	%if a > 3
		%rotate -1
		minmov	rcx, %1
	%endif
	%if a > 2
		%rotate -1
		minmov	rdx, %1
	%endif
	%if a > 1
		%rotate -1
		minmov	rsi, %1
	%endif
	%if a > 0
		%rotate -1
		minmov	rdi, %1
	%endif
	%rotate -1
	call	%1
%endmacro

%macro minmov 2
	%ifnidn %1, %2		; emit nothing if moving a register onto itself
		%ifidn %2, 0	; `xor reg, reg` is smaller than `mov reg, 0`
			xor	%1, %1
		%else
			mov	%1, %2
		%endif
	%endif
%endmacro

%macro proc 0
proc %00
%endmacro

%macro proc 1
	cglobal	%1
%1:
	push	rbp
	mov	rbp, rsp
%endmacro

%macro endproc 0
	pop	rbp
	ret
%endmacro

%macro sinvoke 1-*
	%assign a (%0 - 1)
	%if a > 6
		%rep (a - 6)
			%rotate -1
			push	qword %1
		%endrep
	%endif
	%if a > 5
		%rotate -1
		minmov	r9, %1
	%endif
	%if a > 4
		%rotate -1
		minmov	r8, %1
	%endif
	%if a > 3
		%rotate -1
		minmov	rcx, %1
	%endif
	%if a > 2
		%rotate -1
		minmov	rdx, %1
	%endif
	%if a > 1
		%rotate -1
		minmov	rsi, %1
	%endif
	%if a > 0
		%rotate -1
		minmov	rdi, %1
	%endif
	%rotate -1
	minmov	rax, %1
	syscall
%endmacro

%macro string 1+
%00	db	%1
%00_len	equ	$ - %00
%endmacro

%endif
