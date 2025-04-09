# Equalizzazione dell'istogramma di un'immagine

Il progetto implementa l'equalizzazione dell'istogramma di un'immagine, volto a incrementare il contrasto dell'immagine distribuendo il valore dei colori su un range più ampio. La versione presa in considerazione è semplificata e comprende solo una scala di grigi a 256 valori: maggiori dettagli si trovano nel [file di specifica](Specifica.pdf). Il progetto è stato realizzato come prova finale per il corso di **Reti logiche** del Politecnico di Milano (Anno Accademico 2020/2021).

## 📌 Descrizione

Il progetto implementa in hardware un algoritmo per migliorare il contrasto di un'immagine in scala di grigi attraverso l’equalizzazione dell’istogramma. L’output è un’immagine rielaborata, memorizzata in RAM.

### Design del datapath
![Datapath](Immagini/Datapath/Datapath.jpg 'Datapath')


### Macchina a stati finiti
![Macchina a stati finiti](Immagini/FSM/FSM.png 'Macchina a stati finiti')

La spiegazione dettagliata si trova nel [report finale](10583364_10675235.pdf) del progetto

## 🛠 Tecnologie e Strumenti

- **VHDL** - linguaggio principale del progetto
- **Vivado** - una suite di software per la sintesi e l'analisi di design scritti in HDL (Hardware Description Language)

## 📁 Struttura del Progetto

```
.
├── Immagini                  # Cartella con immagini del datapath e della FSM
├── Testbenches               # Cartella con i testbench utilizzati
  ├── MaxDim.vhd              # Massima dimensione
  ├── Resets.vhd              # Reset durante l'esecuzione
  ├── Shift.vhd               # Tutti gli shift possibili
  └── TB.vhd                  
├── 10583364_10675235.pdf     # Report
├── 10583364_10675235.vhd     # Sorgente
├── Specifica.pdf             # Specifica
└── README.md                 # Questo file
```

## 📊 Risultati 

Il progetto ha superato tutti i nostri test, ed ha ottenuto una valutazione finale di 30.

## 👤 Autori

Progetto sviluppato da [Francesco Colabene](https://github.com/FrancescoColabene) e [Stefano Carraro](https://github.com/StefanoCarraro7) come parte dell’esame del corso **Reti Logiche**, Politecnico di Milano, A.A. 2020/2021.
