Aceasta reprezinta cea de-a doua tema la Metode Numerice
Autor: Draghici Daria-Ioana

------------------------------------ TASK 1 ------------------------------------

1.  stereo_to_mono
    Functia stereo_to_mono are rolul de a transforma un semnal audio stereo, care
contine mai multe canale (de obicei doua, pentru stanga si dreapta), intr-un
semnal mono, adica un singur canal, calculat ca media valorilor de pe toate
canalele pentru fiecare sample. Mai intai, extrag dimensiunile matricei stereo.
Variabila stereo este o matrice unde fiecare rand reprezinta un sample in timp,
iar fiecare coloana reprezinta un canal audio. Functia size returneaza doua
valori: numarul de randuri (adica numarul total de samples in timp) si numarul
de coloane (adica numarul de canale audio). Aceste valori sunt stocate in
variabilele numar_sampleuri si numar_canale. 
    Mai apoi initializez un vector coloana mono, cu acelasi numar de esantioane
ca semnalul original, dar doar cu un canal, cu 0. Incep un for care va parcurge
toate samples ale semnalului audio. Initializez o variabila suma cu valoarea zero.
Incep un alt for in interiorul primului care parcurge fiecare canal audio pentru
sample-ul curent i. Pentru fiecare dintre acestea daugam valoarea la suma. Dupa
ce am adunat valorile tuturor canalelor, calculez media impartind suma la numarul
de canale. Aceasta medie devine valoarea sample-ului i in semnalul mono.
    Dupa ce am calculat toate valorile mono, aflu valoarea maxima absoluta din
vectorul mono. Impart fiecare valoare din vectorul mono la aceasta valoare maxima,
normalizand astfel semnalul intre -1 si 1. Dupa toate acestea, functia ajunge la
sfarsit.

DUPA RULAREA studio.m ----------------------------------------------------------
Nimic nu s-a schimbat. Graficele sunt in continuare goale, albe.

2.  spectogram.m
    Aceasta functie primeste trei argumente: signal, care reprezinta semnalul
audio propriu-zis, sub forma unui vector de valori in timp; fs, adica frecventa
de esantionare, care imi spune cate masuratori pe secunda s-au facut asupra
semnalului si window_size, adica marimea ferestrei pe care o folosesc pentru a
imparti semnalul in segmente mai mici pe care sa le analizez cu transformata
Fourier rapida (FFT). Ea returneaza trei rezultate: matricea S, care contine
spectrograma, adica magnitudinea FFT pentru fiecare fereastra in timp; vectorul
f, care contine frecventele corespunzatoare fiecarei componente din spectrograma;
si vectorul t, care indica momentele de timp la care incep fiecare dintre aceste
ferestre.
    Primul lucru pe care il fac este sa calculez cate ferestre complete pot
incapea in semnalul pe care il analizez, iar pentru asta folosesc functia floor
care taie partea zecimala. Apoi, stabilesc ca dimensiunea FFT-ului va fi dublul
marimii ferestrei, pentru ca adaug zerouri la segmentul analizat, un zero-padding.
Urmatorul pas este sa initializez matricea S, care va contine spectrograma.
Aceasta are un numar de randuri egal cu jumatate din dimensiunea FFT, pentru ca
FFT-ul unui semnal real este simetric si putem lua doar frecventele unice, si un
numar de coloane egal cu numarul de ferestre de timp. Apoi, creez o fereastra
Hann folosind functia hanning. 
    Dupa aceea, intru intr-un ciclu care parcurge fiecare fereastra a semnalului.
Pentru fiecare fereastra, calculez pozitia de inceput si de sfarsit in vectorul
semnalului, ca sa pot extrage segmentul corespunzator. Apoi copiez acele valori
intr-un vector nou, numit window_segment. Aplic fereastra Hann peste acest segment,
multiplicand fiecare element cu valoarea corespunzatoare din fereastra Hann,
pentru a atenua marginile si a reduce efectele de discontinuitate.
    Dupa ce am pregatit segmentul, aplic transformata Fourier rapida (FFT) pe el
pentru a obtine o rezolutie mai detaliata in frecventa. Din rezultatul FFT iau
doar jumatatea „reala” a datelor, pentru ca semnalul este real si FFT are simetrie,
iar apoi salvez magnitudinea fiecarei componente in matricea S, corespunzator
ferestrei si frecventei.
    La final, construiesc vectorul de frecvente f, care incepe de la 0 si creste
