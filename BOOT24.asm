M_SP	.EQU    0DCF0h	; DW 㪠��⥫� �⥪�
M_PP1	.EQU    0DCF1h	; DW ��뫪� �� ����ணࠬ�� 1
M_PP2	.EQU    0DCF4h	; DW ��뫪� �� ����ணࠬ�� 2
M_HPIC	.EQU    0DCF7h	; DB ���� ���⨭��
M_VAR1	.EQU    0DED0h	; DB/DW ��� �࠭���� 㪠��⥫� �⥪� (��) ��� ��砫� ����㧪�
M_DSK	.EQU	0DED2h	; DB ����� ��
M_DKD	.EQU    0DED3h	; DB ����� ��஦�� ��
M_SKD	.EQU    0DED4h	; DB ����� ᥪ�� ��
M_BKD	.EQU    0DED5h	; DW ���� ���� ��� �⥭�� � ��
M_RKD	.EQU    0DED7h	; DW ���� ��砫� ᥪ�� �� ��
M_VEF1	.EQU    0DEF1h	;
M_VEF4	.EQU    0DEF4h	; DB �������/��אַ� ᨣ��� ��
M_VEF6	.EQU    0DEF6h	; DB ᪮���� �⥭�� � ��
S_KBD	.EQU    0DEF7h	; DB ��� ������� ������
B_DRV	.EQU    0E400h	; ���� ��� �⥭�� ����/����
M_BT	.EQU	0DED2h	; ����㧮�� ᥪ�� ����/���� (20h ����):
			; DW ��砫�� ���� ��� ����㧪�
M_SKB	.EQU	M_BT+4	; DB ������⢮ ᥪ�஢ (1�) ��� ����㧪�
M_FM9l	.EQU	0E050h	; ����ணࠬ�� ��� FM9
X_E053	.EQU	0E053h
X_E0D8	.EQU	0E0D8h
;
;F3_PRG			; ���ᨪ
F3_LEN	.EQU    03300h	; ࠧ���
#DEFINE F4_PRG F3_PRG+F3_LEN	; ������ �㯥�������
F4_LEN	.EQU    03D00h	; ࠧ��� � ������
;
	.ORG    00000h
L_0000:	DI
	MVI  A, 91h	; B,C (7-4) - �뢮�,  A,C (3-0) - ����
	OUT     004h	; -> ��� ��
	MVI  A, 088h	; A,B,C (3-0) - �뢮�, C (7-4) - ����
	OUT     000h	; -> ��� ����������
	MVI  A, 0A8h	; �몫�祭�� ������ 0 ��㪠
	OUT     008h	; <- ०-4,��.����-(����������)
	MVI  A, 028h	; �몫�祭�� ������ 2 ��㪠
	OUT     008h	; <- ०-4,��.����-(����������)
	; ���祭�� ����⥫� ����� (1,5 ��� / 1500 = 1 ���)
	MVI  A, 036h	; 0011 0110 -- [����� 0][��/�� ᫮��][०�� 3][������]
	OUT     008h	; ��� �/� ��53
	MVI  A, 0DCh
	OUT     00Bh	; ����� 0
	MVI  A, 005h
	OUT     00Bh	; ����� 0
	LXI  SP,0E000h
	LXI  H, 0C13Eh
	PUSH H		; �ਬ�⨢��� �஢�ઠ �����...
	POP  D		; D = C1h, E = 3Eh (��⠭�)
	MOV  A, L	; A = 3Eh (����ᠭ��� ���祭��)
	SUB  E		; A = A - E
	ADD  H		; A = A + H (+����ᠭ��� ���祭��)
	SUB  D		; A = A - D
	JNZ     L_0000  ; �� ᮢ����, ���
	MOV  H, A	; HL = L_003E
	PUSH H		; ���� L_003E � �⥪
	MOV  C, A	; ����塞 ��.���� ����稪�
	IN      001h
	ANI     040h	; �뤥���� ����⨥ ������ �� (C=40H - ��᪠)
	JNZ     L_0039	; �᫨ �� ����� �� >>>
	MVI  B, 010h	; ����稪
;	JMP     L_003E
L_0038:	RET		; ��� RST 7 // ���室 �� L_003E �� ��ࢮ� �믮������
;
L_0039:	LXI  SP,00000h	; ���⮢� ����
	MVI  B, 080h	; ����稪
L_003E:	LXI  H, 00000h	; 祬 ���������
L_CLRM:	PUSH H
	DCR  C
	JNZ     L_CLRM
	DCR  B
	JNZ     L_CLRM	; 横�� ������ ���⪨ �����
	XRA  A
	OUT     001h	; ���⠢��� � ���� C ���� (���.����,������� ���.)
	LXI  SP,M_SP	; �⥪ ࠡ�稩
;	MOV  B, A	; B = 00h
	MVI  A, 030h	; 0011 0000 -- [����� 0][��/�� ᫮��][०�� 0][������]
	OUT     008h	; ��� �/� ��53 (�⪫�祭�� ��᪠)
	LXI  D, 00009h	; ���� ��ப�
	MVI  C, 0FFh	; C = 0FFh, ⥯��� ��㥬 ����㧮��� ⠡����
L_0059:	MOV  H, B
	MOV  L, D	; L = 0
	CALL    L_0141	; ���᫥��� ���न���
	DCR  L		; �� ��ப� ����
	MOV  M, C
	DAD  D		; +9 ��ப
	MOV  M, C
	INR  L		; +1 ��ப�
	MVI  M, 081h
	INR  B		; ����稪
	JNZ     L_0059	; 横� �ᮢ���� ⠡���� ^^^
	LXI  H, L_06CB	; ������� ������-06�
	LXI  D, 0C4E9h	; ���� � �࠭�
	MVI  A, 009h	; �᫮ �⮫�殢
	CALL    L_0172	; �뢮� ��㭪� �� �࠭
	LXI  H, L_00EF	; ���� �� ����砭�� ����㧪� ...
	PUSH H		; ... �������� � �⥪
	MVI  A, 0C3h	; � � ��� "JMP"
	STA     M_PP1	; JMP �� ����� 0DCF1h
	STA     M_PP2	; JMP �� ����� 0DCF4h
	CALL    L_0107	; ������ ������� + ���� ����������
	LDA     S_KBD	; ���� ��� ������
	CPI     0FBh	; ������ ��2 / ��+��2 ?
	JZ      L_0857	; >> ����㧪� �� �� �१ ����� ��-LPT
	CPI     07Fh	; ������ F5 / ��+F5 ?
	JZ      L_00E0	; >> ����㧪� �� �����
	IN      001h
	ANI     040h	; �஢�ઠ ������ ��
	LDA     S_KBD
	JNZ     L_00A6	; (�� �� �����)
	CPI     0BFh	; ������ ��+F4
	JZ      L_0819	; >> ॠ������ 0 ����� ������ (०�� ����㧪� ��⥪������)
	CPI     0FDh	; ������ ��+���
	JZ      L_07B6	; >> ����㧪� ����� ���㧪� ������ �१ �� (� ������)
	MVI  A, 0F7h	; � ��⠫��� ����� � �� -- ������䮭
L_00A6:	CPI     0F7h	; ������ F1 ?
	JZ      L_042B	; >> ������䮭
	CPI     0EFh	; ������ F2 ?
	JZ      L_00D4	; >> ���⪨� ���
	CPI     0DFh	; ������ F3 ?
	JZ      L_07C8	; >> ���ᨪ
	CPI     0BFh	; ������ F4 ?
	JZ      L_07AD	; >> ������ �㯥�������
	CPI     0E7h	; ������ F1+F2 ?
	JZ      L_00DA	; >> ����㧪� � 䫮������
	CPI     0D7h	; ������ F1+F3 ?
	JZ      L_00E6	; >> �⥢�� ������
	CPI     0FEh	; ������ [�����-�����] ?
	JZ      L_FM9	; >> FM9
	CPI     07Bh	; ������ F5+AP2 ?
	JZ      L_07F9	; >> ��� ���
	CALL    L_04FA	; �஢�ઠ ������ ��
	JZ      L_0547	; >>> ���室 �� ����㧪� � ��
L_00D4:	CALL    L_CHDD	; �஢�ઠ ������ ���
	JZ      L_067B	; >>> ���室 �� ����㧪� � ��᪠
L_00DA:	CALL    L_035A	; �஢�ઠ �� in 19 (��᪮���)
	JZ      L_0365	; >>> ����㧪� � 䫮������
L_00E0:	CALL    L_030A	; �஢�ઠ ������ �����
	JNZ     L_033C	; >>> ����㧪� �� �����
L_00E6:	CALL    L_0195	; �஢�ઠ ������ �⥢��� ������
	JNZ     L_01C6	; >>> ����㧪� �१ �⥢�� ������
	JMP     L_042B	; >>> ����㧪� � ������䮭�
;
L_00EF: CALL    L_NN	; << ����㧪� ����祭�
	MVI  A, 003h	; ��⠭���� PC[1]=1 (�몫.५�)
	OUT     000h
