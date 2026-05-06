|  |  |  |  |  |  |  |  |  |  |  |  |  
|---|---|---|---|---|---|---|---|---|---|---|---|
| Vstupy | CLK | RST | clk_en | SW1 | SW2 | BTNU_H | BTND_H | BTNU_M | BTND_M | BTNU_S | BTND_S |  
| Výstupy | HH[5:0] | MM[5:0] | SS[5:0] |  |  |  |  |  |  |  |  |  

### **Popis**
Blok TIME slúži ako hodiny, ktoré poznajú hodiny minúty a sekundy. Na vstup prijíma signály CLK, RST, clk_en, SW1 a SW2 a impulzy z tlačidiel.Výstupy bloku sú 6-bitové hodnoty HH, MM a SS. Blok pri normálnom režime pracuje ako digitálne hodiny. Na základe impulzu clk_en pripočítava sekundy a pri dosiahnutí hraničných hodnôt zabezpečuje pretekanie do minút a následne do hodín. Sekundy a minúty pracujú v rozsahu od 0 do 59 a hodiny v rozsahu od 0 do 23. Týmto spôsobom blok vytvára nepretržite bežiaci aktuálny čas. Okrem chodu umožňuje blok aj ručné nastavovanie hodín, minút a sekúnd pomocou vstupov BTNU_H, BTND_H, BTNU_M, BTND_M, BTNU_S a BTND_S. Pri ručnom nastavovaní sa mení vždy iba tá časť, ktorá je práve aktívna, bez pretekania do ostatných počítadiel. Ak je aktivovaný režim nastavovania času, automatický chod hodín sa pozastaví. V stave, keď sú oba prepínače SW1 a SW2 v logickej jednotke, sa čas iba zobrazuje a prijímanie vstupov z tlačidiel je vypnuté. Blok TIME je navrhnutý ako synchronný sekvenčný obvod s vnútornými registrami pre hodiny, minúty a sekundy, ktorý je riadený hlavným hodinovým signálom CLK a synchrónnym resetom RST.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/TIME.vhd) |
[Testbench](../../docs/TB/TIME/TIME_tb.vhd) | 
[Simulácia](../../docs/TB/TIME/TIME.PNG) 
