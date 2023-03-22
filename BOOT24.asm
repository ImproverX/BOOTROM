S_KBD	.EQU    0DEF7h	; DB ��� ������� ������
M_SP	.EQU    0F800h	; DW 㪠��⥫� �⥪�
M_PP1	.EQU    0DCF1h	; DW ��뫪� �� ����ணࠬ�� 1
M_PP2	.EQU    0DCF4h	; DW ��뫪� �� ����ணࠬ�� 2
M_VAR1	.EQU    0DED0h	; DB/DW ��� �࠭���� 㪠��⥫� �⥪� (��) ��� ��砫� ����㧪�
M_DSK	.EQU	0DED2h	; DB ����� ��
M_DKD	.EQU    0DED3h	; DB ����� ��஦�� ��
M_SKD	.EQU    0DED4h	; DB ����� ᥪ�� ��
M_BKD	.EQU    0DED5h	; DW ���� ���� ��� �⥭�� � ��
M_RKD	.EQU    0DED7h	; DW ���� ��砫� ᥪ�� �� ��
B_HDD	.EQU    0E400h	; ���� ��� �⥭�� ����
M_FM9l	.EQU	0E050h	; ����ணࠬ�� ��� FM9
X_E053	.EQU	0E053h
X_E0D8	.EQU	0E0D8h
;
;F3_PRG			; ���ᨪ 2.63
F3_LEN	.EQU    03300h	; ࠧ���
#DEFINE F4_PRG F3_PRG+F3_LEN	; ������ �㯥������� v3.5
F4_LEN	.EQU    03D00h	; ࠧ��� � ������
#DEFINE FM9_PRG F4_PRG+F4_LEN	; �����稪 FM9
FM9_LEN	.EQU	00180h	; ࠧ���

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
L_0045:	MOV  H, B
	MOV  L, D	; L = 0
	CALL    L_04B4	; ���᫥��� ���न���
	DCR  L		; �� ��ப� ����
	MOV  M, C
	DAD  D		; +9 ��ப
	MOV  M, C
	INR  L		; +1 ��ப�
	MVI  M, 081h
	INR  B		; ����稪
	JNZ     L_0045	; 横� �ᮢ���� ⠡���� ^^^
	LXI  H, L_064D	; ������� ������-06�
	LXI  D, 0C4E9h	; ���� � �࠭�
	MVI  A, 009h	; �᫮ �⮫�殢
	CALL    L_062A	; �뢮� ��㭪� �� �࠭
	LXI  H, L_00DF	; ���� �� ����砭�� ����㧪� ...
	PUSH H		; ... �������� � �⥪
	MVI  A, 0C3h	; � � ��� "JMP"
	STA     M_PP1	; JMP �� ����� 0DCF1h
	STA     M_PP2	; JMP �� ����� 0DCF4h
	CALL    L_0295	; ������ ������� + ���� ����������
	LDA     S_KBD	; ���� ��� ������
	CPI     0FBh	; ������ ��2 / ��+��2 ?
	JZ      L_07A0	; >> ����㧪� �� �� �१ ����� ��-LPT
	CPI     07Fh	; ������ F5 / ��+F5 ?
	JZ      L_00D6	; >> ����㧪� �� �����
	IN      001h
	ANI     040h	; �஢�ઠ ������ ��
	LDA     S_KBD
	JNZ     L_009B	; (�� �� �����)
	CPI     0BFh	; ������ ��+F4
	JZ      L_0761	; >> ॠ������ 0 ����� ������ (०�� ����㧪� ��⥪������)
	CPI     0FDh	; ������ ��+���
	JZ      L_0710	; >> ����㧪� ����� ���㧪� ������ �१ �� (� ������)
	MVI  A, 0F7h	; � ��⠫��� ����� � �� -- ������䮭
L_009B:	CPI     0F7h	; ������ F1 ?
	JZ      L_03BA	; >> ������䮭
	CPI     0EFh	; ������ F2 ?
	JZ      L_00CA	; >> ���⪨� ���
	CPI     0DFh	; ������ F3 ?
	JZ      L_06FE	; >> ���ᨪ
	CPI     0BFh	; ������ F4 ?
	JZ      L_0707	; >> ������ �㯥�������
	CPI     0E7h	; ������ F1+F2 ?
	JZ      L_00C4	; >> ����㧪� � 䫮������
	CPI     0D7h	; ������ F1+F3 ?
	JZ      L_00D0	; >> �⥢�� ������
	CPI     0FEh	; ������ [�����-�����] ?
	JZ      L_FM9	; >> FM9
	CPI     07Bh	; ������ F5+AP2 ?
	JZ      L_074A	; >> ��� ���
	CALL    L_04CD	; �஢�ઠ ������ ��
	JZ      L_050C	; >>> ���室 �� ����㧪� � ��
