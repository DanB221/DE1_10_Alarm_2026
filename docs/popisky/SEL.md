|  |  |  |  |  |  |  |  |  |  |  |  
|---|---|---|---|---|---|---|---|---|---|---|
| Vstupy | digit0[3:0] | digit1[3:0] | digit2[3:0] | digit3[3:0] | digit4[3:0] | digit5[3:0] | digit6[3:0] | digit7[3:0] | CLK | RST | 
| Výstupy | seg[3:0] | an_seg[7:0] |  |  |  |  |  |  |  |  |  

### **Popis**
Blok SEL slúži na výber jednotlivých číslic pre mux zobrazenie na 7-segmentovom displeji. Na vstup prijíma signály CLK, RST a osem vstupov digit0 až digit7. Výstupy bloku tvoria 4-bitový signál seg, ktorý nastavuje vybranú číslicu, a 8-bitový signál an_seg, ktorý predstavuje aktívnu anódu displeja.Blok prepína medzi jednotlivými číslicami každú milisekundu, aby sa na displeji zobrazili pre užívateľa súčasne. Podľa pozície výberu odošle na výstup seg zodpovedajúci vstup digit0 až digit7 a zároveň nastaví danú hodnotu na výstupe an_seg.Blok SEL je navrhnutý ako sekvenčno-kombinačný obvod. Sekvenčná časť riadená signálmi CLK a RST zabezpečuje prepínanie medzi číslicami, zatiaľ čo kombinačná časť vyberá číslicu a anódu pre zobrazenie.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/SEL.vhd) |
[Testbench](../../docs/TB/SEL/SEL_tb.vhd) | 
[Simulácia](../../docs/TB/SEL/SEL.PNG) 