pana aproape de frecventa Nyquist, adica jumatate din frecventa de esantionare,
si vectorul timpilor t, care ma informeaza despre momentele in timp la care
incepe fiecare fereastra analizata.

DUPA RULAREA studio.m ----------------------------------------------------------
    Partea de jos a spectrogramului, care reprezinta frecventele joase, este
colorata predominant in rosu, ceea ce indica faptul ca aceste componente au
amplitudinea cea mai mare in semnal. Acest lucru sugereaza ca semnalul contine
multe frecvente joase, cum ar fi sunetele de bass din muzica, care au energi
mai puternica sub 1 kHz.
    In schimb, partea de sus a spectrogramului, corespunzatoare frecventelor 
inalte, devine treptat albastra, ceea ce arata ca aceste frecvente au o
amplitudine mai mica. Aceasta poate fi cauzata de un continut redus de inalte in
semnal sau  de limitarile echipamentului de inregistrare, cum ar fi microfonul
sau frecventa de esantionare.
    In jurul valorii de 0.25 secunde apare o dunga subtire portocalie, care
strabate toate frecventele simultan. Aceasta indica un eveniment brusc ce
afecteaza intreg spectrul de frecvente, cum ar fi un impuls sonor, o bataie de
tobe, un click sau un sunet de impact. De asemenea, poate fi cauzata de un
zgomot alb scurt sau o schimbare rapida a semnalului. Aceasta dunga evidentiaza
un punct important in evolutia temporala a semnalului.
    Toate celelalte au ramas neschimbate, in afara de Plain Sound care a devenit
full negru
 Bibliografie functie:
https://www.mathworks.com/help/matlab/ref/fft.html
https://www.mathworks.com/help/signal/ref/hann.html
https://www.mathworks.com/matlabcentral/answers/41903-hanning-window

3. oscillator.m
    Aceasta functie genereaza un semnal audio sinusoidal care urmeaza o forma de
evolutie in timp, numita ADSR — adica Attack, Decay, Sustain si Release. Am
inceput cu parametrii de baza: frecventa semnalului (freq), care determina
inaltimea sunetului, frecventa de esantionare (fs), care controleaza cat de des 
este luat un punct din semnal pe secunda, durata totala a semnalului (dur), precum
si cei patru parametri ADSR: A pentru attack, D pentru decay, S pentru nivelul de
sustain si R pentru release.
    Primul pas a fost sa determin cate puncte (samples) va avea semnalul,
inmultind durata cu frecventa de esantionare si rotunjind rezultatul cu round,
astfel incat sa obtin un numar intreg. Apoi am construit vectorul de timp t, care
merge de la 0 pana la finalul duratei, cu un pas de 1/fs. Acest vector imi ofera
toate momentele de timp la care va fi evaluat semnalul.
    Cu acest vector de timp am generat un semnal sinusoidal simplu, aplicand
formula clasica sin(2 * pi * freq * t). Rezultatul este un semnal periodic care
oscileaza la frecventa dorita, dar care nu are inca nicio variatie a amplitudinii
in timp — adica e “plat” din punct de vedere al dinamicii. Tocmai de aceea am
inceput sa construiesc envelope-ul de amplitudine care va fi aplicat peste acest
semnal pentru a-i da viata.
    Am calculat cate samples are fiecare dintre fazele ADSR. Pentru attack, decay
si release am folosit floor pentru a obtine numere intregi si a nu depasi lungimea
totala a semnalului. Faza de sustain am calculat-o ca tot ce ramane dupa ce scad
celelalte faze din totalul de samples. Apoi am generat continutul fiecarei faze:
pentru attack am construit o rampa de la 0 la 1; pentru decay am creat o tranzitie
de la 1 la valoarea de sustain S; sustain-ul este o perioada de amplitudine
constanta, iar release-ul este o cadere lina de la valoarea S la 0, adica o
stingere a sunetului.
    Toate aceste segmente le-am concatenat intr-un singur vector envelope, care
reprezinta evolutia amplitudinii in timp. In final, am inmultit acest envelope cu
semnalul sinusoidal generat anterior, punct cu punct, obtinand x-ul cautat.

DUPA RULAREA studio.m ----------------------------------------------------------
    Schimbarea s a produs in cadrul figurii Plain Sound. Imaginea de ansamblu
