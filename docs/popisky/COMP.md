|  |  |  |  |  |  |  |  |  |  |  |
|---|---|---|---|---|---|---|---|---|---|---|
| Vstupy | CLK | RST | SW0 | BTNC | HT[5:0] | MT[5:0] | ST[5:0] | HA[5:0] | MA[5:0] | SA[5:0] |
| Výstupy | STAV[3:0] | LED | BUZZ |  |  |  |  |  |  |  |

### **Popis**
Blok COMP je hlavný riadiaci blok funkcie budíka. Porovnáva aktuálny čas zo vstupov HT, MT, ST s časom nastaveným pre alarm zo vstupov HA, MA, SA. Zapína sa vstupom SW0. Stav zapnutia alebo vypnutia signalizuje výstupom STAV. Ak sa časy vstupov vyrovnajú, začne vysielať signál výstupom BUZZ. Ak v stave vysielanie príde signál z BTNC, signál z BUZZ sa pošle na LED. Ten trvá len počas nastavených 15 sekúnd, po tejto dobre sa znova spustí BUZZ a vypne LED. Stav aktívneho budenia trvá do vynulovania SW0. Pri následnom zapnutí blok opäť čaká na vyrovnanie vstupných časov.
Celý blok je navrhnutý ako synchronný sekvenčný obvod riadený hlavným hodinovým signálom CLK a synchrónnym resetom RST.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/COMP.vhd) |
[Testbench](../../docs/TB/COMP/COMP_tb.vhd) | 
[Simulácia](../../docs/TB/COMP/COMP.PNG) 