L_00F6:	EI
	HLT
	INX  B
	MOV  A, C
	ANI     008h
	RAR
	RAR
	RAR
	ADI	006h
	OUT     000h
	JMP     L_00F6	; �������� ���-�����
;
L_0107: EI		; ������ ������� � ���� ����������
	HLT
	DI
	PUSH B
	LXI  H, 02D80h	; ����㦠�� 梥� 1 � L � 梥� 2 � H
	LXI  D, 0100Fh	; D - ����稪, E - 䨧.梥�
L_PL16:	MOV  A, E
	OUT     002h	; ������ -- �롮� ��⥬���᪮�� 梥�
	ANI     002h
	MOV  A, L	; A = L, �᫨ (䨧.梥� & 06) = 0
	JZ      L_COL1
	MOV  A, H	; � A = H, �᫨ (䨧.梥� & 06) <> 0
L_COL1:	OUT     00Ch	; ������ -- ��⠭���� 䨧��᪮�� 梥�
	PUSH PSW
	POP  PSW
	PUSH PSW
	POP  PSW	; ����প�
	DCR  E
	DCR  D		; (����稪 -1)
	OUT     00Ch	; ������ -- ��⠭���� 䨧��᪮�� 梥�, ��� ࠧ
	JNZ     L_PL16	; 横� ��⠭���� �������, 16 ࠧ
;
	MVI  A, 08Ah	; A,C (3-0) - �뢮�, B,C (7-4) - ����
	OUT     000h	; -> ��� ����������
	MVI  A, 0FDh	; �롮� ������� ����������
	OUT     003h	; � ���� � (���������)
	IN      002h	; ���� ��� ������ �� ����
	STA     S_KBD	; ��࠭��� ��� ������ � �� 0DEF7h
	MVI  A, 088h	; A,B,C (3-0) - �뢮�, C (7-4) - ����
	OUT     000h	; -> ��� ����������
;
	XRA  A
	OUT     002h	; � ���� B -- 梥� �����
	DCR  A
	OUT     003h	; � ���� � -- �室� ��7 = 0FFh (ᤢ�� �࠭�)
	POP  B
	RET
;
L_0141:	PUSH D		; ���᫥��� ���न��� ����㧮筮� ⠡����
	MOV  A, L
	RLC
	RLC
	RLC
	MOV  L, A
	MOV  A, H
	RAR
	ANI     070h
	MOV  D, A
	RAR
	ADD  D
	ADD  L
	ADI     018h
	MOV  L, A
	MOV  A, H
	ANI     01Fh
	ADI     0C0h
	MOV  H, A
	POP  D
	RET
;
L_015A:	PUSH H		; <<< ���������� �����, HL=��砫�
	PUSH B
	CALL    L_0141	; > ���᫥��� ���न���
	MVI  A, 008h
	ADD  L		; A = L + 8
	MVI  C, 07Eh	; ����窠 �����
L_0164:	MOV  M, C
	INR  L
	CMP  L
	JNZ     L_0164
	POP  B
	POP  H
	RET
;
L_016D:	MVI  A, 002h	; �᫮ �⮫�殢   <<< �� ���ᮢ�� ���⨭��
L_016F:	LXI  D, 0D8E2h	
L_0172:	MOV  B, M	; ���뢠�� ����� ���⨭��  << ������� ������...
	INX  H
L_0174:	STA     M_HPIC	; �⮫���
;	MVI  A, 07Fh
;	ANA  B
;	MOV  C, A
	MOV  C, B
	PUSH D
L_017C:	;MOV  A, B
	;ORA  A		; B >= 80h ?
	DCR  C
	MOV  A, M
	STAX D
	INX  D
	JP      L_0186	; �� ������� ����
	STAX D
	INX  D
L_0186:	INX  H
	MVI  A, 07Fh
	ANA  C
	JNZ     L_017C
	POP  D
	INR  D
	LDA     M_HPIC
	DCR  A
	JNZ     L_0174
	RET
;
;===================================================================
L_0195:	MVI  B, 004h	; << �஢�ઠ ������ �⥢��� ������
	IN      007h	; <- ���� � ��
	ORI     0E0h
	MOV  C, A
	MVI  A, 08Bh	; 1000 1011
	OUT     004h	; -> ��� ��
L_01A0:	MOV  A, C
	OUT     007h	; -> ���� � ��
	XTHL
	XTHL
	IN      005h	; <- ���� � ��
	ANI     008h
	JZ      L_NN	; >>> �⥢��� ������ ���
	MVI  A, 07Fh
	ANA  C
	OUT     007h	; -> ���� � ��
	IN      005h	; <- ���� � ��
	CMA
	ANI     008h
	JZ      L_NN	; >>> �⥢��� ������ ���
	DCR  B
	JNZ     L_01A0	; 横�, 4 ࠧ�
	ORA  A
	JZ      L_NN	; >>> �⥢��� ������ ���
L_01C1:	MVI  A, 09Bh	; A,B,C - ����, ०�� 0 (1001 1011)
	OUT     004h	; -> ��� ��
	RET		; >>> �⥢�� ������ �����㦥�
;
; ---------------------------------------------------------
L_01C6:	;CALL    L_0620	; << ����㧪� �१ �⥢�� ������ / ������䮭
	LXI  H, L_0779	; ���⨭�� ��
	CALL    L_016D	; ���ᮢ�� ���⨭��
	LXI  H, L_02A8
	SHLD    M_PP1+1	; 0DCF2h
	LXI  H, L_01D8
	SHLD    M_PP2+1	; 0DCF5h
L_01D8:	CALL    L_01C1	; <<<<<<<<<<<<<<< PP2
	IN      007h
	ANI     01Fh
	MOV  C, A
	MVI  B, 00Ah
L_01E2:	IN      005h
	ANI     070h
	CPI     040h
	JNZ     L_01D8
	IN      006h
	ANI     01Fh
	CMP  C
	JNZ     L_01D8
	DCR  B
	JNZ     L_01E2
	IN      006h
	MOV  B, A
	MVI  A, 098h
	OUT     004h
	MOV  A, C
	OUT     006h
	XRA  A
	OUT     005h
	MVI  D, 0FAh
L_0206:	DCR  D
	JZ      L_01D8
	IN      005h
	ANI     070h
	CPI     070h
	JNZ     L_0206
	CALL    L_01C1
	MOV  A, B
	ANI     0E0h
	JNZ     L_01D8
	MVI  E, 003h
L_021E:	MVI  A, 008h	; <<<<<<<<<<<<<<< ������䮭
	CALL    M_PP1	; >>>
	CPI     055h
	JZ      L_022D
	CPI     0AAh
	JNZ     M_PP2	; >>>
L_022D:	DCR  E
	JNZ     L_021E	; 横� ���������
L_0231:	CALL    L_02E6
	MOV  E, A
	MOV  A, M
	ORA  A
	JNZ     L_0231
	LXI  H, M_VEF1-2	; ��।��塞 ��᫥���� ����
	MOV  A, M		;
	INX  H			;
	ADD  M			;
	DCR  A			;
	PUSH H			; �⠢�� ����
	MOV  H, A		;
	MVI  L, 000h		;
	CALL    L_0141	; ���᫥��� ���न��� ����㧮筮� ⠡����
	DCR  L			;
	DCR  L			;
	MVI  M, 008h		;
	DCR  L			;
	MVI  M, 014h		;
	DCR  L			;
	MVI  M, 022h		; ����窠
	POP  H			;
	INX  H			;
	MOV  A, M
	DCX  H
	CMP  M
	JNZ     M_PP2	; >>>
	MOV  D, A
	DCX  H
	MOV  B, M
L_0246:	CALL    L_02E6	; << ��砫� 横�� ����㧪� ������
	PUSH PSW
	MOV  A, M
	ORA  A
	JZ      L_0282
	ADD  A
	ADD  A
	ADD  A
	ADD  A
	ADD  A
	MOV  C, A
	POP  PSW
	INX  H
	MOV  A, M
	CMP  E
	JNZ     L_0246
	PUSH D
	PUSH B
	INX  H
	LXI  D, 0207Eh	; 7� -- ����窠 �����, 20 -- ����稪
L_0262:	MOV  A, M
	STAX B
	LDAX B
	XRA  M
	MOV  M, A
	INX  H
	INR  C
	DCR  D
	JNZ     L_0262
	POP  B
	MOV  L, C
	MOV  H, B
	CALL    L_0141	; ���᫥��� ���न��� ����㧮筮� ⠡����
	MOV  M, E
	POP  D
	CALL    L_0297	; ���� ����㦥�?
	JZ      L_0246	; >> ���
	MOV  A, D
	CPI     001h	; ��᫥���� ����?
	JNZ     L_0246	; >> ���
	RET		; >>>>> ����㧪� ����祭�
;
L_0282:	POP  PSW
	SUB  E
	JZ      L_0246
	INR  A
	JNZ     L_0000	; ���
	CALL    L_0297	; ���� ����㦥�?
	JZ      L_0000	; ���
	DCR  E
	INR  B
	DCR  D
	JMP     L_0246
;
L_0297:	MVI  L, 000h	; �� �஢�ન ���������� �����
	MOV  H, B
	CALL    L_0141	; ���᫥��� ���न��� ����㧮筮� ⠡����
