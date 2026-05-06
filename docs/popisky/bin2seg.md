|  |  |  
|---|---|
| Vstupy | bin[3:0] |  
| Výstupy | seg[6:0] | 

### **Popis**
Blok bin2seg slúži na prevod 4-bitovej vstupnej hodnoty bin na 7-bitový výstup seg pre 7 segmentovku. Na základe hodnoty vstupu priraďuje príslušnú kombináciu segmentov tak, aby sa zobrazila číslica, písmeno alebo aby sa 7 segmentovka vypla.Blok dekóduje číslice od 0 do 9 a zároveň obsahuje aj písmená o, n a F. Pre ostatné nedefinované hodnoty nastaví výstup tak, aby displej zostal zhasnutý. Blok bin2seg je navrhnutý ako kombinačný obvod.

### **Odkazy**
[VHDL kód](../../Alarm/Alarm.srcs/sources_1/new/bin2seg.vhd) |
[Testbench](../../docs/TB/bin2seg/bin2seg_tb.vhd) | 
[Simulácia](../../docs/TB/bin2seg/bin2seg.PNG) 
