|  |  |  | 
|---|---|---|
| Vstupy | clk | rst |  
| Výstupy | ce |  |  

### **Popis**
Blok clk_en slúži na vytvorenie impulzu na výstupe ce každú sekundu. Vo vnútri bloku sa nachádza čítač, ktorý sa pripočítava pri každej nábežnej hrane hodinového signálu. Po dosiahnutí hodnoty 100 000 000 sa čítač vynuluje a na výstupe ce sa vytvorí impulz. Blok clk_en je navrhnutý ako synchronný sekvenčný obvod riadený signálmi clk a rst.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/clk_en.vhd) |
[Testbench](../../docs/TB/clk_en/clk_en_tb.vhd) | 
[Simulácia](../../docs/TB/clk_en/clk_en.PNG) 