L_029D:	MOV  A, M
	ANA  A
	RZ
	INX  H
	CPI     081h
	JNZ     L_029D
	ANA  A
	RET
;
L_02A8: PUSH D		; <<<<<<<< PP1
	MVI  D, 070h
	CPI     0FFh
	CZ      L_02DD
	CALL    L_02B5
	POP  D
	RET
;
L_02B5: MVI  E, 060h
L_02B7: IN      005h
	ANA  D
	CPI     040h
	JZ      L_0000	; ���
	CMP  E
	JNZ     L_02B7
	IN      006h
	PUSH PSW
	MVI  A, 09Ah
	OUT     004h
	XRA  A
	OUT     005h
L_02CD: DCR  E
	JZ      L_02D8
	IN      005h
	ANA  D
	CMP  D
	JNZ     L_02CD
L_02D8: CALL    L_01C1
	POP  PSW
	RET
;
L_02DD: CALL    L_02B5
	CPI     0E6h
	JNZ     L_02DD
	RET
;
L_02E6:	PUSH B
	PUSH D
	LXI  H, M_VAR1
L_02EB:	PUSH H
	LXI  B, 00023h	; B - �����. �㬬�; C - ����稪
	MVI  A, 0FFh
L_02F1:	CALL    M_PP1	; >>>
	MOV  M, A
	INX  H
	ADD  B
	MOV  B, A
	MVI  A, 008h
	DCR  C
	JNZ     L_02F1	; 横� �� ��ப�
	DCX  H
	MOV  A, B
	SUB  M
	SUB  M
	MOV  A, M
	POP  H
	JNZ     L_02EB
	POP  D
	POP  B
	RET
;
;==========================================================
L_030A:	MVI  A, 082h	; << �஢�ઠ ������ �����
	OUT     004h	; 1000 0010 -> ���� ��� ��
	MVI  B, 0FFh
L_0310:	MOV  A, B
	OUT     005h	; -> ���� � ��
	MVI  A, 0FEh
	OUT     007h	; -> ���� A ��
	IN      006h	; <- ���� B ��
	CPI     055h
	JNZ     L_032F	; >>> �� ᮢ����
	MVI  A, 0FFh
	OUT     007h	; -> ���� A ��
	IN      006h	; <- ���� B ��
	CPI     0AAh
	JNZ     L_032F	; >>> �� ᮢ����
	MOV  A, B
	ANI     07Fh
	INR  A
	MOV  D, A
;	ORA  A
	RET		; >>> ����� ����
;
L_032F:	MOV  A, B
	SUI     020h
	MOV  B, A
	JM      L_0310
L_NN:	MVI  A, 91h	; B,C (7-4) - �뢮�,  A,C (3-0) - ����
	OUT     004h	; -> ��� ��
	XRA  A
	RET		; >>> ����� ���
;
L_033C:	CALL    L_07F0	; ���⨭�� 稯� << ����㧪� �� �����
	LXI  H, 08000h
	MOV  B, L
	MOV  C, L
L_0344:	MOV  A, L
	OUT     007h
	MOV  A, H
	OUT     005h
	IN      006h
	STAX B
	INX  H
	INX  B
	MOV  A, B
	CMP  D
	JNZ     L_0344
	LXI  H, 00000h
	JMP     L_FBL1	; >> ���������� ������
;
;==========================================================
L_035A:	MVI  A, 00Bh	; << �஢�ઠ ������ 䫮������
	OUT     019h
	MOV  C, A
	XTHL
	XTHL
	IN      019h
	CMP  C
	RET
;
L_0365:	LXI  H, L_0755	; ��᪥⪠	; << ����㧪� � 䫮������
	CALL    L_016D	; ���ᮢ�� ���⨭��
	MVI  A, 034h
	STA     M_VAR1
	CALL    L_0420	; >
	XRA  A
	OUT     01Bh
	CALL    L_0414	; >
	MVI  C, 001h
	LXI  H, B_DRV
	CALL    L_03ED	; >
	CZ      L_CHBT	; �஢�ઠ ����㧮筮�� ᥪ��
	JNZ     L_0000	; �訡�� >>> ���
	CALL    L_SETB	; �⥭�� ��ࠬ��஢ ����㧪�
	PUSH D		; ��࠭塞 ������⢮ ��������� ⠡����
;	MOV  B, A
L_03A5:	MVI  C, 001h	; ����� ᥪ��
L_03A7:	CALL    L_03ED	; >
	JNZ     L_0000	; ���
	DCR  B
	JZ      L_03D3	; > ���������� ������
	INR  C
	MVI  A, 006h
	CMP  C
	JNZ     L_03A7
	LDA     M_VAR1
	XRI     004h
	STA     M_VAR1
	CALL    L_0420	; >
	MOV  A, D
	ANI     004h
	JZ      L_03A5
	MVI  A, 058h
	OUT     01Bh
	CALL    L_0414	; >
	JMP     L_03A5
;
L_03D3:	POP  D
	JMP     L_DDN	; >> ���������� ������
;
L_03ED:	CALL    L_0414	; >
	MOV  A, C
	OUT     019h
	LXI  D, 00103h	; ????
	MVI  A, 080h
	OUT     01Bh
L_03FA:	IN      01Bh
	RRC
	JNC     L_03FA
L_0400:	IN      01Bh
	ANA  E		; 0000 0011
	SUB  D		; -01h
	JZ      L_0400
	IN      018h
	MOV  M, A
	INX  H
	JP      L_0400
	DCX  H
	IN      01Bh
	ANI     09Ch
	RET
;
L_0414:	LDA     M_VAR1
	OUT     01Ch	; ॣ���� �ࠢ�����
	IN      01Bh	; ॣ���� ���ﭨ� (IN)
	RRC
	JC      L_0414
	RET
;
L_0420:	MOV  D, A
L_0421:	OUT     01Ch	; ॣ���� �ࠢ�����
	IN      01Bh	; ॣ���� ���ﭨ� (IN)
	RLC
	MOV  A, D
	JC      L_0421
	RET
;
;==========================================================
L_042B:	LXI  H, L_0714	; << ����㧪� � ������䮭�
	CALL    L_016D	; ���⨭��
;;	MVI  A, 007h	; ����砥� ���/���	+++
;;	OUT     000h	; ��ࠢ�塞 � ���� C	+++
	XRA  A		; �����⪠ �࠭�
	LXI  H, M_VAR1	; ��砫�
	MVI  C, 009h	; ����稪
L_0437:	MOV  M, A
	INR  L
	DCR  C
	JNZ     L_0437  ; 横� �����⪨
Lx043D:	MVI  A, 011h	; <== PP2
	STA     M_VEF6	; ��砫쭠� ᪮���� �⥭��
	LXI  H, L_04B1
	SHLD    M_PP1+1	; 0DCF2h
	LXI  H, Lx043D
	SHLD    M_PP2+1	; 0DCF5h
	CALL    L_0486
L_0451:	MOV  D, A
	ORA  A
	RAR
	MOV  E, A
	ADD  D
	MOV  H, A
	CALL    L_0486
	CMP  H
	JC      L_0451
	ADD  D
	STA     M_VEF6	; ᪮���� �⥭��
;;	MVI  A, 006h	; �몫�砥� ���/���	+++
;;	OUT     000h	; ��ࠢ�塞 � ���� C	+++
	MVI  E, 00Ch
	JMP     L_021E	; >>>>>>>>>>>>>>>>>>
;
L_0467:	PUSH D
	IN      001h
	ANI     010h
	MOV  E, A
L_046D:	IN      001h
	ANI     010h
	CMP  E
	JZ      L_046D	; �������� ᨣ����
	MOV  E, A
	MVI  D, 001h
L_0478:	IN      001h
	ANI     010h
	INR  D
	CMP  E
	JZ      L_0478
	MOV  A, D
	ADD  A
	ADD  A
	POP  D
	RET
;
L_0486:	PUSH H
	PUSH D
L_0488:	CALL    L_0467
	MOV  B, A
	ORA  A
	RAR
	MOV  C, A
	LXI  H, 00000h
	MVI  D, 020h
L_0494:	CALL    L_0467
	PUSH D
	MVI  D, 000h
	MOV  E, A
	DAD  D
	POP  D
	MOV  E, A
	SUB  B
	JNC     L_04A4
	MOV  A, B
	SUB  E
L_04A4:	CMP  C
	JNC     L_0488
	DCR  D
	JNZ     L_0494
	DAD  H
	MOV  A, H
	POP  D
	POP  H
	RET
;
L_04B1: PUSH B		; <<<<<<<<<<< PP1
	PUSH D
	MVI  C, 000h
	MOV  D, A
L_04B6: IN      001h
	ANI     010h
	MOV  E, A
L_04BB: IN      001h
	ANI     010h
	CMP  E
	JZ      L_04BB
	RLC
	RLC
	RLC
	RLC
	MOV  A, C
	RAL
	MOV  C, A
	LDA     M_VEF6	; ᪮���� �⥭��
L_04CD: DCR  A
	JNZ     L_04CD
	MOV  A, D
	ORA  A
	JP      L_04EF
	MOV  A, C
	CPI     0E6h	; ᨭ�஡���
	JNZ     L_04E3
	XRA  A
	STA     M_VEF4	; �몫. ������஢���� ᨣ����
	JMP     L_04ED
;
L_04E3: CPI     019h	; ᨭ�஡��� � �����ᨨ
	JNZ     L_04B6
	MVI  A, 0FFh
	STA     M_VEF4	; ���. ������஢���� ᨣ����
L_04ED: MVI  D, 009h
L_04EF: DCR  D
	JNZ     L_04B6
	LDA     M_VEF4	; ????
	XRA  C
	POP  D
	POP  B
	RET
;
;==========================================================
L_04FA:	XRA  A		; << �஢�ઠ ������ ��
L_04FB:	STA     M_DSK	; �� 10
	LXI  H, 0F800h
	SHLD    M_BKD	; ���� ���� ��� �⥭�� ��⠫��� ��
	XRA  A		; �⠥� ���� ��⠫�� �� � ����
	CALL    L_0586	; �⥭�� ��஦�� 0 ��
	JNZ	L_ERR	; >> �訡�� �⥭�� ��
	MVI  A, 001h
	CALL    L_0586	; �⥭�� ��஦�� 1 ��
	JNZ	L_ERR	; >> �訡�� �⥭�� ��
L_NAME:	CALL    L_0524	; �஢�ઠ �� ᮢ������� ����� � "OS.COM"
	RZ		; >> ᮢ����, ��室�� � Z=1 � HL=��뫪� �� ᯨ᮪ ᥪ�஢
	DAD  D		; +10h, ᫥����� ������
	JNC     L_NAME	; �᫨ HL ��� �� ���㫨����, � �饬 �����
L_ERR:	LDA     M_DSK
	ANA  A
	RNZ		; �� 11 � OS.COM �� ������, ������ � Z=0
	INR  A
	JMP     L_04FB	; ����� � �� 11
;
L_0524:	PUSH H		; �� �஢�ન ����� "OS.COM"
	LXI  D, L_053B	; ��뫪� �� ��.���
	MVI  C, 00Ch	; ����稪
L_052A: LDAX D
	CMP  M
	JNZ     L_0535	; >> �� ᮢ����
	INX  D
	INX  H
	DCR  C
	JNZ     L_052A	; 横�
L_0535: POP  H
	LXI  D, 00010h
	DAD  D		; �����頥� ��뫪� �� ᯨ᮪ �४�� 䠩��
	RET
;
L_053B:	.db 000h
	.db "OS      COM"
;
L_0547:	PUSH H		; <<< ����㧪� � ��, HL=��뫪� �� ᯨ᮪ ᥪ�஢ OS.COM
	LXI  H, L_073C	; ���⨭�� ��
	CALL    L_016D	; ���⨭��
	LXI  H, 00100h
	SHLD    M_BKD 	; ���� ���� ��� �⥭�� ��
	MOV  B, L	; B = 0
	POP  H
L_0556:	MVI  C, 010h	; <<<---- 横� �� ������ ��஦��
	DCX  H
	MOV  A, M	; �᫮ ᥪ�஢ �� ����� ��४�ਨ
	INX  H
	ANA  A		; ��� �ਧ���� [�] (�� ��直� ��砩)
	RAR		; /2
	ADC  B		; A = A+B+[C]
	MOV  B, A	; B = ������⢮ ������
L_0558:	MOV  A, M
	ORA  A
	JZ      L_0572	; >> ��⮢�
	CALL    L_0586	; �⥭�� �४�
	JNZ     L_KDER	; -> �訡�� �⥭��!
;	MVI  A, 004h
;	ADD  B
;	MOV  B, A	; ���-�� ������ +4
	INX  H
	DCR  C
	JNZ     L_0558
	CALL    L_0524	; �⥭�� ᫥��饩 ����� ��⠫��� ��, == "OS.COM"?
	JZ      L_0556	; ��� ����, ��㧨� �����
L_0572:	MOV  D, B	; D = ���-�� ����㦥���� ������
	LXI  H, 00100h	; ���� ��砫�
	JMP     L_FBLK
;
L_KDER:	LXI  H, 0D7E2h	; ��⮥ ����
	LXI  D, 0D8E2h
	MVI  A, 002h	; �᫮ �⮫�殢
	MVI  B, 08Ch	; ���� ���⨭��
	CALL    L_0174	; <<< �� ���ᮢ�� ���⨭��
	JMP     L_00D4	; ���室 � ����㧪� � ᫥���饣� ���ன�⢠
;
	; �� �⥭�� ��஦�� �� � ����
	; M_BKD = ���.��砫� ����
	; A = ����� ��஦�� �� (�����뢠���� � M_DKD)
L_0586:	PUSH H
	PUSH B
	LXI  H, 00000h
	DAD  SP
	SHLD    M_VAR1	; ��� �࠭���� 㪠��⥫� �⥪�
	LXI  D, 00380h	; (��� ��ࢮ�� ᥪ��)
	STA     M_DKD	; ��࠭塞 ����� ��஦�� ��
	CMA		; ������� �
	CPI     0FCh
	JNC     L_EKR	; �᫨ � >= FCh
	SUI     010h	; � := � - 10h
L_EKR:	SUI     004h	; � := � - 04h
	MOV  L, A
	ADD  A		;
	ADD  A		;
	MOV  H, A	; H := � * 4
	MOV  A, L	; ����. �
	MVI  L, 000h	; L := 0
	DAD  D		; HL := HL + DE = HL - 020h
	STC		; (��⠭���� ��७�� =1)
	RAR		; (������᪨� ᤢ�� ��ࠢ� �१ ��७��)
	RRC		; (ᤢ�� ��ࠢ�)
	RRC
	RRC
	ANI     01Ch	; ��᪨�㥬 2,3 � 4 ����
	MOV  B, A	; ��࠭塞 ���䨣���� ��
	MVI  A, 001h
	DI		;
L_LPKD:	SHLD    M_RKD	; ���� ��砫� ᥪ�� �� ��
	STA     M_SKD	; ����� ᥪ�� �� ��஦�� ��
	LDA     M_DSK
	ANA  A		; �ਧ��� Z �� ������ ��
	MOV  A, B
	JNZ     L_KD11
	OUT     010h	; ������砥� �� 10
	JMP     L_KD10
L_KD11: OUT     011h	; ������砥� �� 11
L_KD10:	SPHL		; �⥪ �� ���� �⥭��
	LHLD    M_BKD	; �㤠 ��࠭���
	XRA  A
	MVI  C, 020h	; ����稪, 20h*4 = 128 ����
L_05CE:	POP  D		; �⠥� � DE
	ADD  E
	ADD  D		; A:= A+E+D (�����.�㬬�)
	MOV  M, E
	INX  H
	MOV  M, D
	INX  H
	POP  D		; �⠥� 2 � DE
	ADD  E
	ADD  D
	MOV  M, E
	INX  H
	MOV  M, D
	INX  H
	DCR  C
	JNZ     L_05CE	; 横� ����஢���� ᥪ�� (128 ����)
	SHLD    M_BKD	; ��࠭塞 ���� ���� ���� ��� �⥭�� ��
	; �஢�ઠ ����஫쭮� �㬬�
	MOV  C, A	; C = ����஫쭠� �㬬�
	LDA     M_DSK
	ANA  A		; �ਧ��� Z �� ������ ��
	MVI  A, 01Fh	; 0001 1111 -- ���� 0 ��� ����
	JNZ     L_KK11
	OUT     010h	; ��ࠢ�塞 �� �������� 10
	JMP     L_KK10
L_KK11: OUT     011h	; ������砥� �� 11
	; ����塞 ���� ��
L_KK10:	LDA     M_DKD	; ����� ��஦�� ��
	MOV  L, A
	MVI  H, 00Fh
	DAD  H
	DAD  H
	DAD  H
	DAD  H
	LDA     M_SKD	; ����� ᥪ�� ��
	DCR  A
	ADD  A
	ADD  L
	MOV  L, A
	SPHL
	POP  D		; ���뢠�� ��
	MOV  A, E
	CMP  D
	JNZ     L_KCER	; >> �� ��⠭� � �訡���, ��室 �� ��
	CMP  C
	JNZ     L_KCER	; >> �� �� ᮢ����, ��� ����, ��室 �� ��
	LHLD    M_RKD	; ���� ��砫� ᥪ��
	LXI  D, 0FF80h	; DE = -80h
	DAD  D		; HL = ���� ���� ��砫� ᥪ��
	LDA     M_SKD	; ����� ᥪ�� ��
	INR  A
	CPI     009h
	JNZ     L_LPKD
	LDA     M_DSK
	ANA  A		; �ਧ��� Z �� ������ ��
	JNZ     L_KX11
	OUT     010h	; �⪫�砥� �� 10
	JMP     L_DONE
L_KX11:	XRA  A		; Z=1
	OUT     011h	; �⪫�砥� �� 11