este dominata de un fundal albastru inchis, adica este in cea mai mare parte a
timpului foarte slab sau aproape inexistent. Acest lucru inseamna ca amplitudinea
semnalului este aproape zero pe durata majoritara, indicand o pauza sau o lipsa
de activitate sonora intre evenimentele importante.
    Totusi, la intervale regulate de timp, de exemplu, la 0.5 secunde, 1 secunda,
1.5 secunde si asa mai departe, apar linii groase si colorate in zona frecventei
de aproximativ 2000 Hz. Culorile acestor benzi variaza de larosu la galben la
verde, semn al unei amplitudini crescute in acele momente. Aceasta periodicitate
sugereaza ca oscilatorul genereaza un semnal scurt dar intens la fiecare 0.5
secunde, ceea ce inseamna o frecventa de aparitie de aproximativ 2Hz. Astfel,
putem interpreta ca oscilatorul emite un ton clar, dar doar in puncte precise de
timp, restul fiind inactiv, adica un bass sau tobe, probabil.
    Pe langa aceste emisii puternice, se observa si o tranzitie spre albastru
deschis in zona frecventelor inalte (peste 2000 Hz), semn ca exista si componente
cu amplitudine mica, dar detectabila. Acestea pot fi zgomote de fond sau armonici
slabe ale semnalului principal. In plus, in spectrograma apar si linii foarte
subtiri, exact intre momentele principale (de exemplu, la 0.75s sau 1.25s) care
au o culoare initiala rosie si care apoi se estompeaza. Acestea pot fi impulsuri
foarte scurte, cu amplitudine mare la inceput si o scadere rapida, poate chiar
artefacte digitale sau glitch-uri produse de recalculari interne ale oscilatorului.
Bibliografie:
https://www.mathworks.com/help/matlab/ref/double.linspace.html
https://www.mathworks.com/matlabcentral/answers/887174-creating-ramp-signal-from-1-to-1
https://www.mathworks.com/help/matlab/ref/vertcat.html

4. high_pass.m
    Aceasta functie implementeaza un filtru trece-sus (high-pass filter) in
domeniul frecventa folosind FFT (Fast Fourier Transform). Totul incepe cu linia
de definitie a functiei, unde precizez ca voi lucra cu trei argumente: x, adica
semnalul pe care vreau sa-l filtrez, fs, frecventa de esantionare, si cutoff_freq,
frecventa de taiere. Functia va intoarce semnalul filtrat, pe care l-am numit signal.
    Mai departe, m-am asigurat ca vectorul x are forma corecta, transformandu-l
intr-un vector coloana. E o masura de siguranta, ca sa evit erorile legate de
orientarea datelor in timpul prelucrarii. Apoi am calculat lungimea semnalului,
numarul total de samples, si am aplicat FFT pentru a-l converti din domeniul timp
in domeniul frecventa. Astfel, am obtinut un vector complex care contine informatii
despre amplitudinea si faza fiecarei componente de frecventa.
    Pentru a putea filtra frecventele, am avut nevoie de un vector de frecvente
care sa corespunda coeficientilor FFT. La inceput, aceste frecvente cresc de la
0 pana aproape de fs, dar cum FFT-ul MATLAB are o conventie de simetrie,
frecventele de dupa fs/2 reprezinta, de fapt, componente negative. Asa ca am
corectat vectorul scazand fs din valorile mai mari de fs/2, obtinand un vector f
centrat pe 0 si complet simetric.
    Urmatorul pas a fost sa construiesc o masca binara — un vector format din 1
si 0 — care selecteaza doar frecventele al caror modul este mai mare decat
cutoff_freq. Am folosit abs(f) ca sa iau valoarea absoluta a frecventelor, iar
double(...) pentru a transforma rezultatul intr-un vector numeric compatibil cu
operatiile urmatoare. Cu aceasta masca, am filtrat coeficientii FFT: am pastrat
doar componentele dorite, cele din gama inalta, iar pe cele de frecventa joasa
le-am anulat.
    Dupa filtrare, am reconstruit semnalul in domeniul timp aplicand transformata
Fourier inversa (IFFT). Deoarece pot aparea mici erori numerice in urma FFT-ului,
am folosit real(...) ca sa pastrez doar partea reala a rezultatului. La final,
am normalizat semnalul, adica l-am impartit la valoarea sa absoluta maxima, pentru
ca amplitudinea sa nu depaseasca 1 si sa mentin un volum constant in iesire.

