|  |  |  |  |  |  |  |  |  |  
|---|---|---|---|---|---|---|---|---|
| Vstupy | CLK | RST | BTNU_H | BTND_H | BTNU_M | BTND_M | BTNU_S | BTND_S |  
| Výstupy | HH_A[5:0] | MM_A[5:0] | SS_A[5:0] |  |  |  |  |  |  

### **Popis**
Blok ALARM slúži na uchovávanie nastaveného alarmového času vo forme hodín, minút a sekúnd. Na vstup prijíma signály CLK a RST a impulzy z tlačidiel. Výstupy bloku sú 6-bitové hodnoty HH_A, MM_A a SS_A. Na rozdiel od bloku TIME tento blok neobsahuje automatický chod času, ale slúži iba na ručné nastavenie hodnôt, ktoré sa následne používajú pri porovnaní v bloku COMP.Pomocou vstupov BTNU_H, BTND_H, BTNU_M, BTND_M, BTNU_S a BTND_S je možné samostatne nastavovať hodiny, minúty a sekundy alarmu. Pri nastavovaní sa mení vždy iba tá časť, ktorá je práve aktívna, bez pretekania do ostatných počítadiel. Hodiny pracujú v rozsahu od 0 do 23, minúty a sekundy v rozsahu od 0 do 59. Týmto spôsobom blok uchováva stabilný alarmový čas, ktorý sa nemení, pokiaľ ho používateľ ručne neupraví.Po resete sa blok nastaví na predvolenú hodnotu 23:00:00, aby po zapnutí systému nedošlo k nechcenému okamžitému spusteniu alarmu. Blok ALARM je navrhnutý ako synchronný sekvenčný obvod s vnútornými registrami pre hodiny, minúty a sekundy, ktorý je riadený hlavným hodinovým signálom CLK a synchrónnym resetom RST.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/ALARM.vhd) |
[Testbench](../../docs/TB/ALARM/ALARM_tb.vhd) |
[Simulácia](../../docs/TB/ALARM/ALARM.PNG) 
