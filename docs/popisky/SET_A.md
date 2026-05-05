|  |  |  |  |  |  |  |  | 
|---|---|---|---|---|---|---|---|
| Vstupy | BTNU | BTND | BTNC | SW1 | SW2 |  |  | 
| Výstupy | BTNC_C | BTNU_H | BTND_H | BTNC_H | BTNU_A | BTND_A | BTNC_A |  

### **Popis**
Blok SET_A slúži na smerovanie impulzov z tlačidiel do správnej vetvy systému podľa zvoleného režimu nastavovania. Na vstupy BTNU, BTND a BTNC príjíma debouncované impulzy z tlačidiel. Smerovanie výstupov jepodmienené vstupmi SW1 a SW2, pričom SW1 smeruje vstupy k výstupom s označením _A, SW2 smeruje k výstupom _H. AK sú oba vstupy nulové, povolí sa výstup iba BTNC. Ak by boli ova vstupy aktívne, nedôjde k žiadnemu prenosu impulzov z vstupov na výstupy. Blok SET_A je navrhnutý ako čistý kombinačný obvod, takže iba rozdeľuje vstupné signály podľa aktuálneho stavu prepínačov.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/SET_A.vhd) |
[Testbench]() | 
[Simulácia]() 