DUPA RULAREA studio.m ----------------------------------------------------------
Dupa ce am aplicat filtrul high-pass s-au modificat figurile High Pass Sound, Tech
si High Pass Tech
a. High Pass Sound: 
    Fundalul este turcoaz, semn ca exista un zgomot de fond cu amplitudine mica,
mai vizibil in frecventele medii si inalte. Acest zgomot poate fi un rest dupa
filtrare sau o componenta larga a semnalului care nu a fost eliminata complet.
    Se observa o dunga semigroasa in jurul a 0.40 secunde, pozitionata la
aproximativ 1000 Hz, cu tranzitii de culoare de la portocaliu la visiniu, galben
si verde. Aceasta indica un eveniment temporal concentrat spectral, unde portocaliul
marcheaza amplitudinea maxima, iar culorile mai reci scaderea rapida a acesteia.
La 0.75 secunde apare o linie foarte subtire, formata din cativa pixeli, cu culor
verde si galben, ce reprezinta un impuls scurt, cu continut de frecvente inalte,
care a trecut prin filtrul aplicat.
    O linie portocalie intensa, constanta la 100 Hz, paralela cu axa timpului,
sugereaza o componenta persistenta ce nu este complet eliminata de filtru. Aceasta
poate reprezenta frecventa de taiere sau o componenta reziduala.
    Din punct de vedere tehnic, linia de la 100 Hz indica faptul ca filtrul
high-pass atenueaza frecventele sub aceasta valoare, dar nu complet, existand
posibil o ondulatie in banda oprita. Dungile temporale arata ca evenimentele cu
frecvente inalte au trecut prin filtru, iar amplitudinea redusa comparativ cu
semnalul original confirma actiunea filtrului.
b. Tech:
    La frecvente inalte, peste 10.000 Hz, domina o culoare turcoaz, semn al unui
zgomot termic sau de cuantizare, cu amplitudine constanta si scazuta, tipica
echipamentelor electronice digitale. Sub 1000 Hz, apar culori calde precum rosu
si portocaliu, cu o dunga rosie paralela cu axa timpului, indicand o componenta
continua joasa, posibil zgomot de alimentare (50/60 Hz), rumble acustic sau
componenta DC nefiltrata.
    Evenimentele periodice se manifesta prin dungi verticale la fiecare 80 ms
(12.5 Hz), cu energie concentrata sub 16 kHz si o taietura clara la aceasta
frecventa, indicand o limitare antialiasing. Culorile stratificate (rosu, portocaliu,
galben-verde) arata prezenta armonicilor multiple, sugerand un semnal digital.
    Componenta joasa constanta poate proveni din bucle de impamantare, interferente
electromagnetice sau artefacte digitale, fiind persistenta si limitata clar sub
1000 Hz. Posibile surse includ dispozitive digitale cu clock-uri si semnale de
control, DAC-uri cu frecventa de update 12.5 Hz sau echipamente cu zgomot de
alimentare si limitari hardware. Spectrograma reflecta astfel influente digitale,
hardware si de procesare care contureaza continutul frecvential al semnalului.
c. High Pass Tech:
    Am analizat figura si am observat trei zone importante. Prima zona, intre 0
si 1000 Hz, are o dunga verde continua, ceea ce arata prezenta unui zgomot de
fundal cu amplitudine medie. Aceasta este probabil o parte a semnalului care nu
a fost complet filtrata, semnaland ca filtrul nu elimina total frecventele joase.
Zona dintre 1000 si 10.000 Hz este dominata de culoarea rosie, ceea ce indica un
semnal puternic si stabil. Acest semnal pare sa fie un purtator sau o componenta
digitala care nu sufera multe schimbari in timp. Este un semnal constant, fara
modulatii mari.
    Peste 14.000 Hz fundalul este verde deschis, ceea ce inseamna ca exista un
zgomot de fond slab, specific frecventelor inalte dupa aplicarea filtrului. Un alt
aspect important este prezenta unor dungi groase rosii care apar la fiecare 0,5
secunde, adica la 2 Hz. Aceste dungi se intind pana la 16 kHz si au margini clare,
ceea ce arata ca sunt impulsuri scurte, probabil semnale digitale sau comutari
rapide. Intre aceste impulsuri, zona este portocalie cu mici pete galbene, ceea
ce poate fi un efect secundar sau un semnal mai slab.
    Taietura brusca a spectrului la 16 kHz este cauzata probabil de limitarile