L_00CA:	CALL    L_CHDD	; �஢�ઠ ������ ���
	JNZ     L_082B	; >>> ���室 �� ����㧪� � ��᪠
L_00C4:	CALL    L_0159	; �஢�ઠ �� in 19 (��᪮���)
	JZ      L_02DB	; >>> ����㧪� � 䫮������
L_00D6:	CALL    L_0128	; �஢�ઠ ������ �����
	JNZ     L_0270	; >>> ����㧪� �� �����
L_00D0:	CALL    L_00FA	; �஢�ઠ ������ �⥢��� ������
	JNZ     L_0164	; >>> ����㧪� �१ �⥢�� ������
	JMP     L_03BA	; >>> ����㧪� � ������䮭�
;
L_00DF: CALL    L_NN	; << ����㧪� ����祭�
        MVI  A, 003h	; ��⠭���� PC[1]=1 (�몫.५�)
        OUT     000h
L_00E6:	EI
	HLT
        INX  B
        MOV  A, C
        ANI     008h
        MVI  A, 007h
        JNZ     L_00F5
        DCR  A
L_00F5: OUT     000h
        JMP     L_00E6	; �������� ���-�����
;
L_0295: EI		; ������ ������� � ���� ����������
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
L_04B4:	PUSH D		; ���᫥��� ���न��� ����㧮筮� ⠡����
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
L_03A9:	PUSH H		; <<< ���������� ������, HL=��砫�
	PUSH B
	CALL    L_04B4	; > ���᫥��� ���न���
	MVI  C, 008h
L_03B0:	MVI  M, 07Eh	; ����窠 �����
	INR  L
	DCR  C
	JNZ     L_03B0
	POP  B
	POP  H
	RET
;
L_0625:	MVI  A, 002h	; �᫮ �⮫�殢   <<< �� ���ᮢ�� ���⨭��
L_0627:	LXI  D, 0D8E2h	;
L_062A:	MOV  B, M	; ���뢠�� ����� ���⨭��  << ������� ������...
	INX  H
L_062D:	STA     0DCF7h
	MVI  A, 07Fh
	ANA  B
	MOV  C, A
	PUSH D
L_0634:	MOV  A, B
	ORA  A		; B >= 80h ?
	MOV  A, M
	STAX D
	INX  D
	JP      L_0641	; �� ������� ����
	STAX D
	INX  D
L_0641:	INX  H
	DCR  C
	JNZ     L_0634
	POP  D
	INR  D
	LDA     0DCF7h
	DCR  A
	JNZ     L_062D
	RET
;
;===================================================================
L_00FA:	MVI  B, 004h	; << �஢�ઠ ������ �⥢��� ������
	IN      007h	; <- ���� � ��
	ORI     0E0h
	MOV  C, A
	MVI  A, 08Bh	; 1000 1011
	OUT     004h	; -> ��� ��
L_0105:	MOV  A, C
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
	JNZ     L_0105	; 横�, 4 ࠧ�
	ORA  A
	JZ      L_NN	; >>> �⥢��� ������ ���
L_0123:	MVI  A, 09Bh	; A,B,C - ����, ०�� 0 (1001 1011)
	OUT     004h	; -> ��� ��
	RET		; >>> �⥢�� ������ �����㦥�
;
L_0128:	MVI  A, 082h	; << �஢�ઠ ������ �����
	OUT     004h	; 1000 0010 -> ���� ��� ��
	MVI  B, 0FFh
L_012E:	MOV  A, B
	OUT     005h	; -> ���� � ��
	MVI  A, 0FEh
	OUT     007h	; -> ���� A ��
	IN      006h	; <- ���� B ��
	CPI     055h
	JNZ     L_014F	; >>> �� ᮢ����
	MVI  A, 0FFh
	OUT     007h	; -> ���� A ��
	IN      006h	; <- ���� B ��
	CPI     0AAh
	JNZ     L_014F	; >>> �� ᮢ����
	MOV  A, B
	ANI     07Fh
	INR  A
	MOV  D, A