L_DONE:	LHLD    M_VAR1
	SPHL		; ����⠭�������� 㪠��⥫� �⥪�
	EI
	POP  B
	POP  H
	RET		; >>> ��室, Z=0 �� �訡��
;
L_KCER:	LDA     M_DSK
	ANA  A		; �ਧ��� Z �� ������ ��
	JNZ     L_KY11
	OUT     010h	; �⪫�砥� �� 10
	INR  A		; Z=0
	JMP     L_DONE
L_KY11:	MVI  A, 000h	; Z=0
	OUT     011h	; �⪫�砥� �� 11
	JMP     L_DONE
;
;==========================================================
; �஢�ઠ ������ HDD � ���
L_RES:	MVI  A, 010h	; ��� �� �㫥��� 樫����
	OUT     057h	; ������: ॣ���� �������
L_RDY:	LXI  B, 00000h	; B = 0000h -- ����稪
L_LOOP:	IN      057h	; ॣ���� �����
	ANI     0C0h	; 1100 0000
	CPI     040h
	RZ		; > ��室 �� ��
	DCX  B
	MOV  A, B
	ORA  C
	JNZ     L_LOOP	; 横� �� 65536 ����⮪
	RET		; >>>> ����� ���, ��� (A = 0)
;
; �஢�ઠ ������ ����, ���. Z = 1 -- ��� ��.
L_CHDD:	IN      057h	; ॣ���� ����� ����
	INR  A		; �᫨ � <> FFh
	CNZ     L_RES	; ��� � �������� ��⮢���� ����
	CPI     040h
	RNZ		; >> ��� �⪫��� �� ����
	LXI  H, B_DRV	; �㤠 ����
	MVI  C, 001h	; ᪮�쪮 ᥪ�஢ ����
	CALL    L_RHDD	; �⥭�� � ����
L_CHBT:	LXI  H, B_DRV	; <<<<< �� �஢�ન ����㧮筮�� ᥪ��
	LXI  D, M_BT
	MVI  C, 01Fh
	MVI  A, 066h
L_CBT1:	ADD  M
	MOV  B, A
	MOV  A, M
	STAX D
	INX  H
	INX  D
	DCR  C
	MOV  A, B
	JNZ     L_CBT1	; 横� ������� �� � ����஢�����
	SUB  M
	RNZ		; �� �� ᮢ���� -- ��室 (Z=0)
	LDA     M_SKB	; ������⢮ ᥪ�஢ (1�) �� ����㧪�
	DCR  A
	RM		; ��室, �᫨ A < 0 (� Z=0)
	XRA  A
	RET		; ��室 (Z=1)
;
; �� ��⠭���� ��ࠬ��஢ ����㧪�
L_SETB:	LXI  D, 0FF80h	; (-80h)
	LHLD    M_BT	; ���뢠�� ��砫�� ����
	DAD  D		; ���ࠢ�� �� ᬥ饭�� ������
	LDA     M_SKB	; (᪮�쪮 ������/4 �ணࠬ�� � ���.������)
	MOV  B, A	; ��� ����
	ADD  A
	MOV  C, A	; �᫮ ᥪ�஢ ���� = ������/4 * 2 (��� L_RHDD)
	ADD  A
	MOV  D, A	; D = �᫮ ������ ��� �⮡ࠦ���� (�� 256 ����)
	RET
;
; �� ����㧪� � ���⪣� ��᪠
;
L_067B:	LXI  H, L_078E	; ��뫪� �� ���⨭�� � ��᪮�
	CALL    L_016D	; ��㥬...
	DI
	CALL    L_RES	; ��� � �������� ��⮢���� ����
	CALL    L_SETB	; �⥭�� ��ࠬ��஢ ����㧪�
	CALL    L_RHDD
L_DDN:	LHLD    M_BT	; ���뢠�� ��砫�� ����
L_FBLA:	MVI  A, 0FCh
	ANA  L
	ORA  H		; ��砫�� ���� ����� 0003h
	JZ      L_FBL2	; ������塞 ����� � ⠡��� c JMP addr(HL)
L_FBLK:	MVI  A, 0C3h	; =JMP		<<<<<<<<<<<<<<<<<
	STA     00000h
	SHLD    00001h
L_FBL2:	MVI  L, 000h	; ����塞 ��� �ࠢ��쭮� ���ᮢ�� ������
L_FBL1:	CALL    L_015A	; >> ���������� �����,  << D=������⢮ ������
	INR  H
	DCR  D
	JNZ     L_FBL2
	RET
;
L_RHDD:	XRA  A
	OUT     054h	; LBA [15..8]
	OUT     055h	; LBA [23..16]
	MVI  A, 002h	; ᥪ�� �2
	OUT     053h	; LBA [7..0]
	MVI  A, 0E0h	; 1110 0000
	OUT     056h	; ०�� � LBA[27..24]
	MOV  A, C
	OUT     052h	; ���稪 �᫠ ᥪ�஢ ��� ����樨 �⥭��/�����
	MVI  A, 020h	; 2xH = ᥪ�� �⥭�� (x = retry and ECC-read)
	OUT     057h	; ������:	ॣ���� �������
	CALL    L_RDY	; �������� ��⮢���� ����
L_RLP:	IN      057h	; ॣ���� �����
	ANI     008h	; 0000 1000 :	����� ������. ���� ���� ������ (�����)
	RZ		; >>> RET � ��砥 �訡�� ��� ����砭�� �⥭��
	IN      050h	; ������� ������. �⥭�� ������ � ����
	MOV  M, A
	INX  H
	IN      058h	; ������� ������. �⥭�� ������ � ����
	MOV  M, A
	INX  H
	JMP     L_RLP
;
;==========================================================
L_06CB:	.db 008h	; ����
	.db 0F3h	; - |����  ��| ������-06�.24
	.db 0DBh	; - |�� �� ��|
	.db 0DBh	; - |�� �� ��|
	.db 0DBh	; - |�� �� ��|
	.db 0F3h	; - |����  ��|
	.db 0DBh	; - |�� �� ��|
	.db 0DBh	; - |�� �� ��|
	.db 0F3h	; - |����  ��|
;
	.db 0DBh	; - |�� �� ��|
	.db 01Bh	; - |   �� ��|
	.db 01Bh	; - |   �� ��|
	.db 01Ah	; - |   �� � |
	.db 09Ch	; - |�  ���  |
	.db 01Ah	; - |   �� � |
	.db 01Bh	; - |   �� ��|
	.db 0DBh	; - |�� �� ��|
;
	.db 018h	; - |   ��   |
	.db 018h	; - |   ��   |
	.db 018h	; - |   ��   |
	.db 018h	; - |   ��   |
	.db 018h	; - |   ��   |
	.db 018h	; - |   ��   |
	.db 05Ah	; - | � �� � |
	.db 07Eh	; - | ������ |
;
	.db 073h	; - | ���  ��|
	.db 0DBh	; - |�� �� ��|
	.db 0DBh	; - |�� �� ��|
	.db 0DBh	; - |�� �� ��|
	.db 0DBh	; - |�� �� ��|
	.db 0DBh	; - |�� �� ��|
	.db 0DBh	; - |�� �� ��|
	.db 073h	; - | ���  ��|
;
	.db 000h	; - |        |
	.db 001h	; - |       �|
	.db 0C1h	; - |��     �|
	.db 06Dh	; - | �� �� �|
	.db 06Dh	; - | �� �� �|
	.db 061h	; - | ��    �|
	.db 061h	; - | ��    �|
	.db 0C0h	; - |��      |
;
	.db 0E3h	; - |���   ��|
	.db 0B6h	; - |� �� �� |
	.db 0B6h	; - |� �� �� |
	.db 0B6h	; - |� �� �� |
	.db 0B7h	; - |� �� ���|
	.db 0B6h	; - |� �� �� |
	.db 0B6h	; - |� �� �� |
	.db 0E3h	; - |���   ��|
;
	.db 083h	; - |�     ��|
	.db 0DFh	; - |�� �����|
	.db 0D6h	; - |�� � �� |
	.db 0D6h	; - |�� � �� |
	.db 096h	; - |�  � �� |
	.db 016h	; - |   � �� |
	.db 0D6h	; - |�� � �� |
	.db 096h	; - |�  � �� |
;
	.db 06Fh	; - | �� ����|
	.db 06Ch	; - | �� ��  |
	.db 00Ch	; - |    ��  |
	.db 007h	; - |     ���|
	.db 001h	; - |       �|
	.db 00Dh	; - |    �� �|
	.db 00Dh	; - |    �� �|
	.db 007h	; - |     ���|
;
	.db 086h	; - |�    �� |
	.db 086h	; - |�    �� |
	.db 03Eh	; - |  ����� |
	.db 036h	; - |  �� �� |
	.db 0B6h	; - |� �� �� |
	.db 096h	; - |�  � �� |
	.db 08Eh	; - |�   ��� |
	.db 006h	; - |     �� |