echipamentului, cum ar fi filtrul anti-aliasing sau frecventa Nyquist. Dupa
filtrarea high-pass, zgomotul verde din zona joasa ramane vizibil, ceea ce
inseamna ca filtrul nu elimina complet frecventele sub 1000 Hz. Totusi,
impulsurile la 2 Hz raman neatinse, semn ca filtrul lasa sa treaca aceste
frecvente. Filtrul reduce zgomotul de fond si face semnalele utile mai clare in
spectrul inalt.

Bibliografie:
https://www.mathworks.com/help/matlab/ref/ifft.html
https://www.mathworks.com/matlabcentral/answers1958349-why-am-i-getting-complex-values-with-ifft

5. apply_reverb
Aceasta functie aplica un efect de reverberatie asupra unui semnal audio folosind
un raspuns la impuls (impulse response). Mai intai, convertesc raspunsul la impuls
in mono, pentru a simplifica prelucrarea, folosind functia stereo_to_mono. Apoi,
fac acelasi lucru cu semnalul original, pentru a avea ambele semnale pe un singur
canal. Dupa ce semnalele sunt mono, aplic convolutia dintre semnal si raspunsul
la impuls folosind functia fftconv, care face convolutia eficient prin transformata
Fourier rapida (FFT). Convolutia combina semnalul initial cu caracteristicile
acustice definite de raspunsul la impuls, creand efectul de reverberatie. La
final, normalizez semnalul rezultat impartindu-l la amplitudinea sa maxima,
pentru a evita distorsiunea si a pastra nivelul volumului in limite optime.
Astfel, functia returneaza semnalul reverberat, pregatit pentru redare sau
procesare ulterioara.

DUPA RULAREA studio.m ----------------------------------------------------------
a.  Reverb Sound
    Dupa aplicarea reverberatiei, spectrograma arata trei faze clare: in primele 5
secunde sunt armonice intense, intre 5 si 8 secunde energia scade treptat, iar
dupa 8 secunde semnalul dispare aproape complet. O dunga puternica la 2000 Hz
ramane constanta pe toata durata, probabil tonul principal al semnalului.
    Sub 2000 Hz exista o zona cu armonice joase si energie consistenta. Dungile
portocalii periodice, la fiecare 0.5 secunde, indica un efect de modulatie sau
chorus, extinzandu-se pana la 17500 Hz.
    Decaderea energiei nu este lina, ci brusca, ceea ce sugereaza o procesare
digitala cu posibil gate. Modelul periodic la 2 Hz si tranzitiile bruste arata
artefacte cauzate probabil de procesarea pe blocuri fixe. Timpul de decadere al
reverberatiei este scurt, iar reflexiile sunt putin dense, indicand un efect
simplificat.
b.  Reverb Tech
Spectrograma dupa reverberatie prezinta un semnal puternic si constant pe 0-18 kHz
(rosu intens), probabil un sunet digital sau zgomot filtrat. La fiecare 0.5 secunde
(2 Hz) apar dungi verticale visinii, care indica o procesare pe blocuri fixe sau
artefacte de recalculare a reverberatiei. Peste 18 kHz, amplitudinea scade brusc
(galben-verde), cauzat probabil de limitari
hardware sau filtre antialiasing.
    Comparativ cu reverberatiile naturale, aici se remarca lipsa unei decaderi
spectrale naturale, prezenta artefactelor periodice la 2 Hz si o tranzitie brusca
la frecvente inalte, semn ca reverberatia este procesata digital cu anumite limitari.
c.  High Pass + Reverb Tech
    Spectrograma arata un semnal dominant intre 0 si 10 kHz, evidentiat printr-un
rosu intens si constant, indicand un semnal de baza puternic procesat. Filtrul
high-pass elimina frecventele sub 800-1000 Hz, iar reverberatia adauga un timp
de decadere lung, peste 11 secunde, oferind densitate spectrala si senzatie de
spatialitate.
    Dungile verticale periodice apar la fiecare 0.5 secunde (2 Hz), extinzandu-se
pana la 18 kHz. Structura lor coloristica trece de la rosu intens la verde si
albastru, indicand artefacte de procesare, probabil din interferenta dintre
frecventa de actualizare a reverberarii si frecventa de taiere a filtrului,
cauzand modulatii nedorite de amplitudine sau faza.
    Banda orizontala verde-galbuie sub 1000 Hz are amplitudine medie si stabila,