;	ORA  A
	RET		; >>> ����� ����
;
L_014F:	MOV  A, B
	SUI     020h
	MOV  B, A
	JM      L_012E
L_NN:	MVI  A, 91h	; B,C (7-4) - �뢮�,  A,C (3-0) - ����
	OUT     004h	; -> ��� ��
	XRA  A
	RET		; >>> ����� ���
;
L_0159:	MVI  A, 00Bh	; << �஢�ઠ ������ 䫮������
	OUT     019h
	MOV  C, A
	XTHL
	XTHL
	IN      019h
	CMP  C
	RET
;
; ---------------------------------------------------------
L_0164:	;CALL    L_0620	; << ����㧪� �१ �⥢�� ������
	LXI  H, L_06D8	; ���⨭�� ��
	CALL    L_0625	; ���ᮢ�� ���⨭��
	LXI  H, L_0232
	SHLD    M_PP1+1	; 0DCF2h
	LXI  H, L_0173
	SHLD    M_PP2+1	; 0DCF5h
L_0173:	CALL    L_0123	; <<<<<<<<<<<<<<< PP2
	IN      007h
	ANI     01Fh
	MOV  C, A
	MVI  B, 00Ah
L_017D:	IN      005h
	ANI     070h
	CPI     040h
	JNZ     L_0173
	IN      006h
	ANI     01Fh
	CMP  C
	JNZ     L_0173
	DCR  B
	JNZ     L_017D
	IN      006h
	MOV  B, A
	MVI  A, 098h
	OUT     004h
	MOV  A, C
	OUT     006h
	XRA  A
	OUT     005h
	MVI  D, 0FAh
L_01A1:	DCR  D
	JZ      L_0173
	IN      005h
	ANI     070h
	CPI     070h
	JNZ     L_01A1
	CALL    L_0123
	MOV  A, B
	ANI     0E0h
	JNZ     L_0173
	MVI  E, 003h
L_01B9:	MVI  A, 008h
	CALL    M_PP1
	CPI     055h
	JZ      L_01C8
	CPI     0AAh
	JNZ     M_PP2
L_01C8:	DCR  E
	JNZ     L_01B9
L_01CC:	CALL    L_0447
	MOV  E, A
	MOV  A, M
	ORA  A
	JNZ     L_01CC
	LXI  H, 0DEF1h
	MOV  A, M
	DCX  H
	CMP  M
	JNZ     M_PP2
	MOV  D, A
	DCX  H
	MOV  B, M
L_01E1:	CALL    L_0447
	PUSH PSW
	MOV  A, M
	ORA  A
	JZ      L_021D
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
	JNZ     L_01E1
	PUSH D
	PUSH B
	INX  H
	LXI  D, 0207Eh	; 7� -- ����窠 �����, 20 -- ����稪
L_01FD:	MOV  A, M
	STAX B
	LDAX B
	XRA  M
	MOV  M, A
	INX  H
	INR  C
	DCR  D
	JNZ     L_01FD
	POP  B
	MOV  L, C
	MOV  H, B
	CALL    L_04B4	; ���᫥��� ���न��� ����㧮筮� ⠡����
	MOV  M, E
	POP  D
	CALL    L_03EC
	JZ      L_01E1
	MOV  A, D
	CPI     001h
	JNZ     L_01E1
	RET
;
L_021D:	POP  PSW
	SUB  E
	JZ      L_01E1
	INR  A
	JNZ     L_0000
	CALL    L_03EC
	JZ      L_0000
	DCR  E
	INR  B
	DCR  D
	JMP     L_01E1
;
L_0232: PUSH D		; <<<<<<<< PP1
        MVI  D, 070h
        CPI     0FFh
        CZ      L_0267
        CALL    L_023F
        POP  D
        RET
;
L_023F: MVI  E, 060h
L_0241: IN      005h
        ANA  D
        CPI     040h
        JZ      L_0000
        CMP  E
        JNZ     L_0241
        IN      006h
        PUSH PSW
        MVI  A, 09Ah
        OUT     004h
        XRA  A
        OUT     005h
