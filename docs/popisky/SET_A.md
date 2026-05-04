|  |  |  |  |  |  |  |  | 
|---|---|---|---|---|---|---|---|
| Vstupy | BTNU | BTND | BTNC | SW1 | SW2 |  |  | 
| Výstupy | BTNC_C | BTNU_H | BTND_H | BTNC_H | BTNU_A | BTND_A | BTNC_A |  

Na základe vstupu zo SW1 a SW2 sa priradia vstupné BTN k výstupným

SW1=0 a SW2=0 - zobrazenie hodín
BTNU_H < 0
BTND_H < 0
BTNC_H < 0
BTNU_A < 0
BTND_A < 0
BTNC_A < 0
BTNC_C < 0

SW1=0 a SW2=1 - nastavenie hodín
BTNU_H < BTNU
BTND_H < BTND
BTNC_H < BTNC
BTNU_A < 0
BTND_A < 0
BTNC_A < 0
BTNC_C < 0


SW1=1 a SW2=0 - nastavenie alarmu
BTNU_H < 0
BTND_H < 0
BTNC_H < 0
BTNU_A < BTNU
BTND_A < BTND
BTNC_A < BTNC
BTNC_C < 0


SW1=1 a SW2=1 - zobrazenie hodín
BTNU_H < 0
BTND_H < 0
BTNC_H < 0
BTNU_A < 0
BTND_A < 0
BTNC_A < 0
BTNC_C < 0