;
L_0714:	.db 00Dh	; ����
	.db 03Fh	; - |  ������| ���⨭�� ������
	.db 0ABh	; - |� � � ��|
	.db 0BFh	; - |� ������|
	.db 0C0h	; - |��      |
	.db 0FFh	; - |��������|
	.db 0EFh	; - |��� ����|
	.db 0C4h	; - |��   �  |
	.db 0ECh	; - |��� ��  |
	.db 0FFh	; - |��������|
	.db 0FFh	; - |��������|
	.db 080h	; - |�       |
	.db 0C0h	; - |��      |
	.db 07Fh	; - | �������|
;
	.db 0FCh	; - |������  |
	.db 0D5h	; - |�� � � �|
	.db 0FDh	; - |������ �|
	.db 003h	; - |      ��|
	.db 0FFh	; - |��������|
	.db 0F7h	; - |���� ���|
	.db 023h	; - |  �   ��|
	.db 037h	; - |  �� ���|
	.db 0FFh	; - |��������|
	.db 0FFh	; - |��������|
	.db 001h	; - |       �|
	.db 003h	; - |      ��|
	.db 0FEh	; - |������� |
;
	.db 07Ch	; - | �����  |
	.db 050h	; - | � �    |
	.db 040h	; - | �      |
	.db 07Ch	; - | �����  |
	.db 020h	; - |  �     |
	.db 010h	; - |   �    |
	.db 020h	; - |  �     |
	.db 07Ch	; - | �����  |
	.db 000h	; - |        |
	.db 024h	; - |  �  �  |
	.db 054h	; - | � � �  |
	.db 054h	; - | � � �  |
	.db 038h	; - |  ���   |
;
L_073C:	.db 08Ch	; ����, +80h -- 㤢����� ��ப
	.db 00Fh	; - |    ����| ���⨭�� ��
	.db 0FFh	; - |��������|
	.db 080h	; - |�       |
	.db 092h	; - |�  �  � |
	.db 080h	; - |�       |
	.db 092h	; - |�  �  � |
	.db 080h	; - |�       |
	.db 092h	; - |�  �  � |
	.db 080h	; - |�       |
	.db 092h	; - |�  �  � |
	.db 080h	; - |�       |
	.db 0FFh	; - |��������|
;
	.db 0F0h	; - |����    |
	.db 0FFh	; - |��������|
	.db 001h	; - |       �|
	.db 049h	; - | �  �  �|
	.db 001h	; - |       �|
	.db 049h	; - | �  �  �|
	.db 001h	; - |       �|
	.db 049h	; - | �  �  �|
	.db 001h	; - |       �|
	.db 049h	; - | �  �  �|
	.db 001h	; - |       �|
	.db 0FFh	; - |��������|
;
L_0755:	.db 08Ah	; ����, +80h -- 㤢����� ��ப
	.db 0FFh	; - |��������| ���⨭�� ��᪥��
	.db 0FEh	; - |������� |
	.db 0FEh	; - |������� |
	.db 0FFh	; - |��������|
	.db 0FCh	; - |������  |
	.db 0FCh	; - |������  |
	.db 0FFh	; - |��������|
	.db 081h	; - |�      �|
	.db 081h	; - |�      �|
	.db 0FFh	; - |��������|
;
	.db 0FFh	; - |��������|
	.db 07Fh	; - | �������|
	.db 07Fh	; - | �������|
	.db 0FFh	; - |��������|
	.db 03Fh	; - |  ������|
	.db 03Fh	; - |  ������|
	.db 0FFh	; - |��������|
	.db 0FEh	; - |������� |
	.db 0FFh	; - |��������|
	.db 0FFh	; - |��������|
;
L_076A:	.db 087h	; ����, +80h -- 㤢����� ��ப
	.db 055h	; - | � � � �| ���⨭�� 稯�
	.db 0FFh	; - |��������|
	.db 0C0h	; - |��      |
	.db 0C7h	; - |��   ���|
	.db 0C0h	; - |��      |
	.db 0FFh	; - |��������|
	.db 055h	; - | � � � �|
;
	.db 054h	; - | � � �  |
	.db 0FFh	; - |��������|
	.db 003h	; - |      ��|
	.db 0C6h	; - |��   �� |
	.db 003h	; - |      ��|
	.db 0FFh	; - |��������|
	.db 054h	; - | � � �  |
;
L_0779:	.db 08Ah	; ����, +80h -- 㤢����� ��ப
	.db 0C1h	; - |��     �| ���⨭�� ��
	.db 020h	; - |  �     |
	.db 00Fh	; - |    ����|
	.db 001h	; - |       �|
	.db 007h	; - |     ���|
	.db 0E4h	; - |���  �  |
	.db 004h	; - |     �  |
	.db 007h	; - |     ���|
	.db 020h	; - |  �     |
	.db 0C1h	; - |��     �|
;
	.db 083h	; - |�     ��|
	.db 004h	; - |     �  |
	.db 0F0h	; - |����    |
	.db 080h	; - |�       |
	.db 0E0h	; - |���     |
	.db 027h	; - |  �  ���|
	.db 020h	; - |  �     |
	.db 0E0h	; - |���     |
	.db 004h	; - |     �  |
	.db 083h	; - |�     ��|
;
L_078E:	.db 00Fh	; ����
	.db 0FFh	; - |��������| ���⨭�� ���
	.db 0B0h	; - |� ��    |
	.db 0E0h	; - |���     |
	.db 0C0h	; - |��      |
	.db 0C0h	; - |��      |
	.db 080h	; - |�       |
	.db 086h	; - |�    �� |
	.db 086h	; - |�    �� |
	.db 087h	; - |�    ���|
	.db 081h	; - |�      �|
	.db 0C1h	; - |��     �|
	.db 0C0h	; - |��      |
	.db 0E0h	; - |���     |
	.db 0B0h	; - |� ��    |
	.db 0FFh	; - |��������|
;
	.db 0FFh	; - |��������|
	.db 0F3h	; - |����  ��|
	.db 061h	; - | ��    �|
	.db 021h	; - |  �    �|
	.db 043h	; - | �    ��|
	.db 047h	; - | �   ���|
	.db 08Fh	; - |�   ����|
	.db 09Fh	; - |�  �����|
	.db 03Fh	; - |  ������|
	.db 05Fh	; - | � �����|
	.db 0BFh	; - |� ������|
	.db 03Fh	; - |  ������|
	.db 07Fh	; - | �������|
	.db 0FDh	; - |������ �|
	.db 0FFh	; - |��������|
;
L_07AD:	LXI  D, F4_LEN	; ࠧ��� << ������ �㯥�������
	LXI  B, F4_PRG	; ��㤠
	JMP     L_07CE
;
L_07B6:	CALL    L_0846	; << ����㧪� ����� ���㧪� ������ �१ �� (� ������)
	JNZ     L_042B	; >> ����㧪� � ������䮭�
	LXI  D, 001DAh	; ࠧ��� + 100h
	LXI  B, L_08D0	; ��㤠
	LXI  H, 09300h	; �㤠
	JMP     L_07D9
;
L_07C8:	LXI  D, F3_LEN	; ࠧ��� << ���ᨪ
	LXI  B, F3_PRG	; ��㤠
L_07CE:	LXI  H, 00100h	; �㤠
	MVI  A, 0C3h
	STA     00000h
	SHLD    00001h
L_07D9:	PUSH H
	PUSH B
	CALL    L_07F0	; ���ᮢ�� ���⨭�� 稯�
	POP  B
	POP  H
L_07E0:	LDAX B		; �⠥� ����
	MOV  M, A	; ��襬
	INX  B
	INR  L
	JNZ     L_07E0
	CALL    L_015A	; >> ���������� �����
	INR  H
	DCR  D
	JNZ     L_07E0	; 横� ��७�� ������
	RET
;
L_07F0:	LXI  H, L_076A	; ���⨭�� 稯�
;	MVI  A, 087h
	PUSH D
	CALL    L_016D	; ���ᮢ��
	POP  D
	RET
;
;==========================================================
L_07F9:	LXI  H, 07FFEh	; << ��� ���
	LXI  D, 000FFh
L_07FF:	MOV  A, M
	XRA  D
	MOV  D, A
	DCX  H
	MOV  A, H
	CMP  E
	JNZ     L_07FF	; 横� ������� ��
	LDA     07FFFh	; �� � ���
	XRA  D
	JZ      L_00F6	; >> ��� ��! (RZ)
	MOV  A, D
	OUT  006h       ; ���� (B) �� -- �뢮� ��
	MVI  A, 7
	OUT     002h	; � ���� B -- 梥� ����� (�����)
L_0816:	JMP     L_0816	; �᫨ ��� -- ��横��������...
;
;==========================================================
L_0819:	LXI  H, 000C3h	; << ॠ������ 0 ����� ������ (०�� ����㧪� ��⥪������)
	SHLD    00000h
	SHLD    00005h
	MVI  H, 076h	;	LXI  H, 076C3h	; !!
	SHLD    00038h
	CALL    L_0846
	LXI  H, 00002h	; !!
	JNZ     L_083B
	MVI  M, 0F8h
	MVI  L, 007h
	MVI  M, 094h
	MVI  L, 03Ah
	MVI  M, 0FDh
	RET
