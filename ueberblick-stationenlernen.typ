/*--------------------------------------------*
* Überblickstext im Stil der Stationskarten   *
* Hochformat-Version für die Seminarabgabe    *
*--------------------------------------------*/

#import "@preview/ccicons:1.0.1": *
#import "@preview/zebra:0.1.0": qrcode


/*---------------------------------------------------------------*
* Die Datei orientiert sich gestalterisch an den vorhandenen      *
* Stationskarten, verzichtet aber bewusst auf externe Pakete und   *
* Bilddateien, damit sie als eigenständige Typst-Datei nutzbar ist.*
*---------------------------------------------------------------*/

#let title-line = [Überblick Stationenlernen: Komplexität, Laufzeit und Sortieren]
#let author-line = "A. Firle - I. Rhöse - J. Müller -"
#let description-line = [Weiterbildungskurs Informatik 08 - Baustein 05 Didaktik - #cc-by-nc-sa]

#set document(
  title: title-line,
  author: author-line,
  description: description-line,
)

#set page(
  paper: "a4",
  margin: (top: 2.4cm, bottom: 1.9cm, left: 1.5cm, right: 1.5cm),
  header: context [
    #title-line
    #line(length: 100%)
  ],
  footer: context [
    #line(length: 100%)
    #author-line
    #description-line
    #h(1fr)
    Seite #counter(page).display()
  ],
)

#set text(lang: "de", size: 11pt)
#set par(justify: true, leading: 0.95em)
#set heading(numbering: none)

#let blue = rgb("#2E5E8A")
#let light-blue = rgb("#EEF6FC")
#let green = rgb("#EAF7EC")
#let yellow = rgb("#FFF6D8")
#let red = rgb("#FFF0EF")
#let gray = rgb("#F6F7F8")
#let dark = rgb("#33414D")
#let repo-url = "https://github.com/JMueller-edu/Pruefungsaufgabe_Didaktik_Info_08.git"

#show heading.where(level: 1): it => block(
  below: 8pt,
  above: 14pt,
)[
  #text(size: 14pt, weight: "bold", fill: blue)[#it.body]
]

#show heading.where(level: 2): it => block(
  below: 6pt,
  above: 10pt,
)[
  #text(size: 11.5pt, weight: "bold", fill: blue)[#it.body]
]

#let infobox(title, body, fill: light-blue) = block(
  inset: 10pt,
  radius: 8pt,
  stroke: 0.85pt + rgb("#9CBBD1"),
  fill: fill,
  width: 100%,
  below: 8pt,
)[
  #text(weight: "bold", fill: blue)[#title]
  #v(2pt)
  #body
]

#let chip(title, body) = block(
  inset: 8pt,
  radius: 8pt,
  stroke: 0.7pt + rgb("#C7D2DB"),
  fill: gray,
  width: 100%,
)[
  #text(size: 8.5pt, weight: "bold", fill: blue)[#title]
  #v(2pt)
  #text(size: 9pt)[#body]
]

#let meta-line(label, value) = [
  #text(weight: "bold", fill: blue)[#label:] #value
]

#let stationbox(title, facette, lernziel, prinzip, body, fill: light-blue) = block(
  inset: 10pt,
  radius: 8pt,
  stroke: 0.85pt + rgb("#C7D2DB"),
  fill: fill,
  width: 100%,
  below: 9pt,
)[
  #text(size: 11.5pt, weight: "bold", fill: blue)[#title]
  #v(4pt)
  #meta-line([Facette], facette)
  #v(3pt)
  #meta-line([Lernziel], lernziel)
  #v(3pt)
  #meta-line([Unterrichtsprinzip], prinzip)
  #v(6pt)
  #body
]

#let headline-box() = block(
  inset: 12pt,
  radius: 10pt,
  fill: blue,
  width: 100%,
  below: 8pt,
)[
  #set text(fill: white)
  #grid(
    columns: (2.8fr, 0.5fr, 1.5fr),
    gutter: 12pt,
    [
      #text(size: 16.5pt, weight: "bold")[Überblick zum Stationenlernen]
      #linebreak()
      #text(size: 13.5pt, weight: "bold")[Komplexität, Laufzeit und Sortieren]
      #v(3pt)
      #text(size: 8.8pt)[Informatik - Klasse 10 ]
      \
      #text(size: 7pt)[_Dieses Material wurde im Textsatzsystem Typst mit Unterstützung von ChatGPT erstellt_]
    ],
    [#align(right)[
        #qrcode(repo-url, height: 60pt, background-fill: white)
      ]],
    [
      #align(right)[
        #block(
          inset: 8pt,
          radius: 8pt,
          fill: white,
          width: 100%,
        )[
          #set text(fill: dark)
          #text(size: 8.8pt, weight: "bold", fill: blue)[Überblick]
          #v(4pt)
          #text(size: 8.2pt)[Vier Stationen]
          #linebreak()
          #text(size: 8.2pt)[2–3 Doppelstunden]
          #linebreak()
          #text(size: 8.2pt)[Lernende der Jahrgangsstufe 10]
        ]
      ]
    ],
  )
]