L_0257: DCR  E
        JZ      L_0262
        IN      005h
        ANA  D
        CMP  D
        JNZ     L_0257
L_0262: CALL    L_0123
        POP  PSW
        RET
;
L_0267: CALL    L_023F
        CPI     0E6h
        JNZ     L_0267
        RET
;
L_0270:	CALL    L_073F	; ���⨭�� 稯� << ����㧪� �� �����
	LXI  H, 08000h
	MOV  B, L
	MOV  C, L
L_0278:	MOV  A, L
	OUT     007h
	MOV  A, H
	OUT     005h
	IN      006h
	STAX B
	INX  H
	INX  B
	MOV  A, B
	CMP  D
	JNZ     L_0278
	LXI  H, 00000h
	JMP     L_035D	; >> ���������� ������
;L_028B:	CALL    L_03A9	; >> ���������� ������
;	INR  H
;	MOV  A, H
;	CMP  D
;	JNZ     L_028B
;	RET
;
L_02DB:;	MVI  A, 0C3h	; << ����㧪� � 䫮������
;	STA     00000h
;	LXI  H, 00100h	; ���� ��砫�
;	SHLD    00001h
	LXI  H, L_06B6	; ��᪥⪠
	CALL    L_0625	; ���ᮢ�� ���⨭��
	MVI  A, 034h
	STA     M_VAR1
	CALL    L_0399	; >
	XRA  A
	OUT     01Bh
	CALL    L_038D	; >
	MVI  C, 001h
	LXI  H, 0DFE0h
	CALL    L_0366	; >
	JNZ     L_0000
	LXI  H, 0DFE0h
	LXI  D, 0DEF1h
	MVI  C, 01Fh
	MVI  A, 066h
L_030F:	ADD  M
	MOV  B, A
	MOV  A, M
	STAX D
	INX  H
	DCX  D
	DCR  C
	MOV  A, B
	JNZ     L_030F
	SUB  M
	JNZ     L_0000
	STAX D
	LDA     0DFE4h
	MOV  B, A
	LXI  H, 00080h
L_0326:	MVI  C, 001h
L_0328:	CALL    L_0366	; >
	JNZ     L_0000
	DCR  B
	JZ      L_0354	; >
	INR  C
	MVI  A, 006h
	CMP  C
	JNZ     L_0328
	LDA     M_VAR1
	XRI     004h
	STA     M_VAR1
	CALL    L_0399	; >
	MOV  A, D
	ANI     004h
	JZ      L_0326
	MVI  A, 058h
	OUT     01Bh
	CALL    L_038D	; >
	JMP     L_0326
;
L_0354:	LDA     0DFE4h
	RLC
	RLC
	MOV  D, A
L_FBLK:	LXI  H, 00100h	; ���� ��砫�
L_FBL1:	MVI  A, 0C3h
	STA     00000h
	SHLD    00001h
L_035D:	CALL    L_03A9	; >> ���������� ������, D=������⢮
	INR  H
	DCR  D
	JNZ     L_035D
	RET
;
L_0366:	CALL    L_038D	; >
	MOV  A, C
	OUT     019h
	LXI  D, 00103h	; ????
	MVI  A, 080h
	OUT     01Bh
L_0373:	IN      01Bh
	RRC
	JNC     L_0373
L_0379:	IN      01Bh
	ANA  E		; 0000 0011
	SUB  D		; -01h
	JZ      L_0379
	IN      018h
	MOV  M, A
	INX  H
	JP      L_0379
	DCX  H
	IN      01Bh
	ANI     09Ch
	RET
;
L_038D:	LDA     M_VAR1
	OUT     01Ch
	IN      01Bh
	RRC
	JC      L_038D
	RET
;
L_0399:	MOV  D, A
L_039A:	OUT     01Ch
	IN      01Bh
	RLC
	MOV  A, D
	JC      L_039A
	RET
; ----- ����� ����㧪� � 䫮������
;
L_03BA:	LXI  H, L_0685	; << ����㧪� � ������䮭�
	CALL    L_0625	; ���⨭��
;;	MVI  A, 007h	; ����砥� ���/���	+++
;;	OUT     000h	; ��ࠢ�塞 � ���� C	+++
	XRA  A		; �����⪠ �࠭�
	LXI  H, M_VAR1	; ��砫�
	MVI  C, 007h	; ����稪
