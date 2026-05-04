|  |  |  |  |  |  |  |  |  |  |  |
|---|---|---|---|---|---|---|---|---|---|---|
| Vstupy | SW1 | SW2 | STAV_TIME[1:0] | STAV_ALM[1:0] | HH[5:0] | MM[5:0] | SS[5:0] | HH_A[5:0] | MM_A[5:0] | SS_A[5:0] |  
| Výstupy | STAV[1:0] | H[5:0] | M[5:0] | S[5:0] |  |  |  |  |  |  |  

Blok prijíma 6 bitové vstupy HH MM a SS z hodín alebo z alarmu s indexom _A. na základe switchov analogicky z bloku SET_A priradzuje vstupy 6 bitovým výstupom. 
zároveň podľa toho, či sa nachádzame v nastavovaní hodín alebo alarmu, vezmeme vstupnú dvojbitovú hodnotu zo STAV_TIME alebo STAV_ALM a podľa nej bude v nastavenom 
čase napríklad 250ms číslice, ktoré sú aktuálne nastavované podľa STAV_TIME alebo _ALM.

Celý blok bude riadený synchrónnym CLK a RST
