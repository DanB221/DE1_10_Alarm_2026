|  |  |  |  |  |  |  |  |  | 
|---|---|---|---|---|---|---|---|---|
| Vstupy | CLK | RST | STAV[1:0] | H[5:0] | M[5:0] | S[5:0] | O_F[3:0] |  |  
| Výstupy | digit0[3:0] | digit1[3:0] | digit2[3:0] | digit3[3:0] | digit4[3:0] | digit5[3:0] | digit6[3:0] | digit7[3:0] | 

### **Popis**
Blok DIV slúži na rozdelenie aktuálnych hodnôt hodín, minút a sekúnd na jednotlivé cifry určené pre zobrazenie na 7-segmentovom displeji. Na vstup prijíma signály CLK, RST, STAV, H, M, S a O_F. Výstupy bloku tvoria 4-bitové hodnoty digit0 až digit7, ktoré reprezentujú jednotlivé číslice alebo písmená zobrazované na displeji, prípadne kód pre vypnutie displeja.Blok najprv prevedie vstupné hodnoty hodín, minút a sekúnd na desiatky a jednotky. Hodiny sú rozdelené na digit0 a digit1, minúty na digit2 a digit3 a sekundy na digit4 a digit5. Výstup digit6 je nastavený na pevnú hodnotu 1010 a výstup digit7 priamo preberá hodnotu zo vstupu O_F.Okrem rozdelenia čísiel blok zabezpečuje aj blikanie dvojice číslic, ktorá sa práve nastavuje. Podľa hodnoty vstupu STAV sa určí, či sa majú dočasne zhasínať hodiny, minúty alebo sekundy. Ak je STAV v hodnote 00, nebliká nič. Pri hodnote 01 blikajú číslice hodín, pri hodnote 10 číslice minút a pri hodnote 11 číslice sekúnd. Pre zhasnutie číslic sa posiela kód 1100.Blok DIV je navrhnutý ako kombinácia sekvenčnej a kombinačnej logiky. Sekvenčná časť riadená signálmi CLK a RST vytvára interný blik signál, zatiaľ čo kombinačná časť zabezpečuje samotné rozdelenie vstupných hodnôt a výber číslic, ktoré majú byť zobrazené alebo vypnuté.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/DIV.vhd) |
[Testbench]() | 
[Simulácia]() 