;
L_083B:	MVI  M, 078h
	MVI  L, 007h
	MVI  M, 054h
	MVI  L, 03Ah
	MVI  M, 07Dh
	RET
;
L_0846:	LXI  H, 09400h
	MOV  A, M
	CPI     0C3h
	RNZ
	INX  H
	MOV  A, M
	CPI     003h
	RNZ
	INX  H
	MOV  A, M
	CPI     094h
	RET
;
;==========================================================
L_0857:	LXI  H, L_0779	; ���⨭�� ��	; << ����㧪� �� �� �१ ����� ��-LPT
	CALL    L_016D	; ���ᮢ�� ���⨭��
	MVI  A, 082h
	OUT     004h
	MVI  A, 010h
	OUT     005h
	XRA  A
	MOV  L, A
	MOV  C, A
	CALL    L_089D
	MOV  A, E
	CPI     055h
	JNZ     L_0000
	CALL    L_089D
	MOV  A, E
	CPI     0AAh
	JNZ     L_0000
	CALL    L_089D
	MOV  H, E
	CALL    L_089D
	MOV  A, H
	ADD  E
	MOV  B, A
L_0884:	CALL    L_089D
	MOV  M, E
	MOV  A, C
	XRA  E
	MOV  C, A
	XRA  A
	ORA  L		; L = 00h?
	CZ      L_015A	; >> ���������� �����
	INX  H
	MOV  A, H
	CMP  B
	JNZ     L_0884
	CALL    L_089D
	MOV  A, E
	CMP  C
	RZ
	RST  0
L_089D:	MVI  D, 000h
L_089F:	IN      006h
	ANI     020h
	JZ      L_089F
	MOV  A, D
	ANA  A
	JNZ     L_08B4
	IN      006h
	ANI     00Fh
	MOV  E, A
	INR  D
	JMP     L_08C0
;
L_08B4:	IN      006h
	ANI     00Fh
	RLC
	RLC
	RLC
	RLC
	ORA  E
	MOV  E, A
	MVI  D, 000h
L_08C0:	XRA  A
	OUT     005h
L_08C3:	IN      006h
	ANI     020h
	JNZ     L_08C3
	MVI  A, 010h
	OUT     005h
	MOV  A, D
	ANA  A
	JNZ     L_089F
	RET
;
;===============================================================
; ����� ���㧪� ������ �१ �� ��� ������
				;		.org 09300h
L_08D0:	.db 021h,0BAh,093h	;L_9300:	LXI  H, L_93BA
	.db 0CDh,018h,0F8h	;		CALL    0F818h
	.db 03Eh,082h		;		MVI  A, 082h
	.db 0D3h,004h		;		OUT     004h
	.db 03Eh,010h		;		MVI  A, 010h
	.db 0D3h,005h		;		OUT     005h
	.db 021h,0D9h,093h	;		LXI  H, L_93D9
	.db 046h		;		MOV  B, M
	.db 00Eh,0FFh		;		MVI  C, 0FFh
	.db 02Bh		;		DCX  H
	.db 066h		;		MOV  H, M
	.db 0AFh		;		XRA  A
	.db 06Fh		;		MOV  L, A
	.db 032h,0DAh,093h	;		STA     L_93DA
	.db 01Eh,055h		;		MVI  E, 055h
	.db 0CDh,078h,093h	;		CALL    L_9378
	.db 01Eh,0AAh		;		MVI  E, 0AAh
	.db 0CDh,078h,093h	;		CALL    L_9378
	.db 05Ch		;		MOV  E, H
	.db 0CDh,078h,093h	;		CALL    L_9378
	.db 058h		;		MOV  E, B
	.db 0CDh,078h,093h	;		CALL    L_9378
	.db 05Eh		;L_932D:	MOV  E, M
	.db 03Ah,0DAh,093h	;		LDA     L_93DA
	.db 0ABh		;		XRA  E
	.db 032h,0DAh,093h	;		STA     L_93DA
	.db 0CDh,078h,093h	;		CALL    L_9378
	.db 07Dh		;		MOV  A, L
	.db 0FEh,000h		;		CPI     000h
	.db 0C2h,045h,093h	;		JNZ     L_9345
	.db 0C5h		;		PUSH B
	.db 00Eh,02Eh		;		MVI  C, 02Eh
	.db 0CDh,009h,0F8h	;		CALL    0F809h
	.db 0C1h		;		POP  B
	.db 023h		;L_9345:	INX  H
	.db 00Bh		;		DCX  B
	.db 078h		;		MOV  A, B
	.db 0FEh,000h		;		CPI     000h
	.db 0C2h,02Dh,093h	;		JNZ     L_932D
	.db 03Ah,0DAh,093h	;		LDA     L_93DA
	.db 05Fh		;		MOV  E, A
	.db 0CDh,078h,093h	;		CALL    L_9378
	.db 021h,0D5h,093h	;		LXI  H, L_93D5
	.db 0CDh,018h,0F8h	;		CALL    0F818h
	.db 03Ah,0D8h,093h	;		LDA     L_93DA
	.db 047h		;		MOV  B, A
	.db 0CDh,015h,0F8h	;		CALL    0F815h
	.db 021h,0CCh,093h	;		LXI  H, L_93CC
	.db 0CDh,018h,0F8h	;		CALL    0F818h
	.db 03Ah,0D9h,093h	;		LDA     L_93D9
	.db 080h		;		ADD  B
	.db 03Dh		;		DCR  A
	.db 0CDh,015h,0F8h	;		CALL    0F815h
	.db 021h,0D2h,093h	;		LXI  H, L_93D2
	.db 0CDh,018h,0F8h	;		CALL    0F818h
	.db 0C3h,000h,0F8h	;		JMP     0F800h
				;
	.db 07Bh		;L_9378:	MOV  A, E
	.db 0E6h,00Fh		;		ANI     00Fh
	.db 057h		;		MOV  D, A
	.db 0DBh,005h		;		IN      005h
	.db 0E6h,0F0h		;		ANI     0F0h
	.db 0B2h		;		ORA  D
	.db 0D3h,005h		;		OUT     005h
	.db 016h,001h		;		MVI  D, 001h
	.db 0C3h,099h,093h	;		JMP     L_9399
				;
	.db 07Bh		;L_9388:	MOV  A, E
	.db 0E6h,0F0h		;		ANI     0F0h
	.db 007h		;		RLC
	.db 007h		;		RLC
	.db 007h		;		RLC
	.db 007h		;		RLC
	.db 057h		;		MOV  D, A
	.db 0DBh,005h		;		IN      005h
	.db 0E6h,0F0h		;		ANI     0F0h
	.db 0B2h		;		ORA  D
	.db 0D3h,005h		;		OUT     005h
	.db 016h,000h		;		MVI  D, 000h
	.db 0DBh,005h		;L_9399:	IN      005h
	.db 0E6h,0EFh		;		ANI     0EFh
	.db 0D3h,005h		;		OUT     005h
	.db 0DBh,006h		;L_939F: 	IN      006h
	.db 0E6h,020h		;		ANI     020h
	.db 0CAh,09Fh,093h	;		JZ      L_939F
	.db 0DBh,005h		;		IN      005h
	.db 0F6h,010h		;		ORI     010h
	.db 0D3h,005h		;		OUT     005h
	.db 0DBh,006h		;L_93AC: 	IN      006h
	.db 0E6h,020h		;		ANI     020h
	.db 0C2h,0ACh,093h	;		JNZ     L_93AC
	.db 07Ah		;		MOV  A, D
	.db 0FEh,000h		;		CPI     000h
	.db 0C2h,088h,093h	;		JNZ     L_9388
	.db 0C9h		;		RET
				;
	.db 00Ah	; <_>	;L_93BA:
	.db 00Dh	; <_>
	.db 077h	; <w>
	.db 079h	; <y>
	.db 077h	; <w>
	.db 06Fh	; <o>
	.db 064h	; <d>
	.db 020h	; < >
	.db 064h	; <d>
	.db 061h	; <a>
	.db 06Eh	; <n>
	.db 06Eh	; <n>
	.db 079h	; <y>
	.db 068h	; <h>
	.db 00Ah	; <_>
	.db 00Dh	; <_>
	.db 03Eh	; <>>
	.db 000h	; <_>
	.db 030h	; <0>	;L_93CC:
	.db 030h	; <0>
	.db 048h	; <H>
	.db 00Ah	; <_>
	.db 00Dh	; <_>
	.db 000h	; <_>
	.db 046h	; <F>	;L_93D2:
	.db 046h	; <F>
	.db 048h	; <H>
	.db 00Ah	; <_>
	.db 00Dh	; <_>
	.db 000h	; <_>
	.db 001h	; <_>	;L_93D8:
	.db 001h	; <_>	;L_93D9:
	.db 0FFh	; <�>	;L_93DA:
;
;----------------------------------------
L_FM9:	LXI  H, L_0714	; << ����㧪� � ������䮭� FM9
	MVI  A, 003h	; 3 �⮫��
	CALL    L_016F	; ���ᮢ�� ���⨭��
	LXI  H, M_FM9l	; �㤠
	LXI  D, FM9_PP	; ��㤠