#headline-box()

#grid(
  columns: (1.15fr, 0.85fr, 2fr),
  gutter: 8pt,
  chip([Zielgruppe], [Wahlunterricht Informatik, gymnasialer Bildungsgang, Jahrgangsstufe 10]),
  chip([Umfang], [zwei bis drei \ Doppelstunden \ \ ]),
  chip([Vorwissen], [Die Lernenden können einfache Handlungsvorschriften lesen und ausführen, Werte vergleichen und Ergebnisse in vorgegebenen Darstellungen festhalten.]),
)

#infobox([Zielgruppe und didaktischer Rahmen], [
  Die vorliegende Stationenarbeit zum Themenkreis *Komplexität, Laufzeit und Sortieren* umfasst vier inhaltlich aufeinander bezogene Stationen zu den Themen *Selection Sort*, *Insertion Sort*, *Merge Sort* sowie *Laufzeit und Wachstum*. Sie ist für eine Unterrichtssequenz von zwei bis drei Doppelstunden konzipiert und richtet sich an eine Lerngruppe der Jahrgangsstufe 10 im Wahlunterricht Informatik des gymnasialen Bildungsgangs.

 Erste Erfahrungen mit dem Begriff *Algorithmus* sind hilfreich, aber nicht zwingend erforderlich, da die Stationen bewusst konkret, anschaulich und handlungsnah gestaltet sind. Insgesamt verfolgt die Reihe das Ziel, dass die Lernenden Sortierverfahren nicht nur praktisch durchführen, sondern auch für ihre zugrunde liegende Idee, ihre Struktur und ihren Aufwand sensibilisiert werden.
])

#infobox([Reihenfolge und Abhängigkeiten], [
  Für die Reihenfolge der Stationen bietet es sich an, zunächst mit *Selection Sort* und *Insertion Sort* zu beginnen, da beide Verfahren mit Kartenmaterial besonders gut nachvollzogen werden können und somit einen niedrigschwelligen Einstieg in algorithmisches Denken ermöglichen. Die Station *Laufzeit und Wachstum* kann darauf aufbauend den Blick von der bloßen Ausführung eines Verfahrens auf die Frage nach dem Aufwand und dessen Wachstum lenken. *Merge Sort* eignet sich besonders als vertiefende Station am Ende der Reihe, da hier mit dem Zerlegen in Teilprobleme, dem rekursiven Vorgehen und dem anschließenden Zusammenführen bereits ein höheres Maß an Abstraktion gefordert wird.

  *Selection Sort* und *Insertion Sort* sind weitgehend unabhängig voneinander bearbeitbar; die Laufzeitstation profitiert jedoch davon, dass die Lernenden zuvor bereits mindestens ein Sortierverfahren kennengelernt haben, und *Merge Sort* setzt ein grundlegendes Verständnis algorithmischer Abläufe voraus.
], fill: green)


= Stationen im Überblick

#stationbox(
  [Station 1: Selection Sort],
  [systematisches Auswählen beim Sortieren],
  [Die Lernenden können Selection Sort erklären und selbst anwenden sowie erkennen, dass nach jedem Durchgang genau ein weiteres Element sicher an seiner endgültigen Position liegt.],
  [handlungsorientiertes Lernen],
  [
    Die Station zu *Selection Sort* behandelt die Idee, dass in jedem Schritt das kleinste Element im noch unsortierten Bereich gesucht und an die nächste freie Position am Anfang getauscht wird. Die Lernenden setzen sich damit auseinander, wie auf diese Weise schrittweise Ordnung entsteht und wie ein Verfahren durch wiederholte, klar strukturierte Einzelschritte beschrieben werden kann.

    Das handlungsorientierte Lernen ist hier besonders geeignet, da die Lernenden den Algorithmus eigenständig mit Material ausführen, ihre Schritte planen, durchführen und kontrollieren. Der Lernprozess ist dadurch eng an konkretes Handeln gebunden und unterstützt ein nachvollziehbares Verständnis des Verfahrens.
  ],
  fill: light-blue,
)

