|  |  |  |  |  |  |  |  |  |  |  |
|---|---|---|---|---|---|---|---|---|---|---|
| Vstupy | HH[5:0] | MM[5:0] | SS[5:0] | HH_A[5:0] | MM_A[5:0] | SS_A[5:0] | SW1 | SW2 | STAV_TIME[1:0] | STAV_ALM[1:0] | 
| Výstupy | H[5:0] | M[5:0] | S[5:0] | STAV[1:0] |  |  |  |  |  |  | 

### **Popis**
Blok SET_B slúži na výber vetvy, ktorá bude ďalej odoslaná na zobrazovanie. Na vstup prijíma aktuálny čas HH, MM, SS, alarmový čas HH_A, MM_A, SS_A a tiež stavové signály STAV_TIME a STAV_ALM. Na základe vstupov z SW1 a SW2 rozhoduje, či sa na výstup odošlú hodnoty času alebo hodnoty alarmového času.
Ak je aktívny režim alarmu, blok na výstupy H, M a S odošle hdnoty s indexom _A. V ostatných prípadoch posiela na výstup hodnoty času HH, MM a SS. Okrem toho, vysiela blok na výstup STAV informáciu, ktorá číslica sa aktuálne volí na základe vstupov SW1, SW2, STAV_TIME a STAV_ALM. Blok SET_B je navrhnutý ako kombinačný obvod. Neuchováva žiadny stav, ale iba podľa aktuálnych vstupov prepája správne vstupy na svoj výstup.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/SET_B.vhd) |
[Testbench](../../docs/TB/SET_B/SET_B_tb.vhd) | 
[Simulácia](../../docs/TB/SET_B/SET_B.PNG) 
