* Tema 2
* Metode Numerice
* Vlad Costin Andrei
* 311 CD

____________________
-- Proximal --
Pentru 2x2:
Pentru o imagine 2x2, generam un vector cu toate punctele intermediare, din
0.1 in 0.1, atat pentru coordonatele pe Ox cat si pentru Oy. Stim deja ca cele
4 puncte marginale vor fi (1,1) (1,2) (2,1) si (2,2). Matricea rezultata va fi
de dimensiune nxn, unde n reprezinta numarul de puncte din vector, si pentru
fiecare punct din aceasta matrice (pereche de coordonate din vector) gasim
cele mai apropiate coordonate intregi, pentru a atribui un pixel din imaginea
initiala.

Pentru coef:
Rezolvam un sistem de forma A * x = b, unde matricea A si respectiv vectorul b
sunt construite conform indicatiilor din pdf. Pentru a rezolva sistemul am
creat o funcite de inversare care are la baza descompunerea QR si rezolvarea
unui SST prin eliminare Gaussiana.

Pentru resize:
Scalam dimensiunile imaginii, si le deplasam din intervalul (0,0) (m-1,n-1) 
la (0,0) (p-1,q-1). Pentru acest lucru cream o matrice de scalare de dimen-
siune 2x2. Pentru fiecare pixel din imagine, calculam noile coordonate prin
inmultirea cu matricea de scalare, apoi adunam 1 la ambele coordonate pentru
a trece dintr-un sistem indexat de la 0 la unul indexat de la 1. Calculam apoi
cel mai apropiat pixel, care poate fi floor(coordonata) sau floor(coordonata)
+1, si apoi valoarea acestuia din imaginea finala.

Pentru rotate:
Calculam valoarea sinusului si a cosinusului unghiului primit ca parametru,
apoi construim o matrice de rotatie de dimensiune 2x2. Pentru fiecare pixel
din imagine, calculam valoarea coordonatelor rotite, prin inmultire cu matricea
de rotatie, si adunand 1 pentru a ne introarce intr-un sistem de coordonate
indexat de la 1. Daca dupa aceste operatii coordonatele obtinute nu se afla
in intervalul (1,1) (m,n), nu luam in considerare respectivul pixel. Altfel,
calculam coeficientii asociati celor 4 puncte inconjuratoare cu ajutorul
functiei proximal_coef si calculam valoarea interpolata a pixelului.

Pentru RGB:
Ca sa rezolvam orice task care implica imagini RGB, consideram o matrice tri-
dimensionala. In aceasta retinem rezultatul functiei corespunzatoare unui 
canal de culoare din imaginea initiala. Apoi, la final, concatenam cele 3 rezultate intr-o matrice finala.
____________________
-- Bicubic --

Pentru derivate partiale:
Pentru a calcula derivata lui f intr-un punct (x sau y) sau in ambele puncte,
folosim formulele prezentate in pdf. Pentru a calcula matricele de derivare
partiale, de dimensiuni mxn, calculam derivata lui f in x / y / ambele puncte
pentru fiecare pixel al imaginii (de mentionat ca pt x omitem coordonatele 1
si n, iar pt y omitem 1 si m intrucat derivata in acele puncte este 0).

Pentru coef:
Matricea de coeficienti rezulta din rezolvarea unui sistem liniar care are la
baza 16 ecuatii. Aceasta va fi obtinuta prin inmultirea a 3 matrice, 2 din ele
fiind alcatuite din numere intregi, coeficienti ai relatiilor. Cea de-a treia
este alcatuita din derivatele partiale ale lui f in raport cu punctele limita
primite ca parametrii ai functiei.

Pentru resize:
Scalam dimensiunile imaginii, si le deplasam din intervalul (0,0) (m-1,n-1) 
la (0,0) (p-1,q-1). Pentru acest lucru cream o matrice de scalare de dimen-
siune 2x2. Pentru fiecare pixel din imagine, calculam noile coordonate prin
inmultirea cu matricea de scalare, apoi adunam 1 la ambele coordonate pentru
a trece dintr-un sistem indexat de la 0 la unul indexat de la 1. Calculam
apoi coordonatele pixelilor care il inconjoara si cu ajutorul lor aflam coe-
ficientii de care avem nevoie pentru interpolare. Pentru acest lucru apelam
functia bicubic_coef mentionata mai sus. Mai avem nevoie doar sa trecem coor-
donatele in intervalul (0,0) (1,1) pentru a putea calcula valoarea interpolata
a pixelului (x,y).

Pentru RGB:
Ca sa rezolvam orice task care implica imagini RGB, consideram o matrice tri-
dimensionala. In aceasta retinem rezultatul functiei corespunzatoare unui 
canal de culoare din imaginea initiala. Apoi, la final, concatenam cele 3 rezultate intr-o matrice finala.
____________________
-- Lanczos --

Algoritmul Lanczos pt bloc nesimetric:
Efectuam descompunerea QR a matricelor V si W primite ca parametrii, apoi
iteram calculand spatiile vectoriale Vm si Wm. Pentru acest lucru ne folosim
de matricele auxiliare _Vm_ si _Wm_, pe care le calculam initial pt pasul
m = 1. La fiecare pas i, efectuam descompunerea QR a celor 2 matrice Vi si Wi,
apoi calculam SVD pentru matricele Wi+1' (transpus) si Vi+1, pe baza carora
vom afla si _Vm_ si _Wm_ la pasul i + 2. Pe deasupra mai obtinem blocul T de
dimensiune mp x np.
____________________