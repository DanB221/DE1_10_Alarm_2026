# Projekt z DE1 č.10 ALARM
V rámci výuky predmetu sme si zvolili tému číslo 10 ALARM. 

## Popis alarmu a funkcionality
Nami navrhnutý alarm respektíve budík v základnom stave zobrazuje čas a aktuálny stav alarmu. Vieme samostatne nastavovať čas hodín, čas alarmu, vypínať a zapínať budík prípadne odkladať začaté budenie. Počas nastavovania jednotlivé práve navolené čislice blikajú a je zablokovaný presun do vyššieho radu takže pri prejdení hranice napríklad 59 minút sa ďalším nastavovaním vyššieho čísla nepridá minúta, iba sa minúty vynulujú. Ak náhodou nastane prípad, že niekto navolí súbežne nastavenie hodín aj alarmu, celý projekt ostane v základnom stave.

### **Ovládacie prvky a zobrazenie**
Náš projekt využíva k ovládaniu prepínače 0, 1, 2 a tlačidlá hore, dole a stred. Čas hodín rovnako ako aj nastavený čas budenia spolu so stavom zapnutia budíka sa zobrazujú na ôsmich 7-segmentovkách v tvare: HH MM SS XX. Zobrazenie času alarmu sa zobrazuje na základe vstupov z prepínačov namiesto času hodín a naopak. Po začatí budenia využívame aj externý bzučiak a LED diódu.

### **1. Nastavenie hodín**
Nastavenie hodín sa spúšťa prepínačom 2. Počas nastavovania bliká dané dvojčíslie. Presné číslo sa nastavuje tlačidlami hore a dole, následne sa potvrdzuje tlačidlom v strede a nastavovanie sa presunie na minúty a následne na sekundy.

### **2. Nastavenie alarmu**
Nastavenie alarmu je analogické s nastavením hodín. Spúšťa sa prepínačom 1. a alarm sa zapína prepínačom 0.

### **3. Posunutie alarmu**
Po začatí budenia sa zapne externý bzučiak. Alarm vieme presunúť o 5 minút (pre účely ukážky sme nastavili čas posunutia budenia na 15 sekúnd) pomocou stlačenie stredného tlačidla. Pačas odloženia budenia sa rozsvieti LED k indikácii stavu, že budík je zapnutý ale iba "odložený". Úplné vypnutie nasleduje až po vypnutí prepínača 0.


## Bloková schéma
![Scheme](docs/Scheme.webp)

## Popis blokovej schémy

## Popis jednotlivých blokov
- [DEB](docs/DEB.md)
- [SET_A](docs/SET_A.md)
- [SEL_TIME](docs/SEL_TIME.md)
- [SEL_ALM](docs/SEL_ALM.md)
- [TIME](docs/TIME.md)
- [ALARM](docs/ALARM.md)
- [clk_en](docs/clk_en.md)
- [COMP](docs/COMP.md)
- [SET_B](docs/SET_B.md)
- [DIV](docs/DIV.md)
- [SEL](docs/SEL.md)
- [bin2seg](docs/bin2seg.md)


>## Autori
>**Daniel Bačovčin** - 
>
>**Adam Zabloudil** - 