semnaland reziduuri ale filtrarii sau artefacte de faza. Taietura brusca in jur
de 18 kHz reflecta limitarile hardware/software, precum filtrul antialiasing si
frecventa Nyquist, reducand rezolutia spectrala peste aceasta frecventa.
d.  Reverb + High Pass Tech 
    Aceasta arata aproximativ la fel cu cea anterioara, principala diferenta fiind
cantitatea de albastru inchis prezent in spectrograma. In varianta „Reverb + High
Pass” albastrul inchis este mult redus comparativ cu „High Pass + Reverb”, desi
structura generala ramane similara. Tranzitiile cromatice sunt mai line, iar
contrastul general este mai atenuat in cazul „Reverb + High Pass”.
    Din punct de vedere tehnic, ordinea aplicarii efectelor influenteaza
semnificativ rezultatul. Cand filtrul high-pass este aplicat inaintea reverberarii,
acesta elimina frecventele joase, iar reverbul proceseaza doar frecventele inalte.
Acest lucru duce la pastrarea mai multor artefacte in zona inalta a spectrului.
In schimb, daca reverbul este aplicat inainte de filtrul high-pass, acesta
proceseaza intreg spectrul, iar filtrul elimina ulterior zgomotul si artefactele
generate de reverberatie, rezultand un semnal mai curat.
    Acest lucru afecteaza continutul spectral: filtrul aplicat dupa reverberatie
reduce artefactele si zgomotul de frecventa inalta generate de reverb, in timp 
ce ordinea inversa pastreaza mai multe artefacte, care apar ca linii albastre in
spectrograma. Reducerea culorii albastre in „Reverb + High Pass” indica o atenuare
mai mica a frecventelor inalte, pastrand mai multe armonice si componente
reziduale peste 10 kHz. In „High Pass + Reverb”, reverbul nu vede toate frecventele,
astfel ca artefactele nu sunt eliminate eficient, rezultand un spectru mai zgomotos.
Bibliografie:
https://www.mathworks.com/matlabcentral/fileexchange/5703-fftconv

------------------------------------ TASK 2 ------------------------------------

    Acest task simuleaza partea autonoma a unui robot folosind metode de
interpolare pentru a determina o traiectorie care trece printr-un set de puncte
date. Se utilizeaza doua metode principale: Spline Cubic Natural (C^2) si
Interpolarea Vandermonde. In prima, se construieste un sistem de ecuatii pentru
a determina coeficientii polinoamelor cubice pe fiecare interval, asigurand
continuitatea valorii, primei si celei de-a doua derivate. In cea de-a doua se
determina un singur polinom de grad minim care trece exact prin toate punctele
date. Sistemul liniar asociat se bazeaza pe matricea Vandermonde, iar solutia
furnizeaza coeficientii polinomului. 

1. parse_data.m
    Functia aceasta are rolul de a citi datele de intrare dintr-un fisier text
si de a le returna sub forma de vectori coloana. Deschid fisierul in modul read
utilizand fopen. Citesc datele corespunzatoare, anume o valoare intreaga (n),
valori reale pentru x (n+1) si valori reale pentru y (n+1). La final inchid
fisierul cu fclose.

2. spline_c2.m
    Scopul acestei functii este de a calcula coeficientii pentru interpolarea cu
spline cubice naturale. Incep prin a calcula numarul de intervale n, deoarece
pentru n+1 puncte am nevoie de n polinoame cubice. Apoi determin numarul total
de coeficienti necesari (4 coeficienti (a, b, c, d) pentru fiecare interval)
adica 4*n. Initializez matricea sistemului A cu dimensiunea 4n x 4n, plina initial
cu zerouri, si vectorul termenilor liberi b de dimensiune 4n x 1, tot cu zerouri.
Acestea vor forma sistemul liniar pe care il voi rezolva.
    Prima conditie pe care o impun este ca fiecare spline sa treaca exact prin
