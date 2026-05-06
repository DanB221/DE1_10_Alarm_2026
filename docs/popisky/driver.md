|  |  |  |  |  
|---|---|---|---|
| Vstupy | CLK | RST | buzz_in |  
| Výstupy | driv_buzz |  |  |  

### **Popis**
Blok driver slúži na vytvoreniesignálu pre bzučiak na výstupe driv_buzz na základe vstupu buzz_in. 
Ak je vstup buzz_in aktívny, blok generuje prerušovaný signál. Vo vnútri vytvára tón s frekvenciou približne 2 kHz a zároveň ho periodicky zapína a vypína v intervaloch 300 ms. Tým vzniká opakované pípanie. Ak je vstup buzz_in neaktívny, výstup driv_buzz zostáva neaktívny taktiež.Blok driver je navrhnutý ako synchronný sekvenčný obvod riadený signálmi CLK a RST.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/driver.vhd) |
[Testbench](../../docs/TB/driver/driver_tb.vhd) | 
[Simulácia](../../docs/TB/driver/driver.PNG) 
