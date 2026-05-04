|  |  |  |  |  |  |  |  |  |  |  |  
|---|---|---|---|---|---|---|---|---|---|---|
| Vstupy | CLK | RST | digit0[3:0] | digit1[3:0] | digit2[3:0] | digit3[3:0] | digit4[3:0] | digit5[3:0] | digit6[3:0] | digit7[3:0] |  
| Výstupy | seg[3:0] | an_seg[7:0] |  |  |  |  |  |  |  |  |  

Na vstupe dostaneme 4 bitové čísla, ktoré následne pošleme na 4 bitový seg a spolu sním aj kód pre jeho polohu na an_seg 8 bitový. 
V základe len budeme zaradom prechádzať vstupy istou prekvenciu a budeme ich vysielať na seg a rovnako budeme cykliť an_seg

celý blok bude závislý na synchrónnom CLK a RST