L_03xx:	MOV  M, A
	INR  L
	DCR  C
	JNZ     L_03xx  ; 横� �����⪨
Lx03BA:	MVI  A, 011h
	STA     0DEF6h	; ????
	LXI  H, L_046B
	SHLD    M_PP1+1	; 0DCF2h
	LXI  H, Lx03BA
	SHLD    M_PP2+1	; 0DCF5h
	CALL    L_041C
L_03D6:	MOV  D, A
	ORA  A
	RAR
	MOV  E, A
	ADD  D
	MOV  H, A
	CALL    L_041C
	CMP  H
	JC      L_03D6
	ADD  D
	STA     0DEF6h	; ????
;;	MVI  A, 006h	; �몫�砥� ���/���	+++
;;	OUT     000h	; ��ࠢ�塞 � ���� C	+++
	MVI  E, 00Ch
	JMP     L_01B9
;
L_03EC:	MVI  L, 000h
	MOV  H, B
	CALL    L_04B4	; ���᫥��� ���न��� ����㧮筮� ⠡����
L_03F2:	MOV  A, M
	ANA  A
	RZ
	INX  H
	CPI     081h
	JNZ     L_03F2
	ANA  A
	RET
;
L_03FD:	PUSH D
	IN      001h
	ANI     010h
	MOV  E, A
L_0403:	IN      001h
	ANI     010h
	CMP  E
	JZ      L_0403
	MOV  E, A
	MVI  D, 001h
L_040E:	IN      001h
	ANI     010h
	INR  D
	CMP  E
	JZ      L_040E
	MOV  A, D
	ADD  A
	ADD  A
	POP  D
	RET
;
L_041C:	PUSH H
	PUSH D
L_041E:	CALL    L_03FD
	MOV  B, A
	ORA  A
	RAR
	MOV  C, A
	LXI  H, 00000h
	MVI  D, 020h
L_042A:	CALL    L_03FD
	PUSH D
	MVI  D, 000h
	MOV  E, A
	DAD  D
	POP  D
	MOV  E, A
	SUB  B
	JNC     L_043A
	MOV  A, B
	SUB  E
L_043A:	CMP  C
	JNC     L_041E
	DCR  D
	JNZ     L_042A
	DAD  H
	MOV  A, H
	POP  D
	POP  H
	RET
;
L_0447:	PUSH B
	PUSH D
	LXI  H, M_VAR1
L_044C:	PUSH H
	LXI  B, 00023h
	MVI  A, 0FFh
L_0452:	CALL    M_PP1
	MOV  M, A
	INX  H
	ADD  B
	MOV  B, A
	MVI  A, 008h
	DCR  C
	JNZ     L_0452
	DCX  H
	MOV  A, B
	SUB  M
	SUB  M
	MOV  A, M
	POP  H
	JNZ     L_044C
	POP  D
	POP  B
	RET
;
L_046B: PUSH B		; <<<<<<<<<<< PP1
        PUSH D
        MVI  C, 000h
        MOV  D, A
L_0470: IN      001h
        ANI     010h
        MOV  E, A
L_0475: IN      001h
        ANI     010h
        CMP  E
        JZ      L_0475
        RLC
        RLC
        RLC
        RLC
        MOV  A, C
        RAL
        MOV  C, A
        LDA     0DEF6h	; ????
L_0487: DCR  A
        JNZ     L_0487
        MOV  A, D
        ORA  A
        JP      L_04A9
        MOV  A, C
        CPI     0E6h
        JNZ     L_049D
        XRA  A
        STA     0DEF4h
        JMP     L_04A7
;
L_049D: CPI     019h
        JNZ     L_0470
        MVI  A, 0FFh
        STA     0DEF4h
L_04A7: MVI  D, 009h
L_04A9: DCR  D
        JNZ     L_0470
        LDA     0DEF4h
        XRA  C
        POP  D
        POP  B
        RET
;
L_04CD:	XRA  A		; << �஢�ઠ ������ ��
L_04CE:	STA     M_DSK	; �� 10
	LXI  H, 0F800h
	SHLD    M_BKD	; ���� ���� ��� �⥭�� ��⠫��� ��
	XRA  A		; �⠥� ���� ��⠫�� �� � ����
	CALL    L_054C	; �⥭�� ��஦�� 0 ��
	JNZ	L_ERR	; >> �訡�� �⥭�� ��
	MVI  A, 001h
	CALL    L_054C	; �⥭�� ��஦�� 1 ��
	JNZ	L_ERR	; >> �訡�� �⥭�� ��
L_NAME:	CALL    L_04E9	; �஢�ઠ �� ᮢ������� ����� � "OS.COM"
	RZ		; >> ᮢ����, ��室�� � Z=1 � HL=��뫪� �� ᯨ᮪ ᥪ�஢
	DAD  D		; +10h, ᫥����� ������
	JNC     L_NAME	; �᫨ HL ��� �� ���㫨����, � �饬 �����
L_ERR:	LDA     M_DSK
	ANA  A
	RNZ		; �� 11 � OS.COM �� ������, ������ � Z=0
	INR  A
	JMP     L_04CE	; ����� � �� 11
;
L_04E9:	PUSH H		; �� �஢�ન ����� "OS.COM"
	LXI  D, L_0500	; ��뫪� �� ��.���
	MVI  C, 00Ch	; ����稪
L_04EF: LDAX D
	CMP  M
	JNZ     L_04FD	; >> �� ᮢ����
	INX  D
	INX  H
	DCR  C
	JNZ     L_04EF	; 横�
L_04FD: POP  H
	LXI  D, 00010h
	DAD  D		; �����頥� ��뫪� �� ᯨ᮪ �४�� 䠩��
	RET
;
L_0500:	.db 000h
	.db "OS      COM"
;
L_050C:	PUSH H		; <<< ����㧪� � ��, HL=��뫪� �� ᯨ᮪ ᥪ�஢ OS.COM
	LXI  H, L_069F	; ���⨭�� ��
	CALL    L_0625	; ���⨭��
	LXI  H, 00100h
	SHLD    M_BKD 	; ���� ���� ��� �⥭�� ��
	MOV  B, L	; B = 0
	POP  H
L_051E:	MVI  C, 010h	; <<<---- 横� �� ������ ��஦��
L_0520:	MOV  A, M
	ORA  A
	JZ      L_0545	; >> ��⮢�
	CALL    L_054C	; �⥭�� �४�
	JNZ     L_KDER	;L_00CA	; -> �訡�� �⥭��!
	MVI  A, 004h
	ADD  B
	MOV  B, A	; ���-�� ������ +4
	INX  H
	DCR  C
	JNZ     L_0520
	CALL    L_04E9	; �⥭�� ᫥��饩 ����� ��⠫��� ��, == "OS.COM"?
	JZ      L_051E	; ��� ����, ��㧨� �����
L_0545:	MOV  D, B	; D = ���-�� ����㦥���� ������
;	LXI  H, 00100h
	JMP     L_FBLK
;
L_KDER:	LXI  H, 0D7E2h	; ��⮥ ����
	LXI  D, 0D8E2h
	MVI  A, 002h	; �᫮ �⮫�殢
	MVI  B, 08Ch	; ���� ���⨭��
	CALL    L_062D	; <<< �� ���ᮢ�� ���⨭��
	JMP     L_00CA	; ���室 � ����㧪� � ᫥���饣� ���ன�⢠
;
	; �� �⥭�� ��஦�� �� � ����
	; M_BKD = ���.��砫� ����
	; A = ����� ��஦�� �� (�����뢠���� � M_DKD)
L_054C:	PUSH H
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
L_058C:	POP  D		; �⠥� � DE
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
	JNZ     L_058C	; 横� ����஢���� ᥪ�� (128 ����)
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
	XRA  A
	RET		; >>>> ����� ���, ���
;
L_CHDD:	IN      057h	; ॣ���� ����� ����
	INR  A		; �᫨ � <> FFh
	CNZ     L_RES	; ��� � �������� ��⮢���� ����
	ORA  A
	RZ		; >> ��� �⪫��� �� ����
	LXI  H, B_HDD	; �㤠 ����
	MVI  C, 001h	; ᪮�쪮 ᥪ�஢ ����
        CALL    L_RHDD	; �⥭�� � ����
        LDA     B_HDD+4	; (᪮�쪮 ������/4 �ணࠬ�� � ���.������)
        ANA  A		; �᫨ ࠢ�� 00, ����� �� ��⠫���
        JZ      L_CHDD	; >> ��-� �� ����㧨����, �����塞
        CPI     0E5h	; �᫨ ࠢ�� �5, ����� ���.������� ����
        RET		; >> Z - ��� ��⥬�
;
; �� ����㧪� � ���⪣� ��᪠
;
L_082B:	LXI  H, L_06EC	; ��뫪� �� ���⨭�� � ��᪮�
	CALL    L_0625	; ��㥬...
	DI
        CALL    L_RES	; ��� � �������� ��⮢���� ����
	LXI  D, 0FF80h	; (-80h)
	LHLD    B_HDD	; ���뢠�� ��砫�� ����
	PUSH H		; � �⥪, ��� ��᫥���饣� �ᯮ�짮�����
;	PUSH H
	DAD  D		; ���ࠢ�� �� ᬥ饭�� ������
        LDA     B_HDD+4	; (᪮�쪮 ������/4 �ணࠬ�� � ���.������)
        ADD  A
	PUSH PSW	; � �⥪, ��� ��᫥���饣� �ᯮ�짮�����
        MOV  C, A	; �᫮ ᥪ�஢ = ������/4 * 2
        CALL    L_RHDD
	POP  PSW
	POP  H
	ADD  A
	MOV  D, A	; D = �᫮ ������ ��� �⮡ࠦ���� (�� 256 ����)
	MVI  A, 0FCh
	ANA  L
	ORA  H		; ��砫�� ���� ����� 0003h
	JNZ     L_FBL1	; ������塞 ����� � ⠡��� c JMP addr(HL)
	JMP     L_035D	; ������塞 �����
;
;	CALL    L_028B	; ������塞 ����� � ⠡���
;	POP  H
;	XRA  A
;	MVI  C, 080h
;L_CLR:	DCX  H
;	MOV  M, A
;	DCR  C
;	JNZ     L_CLR	; �����⪠ 80h ���� �� �� (��-�� ᬥ饭��)
;	EI
;	RET		; >> ������ (� �⥪� ���� L_00DF)
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
L_064D:	.db 008h	; ����
	.db 0F3h	; - |����  ��| ������-06�.20
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
	.db 09Ch	; - |�  ���  |
	.db 0B6h	; - |� �� �� |
	.db 036h	; - |  �� �� |
	.db 006h	; - |     �� |
	.db 09Ch	; - |�  ���  |
	.db 086h	; - |�    �� |
	.db 0B6h	; - |� �� �� |
	.db 01Ch	; - |   ���  |
;
L_0685:	.db 00Dh	; ����
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
L_069F:	.db 08Ch	; ����, +80h -- 㤢����� ��ப
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
L_06B6:	.db 08Ah	; ����, +80h -- 㤢����� ��ப
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
L_06CA:	.db 087h	; ����, +80h -- 㤢����� ��ப
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
L_06D8:	.db 08Ah	; ����, +80h -- 㤢����� ��ப
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
L_06EC:	.db 00Fh	; ����
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
L_0707:	LXI  D, F4_LEN	; ࠧ��� << ������ �㯥�������
	LXI  B, F4_PRG	; ��㤠
	JMP     L_0728
;
L_0710:	CALL    L_078F	; << ����㧪� ����� ���㧪� ������ �१ �� (� ������)
	JNZ     L_03BA	; >> ����㧪� � ������䮭�
	LXI  D, 000DAh	; ࠧ���
	LXI  B, L_72B1	; ��㤠
	LXI  H, 09300h	; �㤠
	JMP     L_072B
;
L_06FE:	LXI  D, F3_LEN	; ࠧ��� << ���ᨪ
	LXI  B, F3_PRG	; ��㤠
L_0728:	LXI  H, 00100h	; �㤠
	MVI  A, 0C3h
	STA     00000h
	SHLD    00001h
L_072B:	PUSH H
	PUSH B
	CALL    L_073F	; ���ᮢ�� ���⨭�� 稯�
	POP  B
	POP  H
L_0732:	LDAX B		; �⠥� ����
	MOV  M, A	; ��襬
	INX  B
	INR  L
	JNZ     L_0732
	CALL    L_03A9	; >> ���������� ������
	INR  H
	DCR  D
	JNZ     L_0732	; 横� ��७�� ������
	RET
