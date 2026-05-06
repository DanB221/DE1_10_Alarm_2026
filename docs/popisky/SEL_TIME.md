|  |  |  |  |  |  |  |  | 
|---|---|---|---|---|---|---|---|
| Vstupy | CLK | RST | BTNU | BTND | BTNC |  |  |  
| Výstupy | BTNU_H | BTND_H | BTNU_M | BTND_M | BTNU_S | BTND_S | STAV[1:0] | 

### **Popis**
Blok SEL_TIME slúži na výber buď hodín, minút alebo sekúnd v závislosti na to, čo práve budemem nastavovať. Na vstup prijíma impulzy z tlačidiel BTNU, BTND a BTNC, ako aj riadiace signály CLK a RST. Tlačidlo BTNC slúži na prepínanie medzi režimami nastavovania hodín, minút a sekúnd. Tlačidlá BTNU a BTND sa podľa zvoleného režimu presmerujú na dané výstupy.
Blok po resete začína v režime nastavovania hodín. Každým impulzom na vstupe BTNC sa jeho vnútorný stav prepne cyklicky v poradí hodiny, minúty, sekundy a opäť hodiny. Súčasťou bloku je aj 2-bitový výstup STAV, ktorý informuje SET_B o tom, ktorá časť hodín je práve aktívna. Blok SEL_TIME je navrhnutý ako sekvenčný obvod s vnútorným stavom, riadený hlavným hodinovým signálom CLK a synchrónnym resetom RST.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/SEL_TIME.vhd) |
[Testbench](../../docs/TB/SEL_TIME_ALM/SEL_TIME_ALM_tb.vhd) | 
[Simulácia](../../docs/TB/SEL_TIME_ALM/SEL_TIME_ALM.PNG) 