L_FM91:	LDAX D
	MOV  M, A
	INX  D
	INR  L
	JNZ     L_FM91	; 横� ��ॡ�᪨ ����ணࠬ�� FM9
L_FM92:	CALL    L_FM9A
	CALL    L_FM9B
	CPI     046h	; "F"
	JNZ     L_FM92
	CALL    L_FM9B
	CPI     04Dh	; "M"
	JNZ     L_FM92
	CALL    L_FM9B
	CPI     039h	; "9"
	JNZ     L_FM92
	CALL    L_FM9B
	STA     X_E053+1
	MVI  C, 00Bh
L_FM93:	CALL    L_FM9B
	DCR  C
	JNZ     L_FM93
	CALL    L_FM9B
;;;	ORA  A		; �ࠫ �⮡� ����� �뫮 ��㧨�� �ணࠬ�� � �㫥���� ����
;;;	JZ      L_FM92
	MOV  L, A
	MVI  H, 0DEh
	MVI  M, 01Bh
	CALL    L_FM9B
	MOV  B, A
	ADD  L
	DCR  A
	MOV  C, L
	MOV  L, A
	MVI  M, 01Bh
	MOV  H, C
	XRA  A
	STA     X_E0D8+1
	MOV  L, A
	MOV  C, A
	CALL    M_FM9l
	PUSH H		; ��砫�� ����
	ORA  A
	JZ     L_FM9y
	PUSH H
	PUSH B		; ������⢮ ����
L_FM9z:	MOV  A, M	; 横� �����ᨨ ������
	CMA
	MOV  M, A
	INX  H
	DCR  C
	JNZ     L_FM9z
	DCR  B
	JNZ     L_FM9z
	POP  B
	POP  H
L_FM9y:	MVI  D, 0DEh	; ���� �������� ����㧪� FM9
	MOV  E, H
	MOV  L, H
	MVI  H, 0DDh	; ��㤠 �㤥� ����஢���
	MOV  A, M
	STAX D
	MOV  A, L
	ADD  B
	DCR  A
	MOV  E, A
	MOV  L, A
	MOV  A, M
	STAX D
	INR  D
L_FM9x:	STAX D
	DCR  E
	DCR  L
	MOV  A, M
	JNZ     L_FM9x
	STAX D
	MOV  D, B	; ������⢮ ������
	POP  H		; ��砫�� ����
	JMP     L_FBLA	; ���������� ������
;
L_FM9A:	MVI  E, 000h
	IN      001h
	MOV  D, A
L_FM94:	CALL    L_FM9C
	MOV  A, E
	ADC  A
	MOV  E, A
	CPI     0E6h
	JNZ     L_FM94
	RET
;
L_FM9B:	PUSH B
L_FM95:	IN      001h
	CMP  D
	JZ      L_FM95
	MOV  D, A
	XTHL
	XTHL
	CALL    L_FM9C
	MOV  A, A
	CALL    L_FM9D
	CALL    L_FM9E
	CALL    L_FM9E
	CALL    L_FM9E
	CALL    L_FM9E
	CALL    L_FM9E
	CALL    L_FM9E
	MOV  A, E
	ADC  A
	POP  B
	RET
;
L_FM9E:	MOV  A, E
L_FM9D:	ADC  A
	MOV  E, A
L_FM9C:	MVI  B, 000h
L_FM96:	INR  B
	IN      001h
	CMP  D
	JZ      L_FM96
	MOV  D, A
	MVI  A, 005h
	CMP  B
	RET
;
FM9_PP:	.db 0C5h		;	M_FM9l:	PUSH B
	.db 0E5h		;		PUSH H
	.db 0C5h		;	L_E052:	PUSH B
	.db 00Eh,000h		;	X_E053:	MVI  C, 000h
	.db 0CDh		;		CALL    L_FM9A
	.dw L_FM9A
	.db 0DBh,001h		;	L_E058:	IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,058h,0E0h	;		JZ      L_E058
	.db 057h		;		MOV  D, A
	.db 057h		;		MOV  D, A
	.db 006h,000h		;		MVI  B, 000h
	.db 004h		;	L_E062:	INR  B
	.db 0DBh,001h		;		IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,062h,0E0h	;		JZ      L_E062
	.db 057h		;		MOV  D, A
	.db 079h		;		MOV  A, C
	.db 0B8h		;		CMP  B
	.db 07Fh		;		MOV  A, A
	.db 08Fh		;		ADC  A
	.db 05Fh		;		MOV  E, A
	.db 006h,000h		;		MVI  B, 000h
	.db 004h		;	L_E071:	INR  B
	.db 0DBh,001h		;		IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,071h,0E0h	;		JZ      L_E071
	.db 057h		;		MOV  D, A
	.db 079h		;		MOV  A, C
	.db 0B8h		;		CMP  B
	.db 07Bh		;		MOV  A, E
	.db 08Fh		;		ADC  A
	.db 05Fh		;		MOV  E, A
	.db 006h,000h		;		MVI  B, 000h
	.db 004h		;	L_E080:	INR  B
	.db 0DBh,001h		;		IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,080h,0E0h	;		JZ      L_E080
	.db 057h		;		MOV  D, A
	.db 079h		;		MOV  A, C
	.db 0B8h		;		CMP  B
	.db 07Bh		;		MOV  A, E
	.db 08Fh		;		ADC  A
	.db 05Fh		;		MOV  E, A
	.db 006h,000h		;		MVI  B, 000h
	.db 004h		;	L_E08F:	INR  B
	.db 0DBh,001h		;		IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,08Fh,0E0h	;		JZ      L_E08F
	.db 057h		;		MOV  D, A
	.db 079h		;		MOV  A, C
	.db 0B8h		;		CMP  B
	.db 07Bh		;		MOV  A, E
	.db 08Fh		;		ADC  A
	.db 05Fh		;		MOV  E, A
	.db 006h,000h		;		MVI  B, 000h
	.db 004h		;	L_E09E:	INR  B
	.db 0DBh,001h		;		IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,09Eh,0E0h	;		JZ      L_E09E
	.db 057h		;		MOV  D, A
	.db 079h		;		MOV  A, C
	.db 0B8h		;		CMP  B
	.db 07Bh		;		MOV  A, E
	.db 08Fh		;		ADC  A
	.db 05Fh		;		MOV  E, A
	.db 006h,000h		;		MVI  B, 000h
	.db 004h		;	L_E0AD:	INR  B
	.db 0DBh,001h		;		IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,0ADh,0E0h	;		JZ      L_E0AD
	.db 057h		;		MOV  D, A
	.db 079h		;		MOV  A, C
	.db 0B8h		;		CMP  B
	.db 07Bh		;		MOV  A, E
	.db 08Fh		;		ADC  A
	.db 05Fh		;		MOV  E, A
	.db 006h,000h		;		MVI  B, 000h
	.db 004h		;	L_E0BC:	INR  B
	.db 0DBh,001h		;		IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,0BCh,0E0h	;		JZ      L_E0BC
	.db 057h		;		MOV  D, A
	.db 079h		;		MOV  A, C
	.db 0B8h		;		CMP  B
	.db 07Bh		;		MOV  A, E
	.db 08Fh		;		ADC  A
	.db 05Fh		;		MOV  E, A
	.db 006h,000h		;		MVI  B, 000h
	.db 004h		;	L_E0CB:	INR  B
	.db 0DBh,001h		;		IN      001h
	.db 0BAh		;		CMP  D
	.db 0CAh,0CBh,0E0h	;		JZ      L_E0CB
	.db 057h		;		MOV  D, A
	.db 079h		;		MOV  A, C
	.db 0B8h		;		CMP  B
	.db 07Bh		;		MOV  A, E
	.db 08Fh		;		ADC  A
	.db 077h		;		MOV  M, A
	.db 0C6h,000h		;	X_E0D8:	ADI     000h
	.db 032h,0D9h,0E0h	;		STA     X_E0D8+1
	.db 02Ch		;		INR  L
	.db 0C2h,058h,0E0h	;		JNZ     L_E058
	.db 06Ch		;		MOV  L, H
	.db 026h,0DFh		;		MVI  H, 0DFh
	.db 036h,0F0h		;		MVI  M, 0F0h
	.db 065h		;		MOV  H, L
	.db 024h		;		INR  H
	.db 02Eh,000h		;		MVI  L, 000h
	.db 0C1h		;		POP  B
	.db 005h		;		DCR  B
	.db 0C2h,052h,0E0h	;		JNZ     L_E052
	.db 0CDh		;		CALL    L_FM9B
	.dw L_FM9B
	.db 04Fh		;		MOV  C, A
	.db 03Ah,0D9h,0E0h	;		LDA     X_E0D8+1
	.db 0B9h		;		CMP  C
	.db 0C2h,000h,000h	;		JNZ     M_0000
	.db 0CDh		;		CALL    L_FM9B
	.dw L_FM9B
	.db 0E1h		;		POP  H
	.db 0C1h		;		POP  B
	.db 0C9h		;		RET
;
F3_PRG:	;
;L_7FFF:	.db 0??h	; ����஫쭠� �㬬� (offset 7FFFh)
	.END
