|  |  |  |  |  |  | 
|---|---|---|---|---|---|
| Vstupy | CLK | RST | BTNU | BTND | BTNC |  
| Výstupy | BTNU_d | BTND_d | BTNC_d |  |  | 

### **Popis**
Blok DEB slúži na odfiltrovanie zákmitov tlačidiel a na vytvorenie krátkych impulzov po ich stabilnom stlačení. Na vstup prijíma signály CLK, RST a tlačidlá BTNU, BTND a BTNC. Na výstupe vytvára impulzy BTNU_d, BTND_d a BTNC_d, ktoré trvajú jeden takt hodinového signálu.Blok je navrhnutý ako synchronný sekvenčný obvod riadený signálmi CLK a RST.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/DEB.vhd) |
[Testbench](../../TB/DEB/DEB_tb) | 
[Simulácia]() 