;
L_073F:	LXI  H, L_06CA	; ���⨭�� 稯�
;	MVI  A, 087h
	PUSH D
	CALL    L_0625	; ���ᮢ��
	POP  D
	RET
;
L_074A:	LXI  H, 07FFEh	; << ��� ���
	LXI  D, 000FFh
L_0750:	MOV  A, M
	XRA  D
	MOV  D, A
	DCX  H
	MOV  A, H
	CMP  E
	JNZ     L_0750	; 横� ������� ��
	LDA     07FFFh	; �� � ���
	XRA  D
	JZ      L_00E6	; >> ��� ��! (RZ)
	MOV  A, D
	OUT  006h       ; ���� (B) �� -- �뢮� ��
	MVI  A, 7
	OUT     002h	; � ���� B -- 梥� ����� (�����)
L_075E:	JMP     L_075E	; �᫨ ��� -- ��横��������...
;
L_0761:	LXI  H, 000C3h	; << ॠ������ 0 ����� ������ (०�� ����㧪� ��⥪������)
	SHLD    00000h
	SHLD    00005h
	LXI  H, 076C3h	; !!
	SHLD    00038h
	CALL    L_078F
	LXI  H, 00002h	; !!
	JNZ     L_0784
	MVI  M, 0F8h
	MVI  L, 007h
	MVI  M, 094h
	MVI  L, 03Ah
	MVI  M, 0FDh
	RET
;
L_0784:	MVI  M, 078h
	MVI  L, 007h
	MVI  M, 054h
	MVI  L, 03Ah
	MVI  M, 07Dh
	RET
;
L_078F:	LXI  H, 09400h
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
L_07A0:	;CALL    L_0620	; << ����㧪� �� �� �१ ����� ��-LPT
	LXI  H, L_06D8	; ���⨭�� ��
	CALL    L_0625	; ���ᮢ�� ���⨭��
	MVI  A, 082h
	OUT     004h
	MVI  A, 010h
	OUT     005h
	XRA  A
	MOV  L, A
	MOV  C, A
	CALL    L_07E1
	MOV  A, E
	CPI     055h
	JNZ     L_0000
	CALL    L_07E1
	MOV  A, E
	CPI     0AAh
	JNZ     L_0000
	CALL    L_07E1
	MOV  H, E
	CALL    L_07E1
	MOV  A, H
	ADD  E
	MOV  B, A
L_07CA:	CALL    L_07E1
	MOV  M, E
	MOV  A, C
	XRA  E
	MOV  C, A
	XRA  A
	ORA  L		; L = 00h?
	CZ      L_03A9	; >> ���������� ������
	INX  H
	MOV  A, H
	CMP  B
	JNZ     L_07CA
	CALL    L_07E1
	MOV  A, E
	CMP  C
	RZ
	RST  0
L_07E1:	MVI  D, 000h
L_07E3:	IN      006h
	ANI     020h
	JZ      L_07E3
	MOV  A, D
	ANA  A
	JNZ     L_07F8
	IN      006h
	ANI     00Fh
	MOV  E, A
	INR  D
	JMP     L_0804
;
L_07F8:	IN      006h
	ANI     00Fh
	RLC
	RLC
	RLC
	RLC
	ORA  E
	MOV  E, A
	MVI  D, 000h
L_0804:	XRA  A
	OUT     005h
L_0807:	IN      006h
	ANI     020h
	JNZ     L_0807
	MVI  A, 010h
	OUT     005h
	MOV  A, D
	ANA  A
	JNZ     L_07E3
	RET
;
;===============================================================
; ����� ���㧪� ������ �१ �� ��� ������
				;		.org 09300h
L_72B1:	.db 021h,0BAh,093h	;L_9300:	LXI  H, L_93BA
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
L_FM9:	LXI  H, L_0685	; << ����㧪� � ������䮭� FM9
	MVI  A, 003h	; 3 �⮫��
	CALL    L_0627	; ���ᮢ�� ���⨭��
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
	ORA  A
	JZ      L_FM92
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
	MOV  D, B	; ������⢮ ������
	ORA  A
	JZ     L_FBL1	; ���������� ������
L_FM9z:	MOV  A, M
	CMA
	MOV  M, A
	INX  H
	DCR  C
	JNZ     L_FM9z
	DCR  B
	JNZ     L_FM9z
	JMP     L_FBL1	; ���������� ������
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