punctele date. Pentru fiecare interval i de la 1 la n, setez A(i,4*(i-1)+1)=1
pentru coeficientul a_i si pun valoarea y(i) in b(i). Pentru ultimul punct al
ultimului interval, calculez diferenta dif intre ultimele doua puncte x. Completez
randul n+1 al matricei A cu coeficientii corespunzatori: 1 pentru a_(n-1), dif
pentru b_(n-1), dif^2 pentru c_(n-1) si dif^3 pentru d_(n-1), iar in b(n+1) pun
valoarea y(n+1). Apoi tratez continuitatea functiilor in punctele interioare.
Pentru fiecare punct interior i, calculez diferenta dif intre x(i+1) si x(i) si
completez randurile corespunzatoare din A. In ceeace priveste continuitatea
derivatelor de ordinul intai, pentru fiecare punct interior, completez randurile
corespunzatoare din A cu coeficientii care asigura egalitatea derivatelor. La fel
procedez si pentru derivatele de ordinul doi, completand randurile potrivite din
matrice.  Mai apoi derivata a doua este nula la capete. Pentru primul capat, setez
A(4n-1,3)=2 (coeficientul c_0) si b(4n-1)=0. Pentru ultimul capat, calculez
diferenta dif si completez ultimul rand al matricei A cu coeficientii
corespunzatori, punand 0 in b(4n).
    In final, rezolv sistemul liniar A*coef=b prin inversarea matricei A si
inmultirea cu vectorul b. Solutia coef contine toti coeficientii polinoamelor
cubice pe fiecare interval, pe care ii returnez pentru a fi folositi in evaluarea
spline-ului.

3. P_spline.m
    Incep prin a initializa vectorul rezultat y_interp cu aceeasi dimensiune ca
vectorul x_interp, umplandu-l cu zerouri. Acesta va stoca valorile interpolate
pentru fiecare punct din x_interp. Pentru fiecare punct x_val din vectorul x_interp,
mai intai determin intervalul corespunzator din vectorul x in care se afla punctul
curent, pornesc de la primul interval (interval = 1) si parcurg secvential
intervalele pana cand gasesc intervalul unde x(interval) ≤ x_val < x(interval+1).
Daca x_val este mai mare decat toate punctele din x, il asociez cu ultimul interval.
Dupa ce am identificat intervalul corect, extrag coeficientii polinomului cubic
asociat, calculand pozitia de inceput a coeficientilor in vectorul coef folosind
formula 4*(interval-1) + 1 si exxtragand coeficientii a, b, c, d pentru polinomul
cubic al intervalului curent
    Mai apoi calculez distanta dintre punctul curent x_val si capatul din stanga
al intervalului si calcule polinomul cubic folosind formula a + b*distanta +
c*distanta^2 + d*distanta^3. Aceasta formula reprezinta expansiunea polinomului
in jurul capatului stang al intervalului. Stochez rezultatul in vectorul y_interp
la pozitia corespunzatoare si functia ajunge la bun sfarsit.

4. Vandemonde.m
    Aceasta functie are rolul de a calcula coeficientii polinomului de interpolare
folosind metoda Vandermonde Incep prin a determina gradul polinomului de
interpolare. Calculez n = length(x) - 1 deoarece pentru n+1 puncte de interpolare,
am nevoie de un polinom de grad n. Initializez matricea Vandermonde V ca o matrice
patratica de dimensiune (n+1)×(n+1) plina initial cu zerouri. Apoi o completez
folosind doua for-uri, unul pentru fiecare punct de interpolare (de la 1 la n+1)
si celalalt pentru a construi fiecare coloana a matricei. Fiecare element V(i,j)
se calculeaza ca fiind x(i)^(j-1). Dupa ce am construit matricea Vandermonde,
rezolv sistemul liniar V*coef = y  inversand matricea V si inmultind-o cu y,
facand rost de coeficientii polinomului de interpolare astfel.

5. P_vandermonde
    Scopul acestei functii este de a evalua polinomul de interpolare Vandermonde