#stationbox(
  [Station 2: Insertion Sort],
  [Ordnungsaufbau durch Einfügen],
  [Die Lernenden können Insertion Sort erklären und anwenden sowie den Unterschied zu Selection Sort benennen.],
  [entdeckendes Lernen],
  [
    Die Station zu *Insertion Sort* beleuchtet die Idee, dass nicht das kleinste Element im unsortierten Rest gesucht wird, sondern jeweils das nächste Element an die passende Stelle in einen bereits geordneten Teil eingefügt wird. Die Lernenden erkennen dadurch, dass verschiedene Algorithmen dasselbe Problem auf unterschiedliche Weise lösen können.

    Das entdeckende Lernen ist hier besonders passend, weil die Lernenden aus der konkreten Arbeit mit dem Material selbst das Strukturprinzip des Verfahrens rekonstruieren. Auf diese Weise entwickeln sie ein eigenes Verständnis dafür, wie Ordnung schrittweise aufgebaut werden kann.
  ],
  fill: yellow,
)

#stationbox(
  [Station 3: Laufzeit und Wachstum],
  [Laufzeit, Effizienz und Wachstum des Aufwands],
  [Die Lernenden können den Zusammenhang zwischen Problemgröße und Laufzeit beschreiben und den Effizienzgedanken als wesentliches Kriterium informatischer Verfahren verstehen.],
  [ganzheitliches Lernen],
  [
    Die Station *Laufzeit und Wachstum* richtet den Blick auf die Frage, wie stark der Aufwand eines Verfahrens mit zunehmender Problemgröße anwächst. Ausgangspunkt ist eine alltagsnahe Modellierungssituation, anhand derer die Lernenden untersuchen, dass ein Verfahren zwar korrekt sein kann, sein Aufwand aber dennoch stark wachsen kann. Dadurch wird der Effizienzgedanke als zentrales informatisches Kriterium sichtbar.

    Das ganzheitliche Lernen eignet sich hier besonders, weil die Station einen alltagsnahen Zugang mit sprachlicher, tabellarischer und informatischer Modellierung verbindet und damit mehrere Zugänge zum Lerngegenstand eröffnet.
  ],
  fill: green,
)

#stationbox(
  [Station 4: Merge Sort],
  [effizienteres Sortieren durch Zerlegen und Zusammenführen],
  [Die Lernenden können Merge Sort erklären und anwenden sowie das Grundprinzip des rekursiven Vorgehens in Ansätzen beschreiben.],
  [entdeckendes Lernen],
  [
    Die Station zu *Merge Sort* behandelt die Idee, ein Problem zunächst in kleinere Teilprobleme zu zerlegen, diese zu lösen und die Ergebnisse anschließend geordnet zusammenzuführen. Damit begegnen die Lernenden zugleich einem ersten Zugang zum Prinzip der Rekursion. Die Station erweitert den Blick über lineare Sortierverfahren hinaus und macht eine stärker strukturierende algorithmische Denkweise sichtbar.

    Auch hier ist das entdeckende Lernen besonders passend, da sich das Verfahren schrittweise aus Beispielen, Strukturierungen und der praktischen Durchführung erschließen lässt.
  ],
  fill: red,
)

= Gemeinsamer Lehrplanbezug

#infobox([Einordnung in das Kerncurriculum Hessen], [
  Die gesamte Unterrichtsreihe lässt sich gut in das *Kerncurriculum Hessen für den Wahlunterricht Informatik in der Sekundarstufe I des gymnasialen Bildungsgangs* einordnen. Besonders einschlägig ist der inhaltsbezogene Kompetenzbereich *Algorithmen (I1)*, in dem unter anderem gefordert wird, dass Lernende wesentliche algorithmische Eigenschaften erkennen, verschiedene Beschreibungsformen von Algorithmen ineinander überführen sowie Algorithmen analysieren, interpretieren und entwerfen.

  Darüber hinaus nennt das Kerncurriculum im Themenfeld *Grundlagen der Programmierung* ausdrücklich *Anweisungen, Sequenzen, Eigenschaften von Algorithmen* und *Darstellungen von Algorithmen*. Die vorliegende Stationenarbeit greift diese Vorgaben in besonderer Weise auf, da die Lernenden verschiedene Sortierverfahren handelnd nachvollziehen, beschreiben, vergleichen und im Hinblick auf ihren Aufwand reflektieren. Für die Station zu *Merge Sort* ist zudem anschlussfähig, dass das Kerncurriculum das Anwenden von *Bäumen als Strukturierungsprinzip* vorsieht. Insgesamt fördert die Reihe damit sowohl inhaltsbezogene als auch prozessbezogene Kompetenzen des hessischen Informatikunterrichts.
], fill: light-blue)

= Quellenhinweis

#infobox([Verwendete Bezugsquellen], [
  - DigLL, Überblick über Unterrichtsprinzipien im Informatikunterricht.
  - Hessisches Kultusministerium, *Kerncurriculum Informatik* für den Wahlunterricht der Sekundarstufe I im gymnasialen Bildungsgang.
], fill: gray)