in punctele specificate. Incep prin a crea vectorul y_interp care va stoca
rezultatele evaluarii. Dimensiunea sa este identica cu x_interp si este
initializat cu zerouri. Apoi determin gradul polinomului n ca lungimea vectorului
de coeficienti minus 1. Mai apoi, pentru  fiecare punct x_interp(i) din vectorul
de intrare, intializez valoarea cu ultimul coeficient, si de n ori inmultesc cu
x_i si adun coeficientul I astfel incat sa obtin
a_0 + x(a_1 + x(a_2 + x(a_3 +...+ x(a_n-1 + x⋅a_n)..)). Dupa acestea, stochez
valoarea in y_interp(i) pentru fiecare in parte si functia ajunge la final.


------------------------------------ TASK 3 ------------------------------------

1.	read_mat.m
    Codul acesta este rpoximativ 1:1 cu cel din prima tema. Am inceput prin a
defini o functie care primeste ca argument un sir de caractere path, care
reprezinta calea catre un fisier CSV. Scopul functiei este sa citesc acest fisier
si sa returnez o matrice cu valorile din el, fara antetele de la randuri si
coloane. Am deschis fisierul pentru citire, folosind fopen. Am sarit peste prima
linie a fisierului, care contine antetul coloanelor. Am creat o matrice goala,
in care voi adauga pe rand valorile extrase din fisier. Am inceput o bucla care
ruleaza pana cand ajung la sfarsitul fisierului (feof => EOF (End Of File), iar
cu ~ neg.) Am citit o linie din fisier ca sir de caractere si am salvat-o in
variabila linie. Am impartit linia citita in mai multe parti, despartind dupa
virgule. Astfel, fiecare element devine un string separat in vectorul elemente.
Am eliminat primul element din vector, care corespunde antetului randului. Am
convertit sirurile de caractere din valori in numere. Am adaugat vectorul de
numere ca un nou rand in matricea mea mat. Practic construiesc matricea pe
randuri, una cate una. Dupa toate acestea, inchid fisierul si functia ajunge la
sfarsit.

2.	preprocess.mat
    Scopul acesteai functii este sa elimine toate randurile (utilizatorii) care
au mai putine recenzii decat min_reviews. Mai intai, am aflat cate randuri si
coloane are matricea mat. Am creat un vector coloana de zerouri, care va pastra
numarul de recenzii pentru fiecare utilizator. Initial, toate valorile sunt 0.
Am inceput sa parcurg fiecare rand (utilizator) si am initializat un contor cnt
cu 0 pentru a numara recenziile lui. Pentru fiecare coloana a utilizatorului
curent, verific daca valoarea nu este zero, ceea ce inseamna ca exista o recenzie.
Daca da, cresc contorul cnt cu 1. Dupa ce am numarat toate recenziile
utilizatorului i, salvez rezultatul in vectorul nr_de_reviewuri pe pozitia
corespunzatoare. Am creat un vector logic utilizatori_buni de aceeasi dimensiune
ca nr_de_reviewuri, initializat cu false, unde voi marca utilizatorii care au
suficiente recenzii. Am parcurs fiecare element din nr_de_reviewuri si, daca
numarul de recenzii e mai mare sau egal cu min_reviews, setez true in vectorul
utilizatori_buni pe pozitia respectiva, altfel ramane false. Am filtrat matricea
originala mat, luand doar randurile pentru care utilizatori_buni este true.
Astfel, elimin toate randurile cu prea putine recenzii si functai ajunge la final.

3.	cosine_similarity.m
    Aceasta functie primeste doi vectori coloana A si B, si returneaza un numar
similarity care reprezinta similaritatea cosinus dintre acesti doi vectori. Mai
intai am calculat Am calculat produsul scalar (dot product) dintre vectorii A si
B. Apoi am calculat norma (lungimea) fiecarui vector. La final am impartit produsul
scalar la produsul normelor celor doi vectori, iar apoi functia ajunge la sfarsit.

4.	recommendations.m
    Scopul functiei e sa imi returneze un vector cu cele mai bune num_recoms
teme care seamana cu liked_theme. Mai intai am citit fisierul CSV folosind functia
read_mat. Mai apoi m eliminat utilizatorii care au prea putine recenzii (mai
putine decat min_reviews) utilizandu-ma de functia preprocess. Am aplicat SVD
trunchiat pe matricea A si am pastrat doar matricea V, care contine reprezentarile
temelor. Am aflat cate teme am, uitandu-ma la numarul de randuri din V. Am creat
un vector gol, in care voi stoca similaritatea cosinus dintre tema preferata si
toate celelalte teme. Am inceput un for in care parcurg toate temele, ca sa le
compar cu tema preferata. Daca ajung chiar la tema preferata, ii pun similaritate
-Inf ca sa ma asigur ca nu o recomand din nou. In caz contrar, iau vectorul temei
curente, il transpun (ca sa fie coloana) si calculez similaritatea cosinus cu tema
preferata. Apoi salvez scorul in vectorul similaritati. Am sortat temele dupa
similaritate in ordine descrescatoare — cele mai asemanatoare vin primele. Am
luat primele num_recoms teme din lista sortata, iar apoi am transpus rezultatul
ca sa fie vector linie, functia ajungand la final.