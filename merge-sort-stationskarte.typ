/*--------------------------------------------*
 * Copyright (C) 2026 Jan Müller              *
 * SPDX-License-Identifier: GPL-3.0-or-later  *
 *--------------------------------------------*/

/*--------------------------------------------------------------------*
 * Importiert nur die Pakete, die diese Stationskarte konkret benutzt. *
 * `deckz` zeichnet Karten, `tdtr` erzeugt die Baumdiagramme,          *
 * `ccicons` die Lizenz und `qrcode` den Link zum Repository.          *
 *--------------------------------------------------------------------*/
#import "@preview/deckz:0.3.1"
#import "@preview/tdtr:0.5.4": *
#import "@preview/ccicons:1.0.1": *
#import "@preview/zebra:0.1.0": qrcode

/*---------------------------------------------------------------*
 * Hinterlegt die Metadaten, die in Kopf- und Fußzeile auftauchen. *
 * So bleiben Titel, Autor:innenangabe und Beschreibung zentral    *
 * gepflegt und müssen nicht mehrfach im Dokument wiederholt werden. *
 *---------------------------------------------------------------*/
#set document(
  title: [Stationskarte Merge Sort:],
  author: "Herr A. Firle - Herr I. Röhse - Herr J. Müller -",
  description: [Weiterbildungskurs Informatik 08 - Baustein 05 Didaktik - #cc-by-nc-sa],
)

/*----------------------------------------------------------------*
 * Definiert das Grundlayout der quer gesetzten A4-Seite.          *
 * Kopf- und Fußbereich werden hier einmal global festgelegt,      *
 * damit alle Seiten der Stationskarte automatisch gleich aussehen. *
 *----------------------------------------------------------------*/
#set page(
  paper: "a4",
  flipped: true,
  margin: (top: 2.5cm, bottom: 2cm, left: 1.25cm, right: 1.25cm),
  header: context [
    #context document.title
    Name:#box(width: 3fr, repeat[.]) Datum:#box(width: 1fr, repeat[.])
    #line(length: 100%)
  ],
  footer: context [
    #line(length: 100%)
    #context document.author.first()
    #context document.description
    #h(1fr)
    Seite #counter(page).display()
  ],
)

/*--------------------------------------------------------------*
 * Vereinheitlicht Sprache, Schriftgröße und Zeilenabstand.      *
 * Die Werte sind bewusst kompakt gewählt, damit die Karte       *
 * didaktisch dicht bleibt und trotzdem gut lesbar gesetzt wird. *
 *--------------------------------------------------------------*/
#set text(lang: "de", size: 12pt)
#set par(justify: false, leading: 0.82em)

/*---------------------------------------------------------------*
 * Bündelt alle wiederkehrenden Farben an einer zentralen Stelle. *
 * Dadurch lassen sich spätere Layoutanpassungen schnell machen,  *
 * ohne jede Box oder Hervorhebung einzeln anfassen zu müssen.    *
 *---------------------------------------------------------------*/
#let blue = rgb("#2E5E8A")
#let light-blue = rgb("#EEF6FC")
#let green = rgb("#EAF7EC")
#let yellow = rgb("#FFF6D8")
#let red = rgb("#FFF0EF")
#let gray = rgb("#F6F7F8")
#let white = rgb("#FFFFFF")
#let repo-url = "https://github.com/JMueller-edu/Pruefungsaufgabe_Didaktik_Info_08.git"

/*-------------------------------------------------------------*
 * Standardbaustein für inhaltliche Kästen wie Erklärung,        *
 * Arbeitsauftrag oder Hinweis. Titelstil, Rand und Hintergrund  *
 * sind hier gebündelt, damit alle Infoboxen konsistent bleiben. *
 *-------------------------------------------------------------*/
#let infobox(title, body, fill: light-blue) = block(
  inset: 9pt,
  radius: 8pt,
  stroke: 0.85pt + rgb("#9CBBD1"),
  fill: fill,
  width: 100%,
)[
  #text(weight: "bold", fill: blue)[#title]
  #v(1pt)
  #body
]

/*---------------------------------------------------------------*
 * Kleine Infokachel für organisatorische Angaben.                *
 * Diese kompakte Variante wird nur im Kopfbereich genutzt, damit *
 * Material, Zeit und Ziel schnell erfasst werden können.         *
 *---------------------------------------------------------------*/
#let chip(title, body) = block(
  inset: 8pt,
  radius: 8pt,
  stroke: 0.7pt + rgb("#C7D2DB"),
  fill: gray,
  width: 100%,
)[
  #text(size: 8.5pt, weight: "bold", fill: blue)[#title]
  #v(2pt)
  #body
]

/*-----------------------------------------------------------------*
 * Baut den sichtbaren Kopf der Stationskarte.                      *
 * Neben Titel und Klassenbezug enthält er eine Kartenhand sowie    *
 * einen QR-Code, damit das Material analog und digital verknüpft   *
 * bleibt.                                                          *
 *-----------------------------------------------------------------*/
#let headline-box() = block(
  inset: 12pt,
  radius: 10pt,
  fill: blue,
  width: 100%,
)[
  #set text(fill: white)
  #grid(
    columns: (2.5fr, 2fr, 1fr),
    gutter: 10pt,
    [
      #text(size: 16.5pt, weight: "bold")[Stationskarte]
      #linebreak()
      #text(size: 14pt, weight: "bold")[Rekrusives Sortieren nach Merge Sort entdecken]
      #v(3pt)
      #text(size: 8.8pt)[Informatik · Klasse 10]
      \
      #text(size: 7pt)[_Dieses Material wurde im Textsatzsystem Typst mit Unterstützung von ChatGPT erstellt._]
    ],
    [
      #align(center)[
        #deckz.hand("7H", "3H", "5H", "2H", format: "mini", angle: 16deg, width: 3.5cm)
        #text(size: 8.8pt)[#repo-url]
      ]
    ],
    [
      #align(right)[
        #qrcode(repo-url, height: 65pt, background-fill: white)
      ]
    ],
  )
]

/*--------------------------------------------------------------*
 * Rendert eine einfache Kartenreihe mit einheitlichem Abstand. *
 * Diese Funktion wird überall dort benutzt, wo ein kompletter   *
 * Kartenstand ohne zusätzliche Hervorhebung gezeigt werden soll. *
 *--------------------------------------------------------------*/
#let card-row(..cards) = align(center)[
  #deckz.line(..cards, format: "small", spacing: 8pt)
]

/*-------------------------------------------------------------------*
 * Rendert eine Kartenfolge speziell für Baumknoten im Mini-Format.   *
 * So können in einem Knoten direkt ganze Teilstapel dargestellt      *
 * werden, statt nur mit Zahlen oder Text zu arbeiten.                *
 *-------------------------------------------------------------------*/
#let tree-cards(..cards) = align(center)[
  #deckz.line(..cards, format: "small", spacing: 1pt)
]

/*------------------------------------------------------------------*
 * Baut rekursiv eine Folge leerer Kartenfelder auf. Diese wird für  *
 * das ausfüllbare Baumdiagramm genutzt, damit die Struktur sichtbar *
 * bleibt, ohne die Lösungen der Teilstapel schon vorzugeben.       *
 *------------------------------------------------------------------*/
#let empty-card-fields(count) = {
  if count <= 0 {
    ()
  } else {
    (
      empty-card-fields(count - 1)
        + (
          block(
            width: 6.8mm,
            height: 9.5mm,
            inset: 0pt,
            radius: 2.5pt,
            stroke: 0.5pt + rgb("#C7D2DB"),
            fill: white,
          )[],
        )
    )
  }
}

/*----------------------------------------------------------------*
 * Rendert eine Gruppe aus leeren Kartenfeldern als Platzhalter-   *
 * knoten. Die Anzahl der Felder zeigt, wie viele Karten in diesem *
 * Teilstapel später eingetragen werden sollen.                    *
 *----------------------------------------------------------------*/
#let tree-fields(count) = align(center)[
  #stack(
    dir: ltr,
    spacing: 1pt,
    ..empty-card-fields(count),
  )
]

/*-------------------------------------------------------------------*
 * Definiert einen einheitlichen Baumstil für Merge Sort.            *
 * `tdtr` zeichnet die Struktur, die Knotenrahmen bleiben unsichtbar *
 * und die Verbindungen laufen rechtwinklig für eine klare Leselinie. *
 *-------------------------------------------------------------------*/
#let merge-tree = tidy-tree-graph.with(
  draw-node: ((label,)) => (label: label, stroke: none, fill: none),
  draw-edge: (
    tidy-tree-draws.horizontal-vertical-draw-edge,
    (stroke: 0.75pt + blue),
  ),
  spacing: (5pt, 17pt),
  node-inset: 0pt,
)

/*----------------------------------------------------------------*
 * Baut die Titelleiste für einen Merge-Schritt im Beispiel oder   *
 * in einer Tabelle. Die Darstellung bleibt textlich schlicht,     *
 * damit der Fokus auf dem Vergleich der vordersten Karten liegt.  *
 *----------------------------------------------------------------*/
#let merge-label(title) = text(size: 9pt, weight: "bold", fill: blue)[#title]

/*---------------------------------------------------------------*
 * Startet die erste Seite mit Kopfbereich und organisatorischem  *
 * Überblick. Damit ist sofort klar, welches Material gebraucht   *
 * wird und welches Lernziel die Station verfolgt.                *
 *---------------------------------------------------------------*/
#headline-box()

#grid(
  columns: (1fr, 1fr, 3fr),
  gutter: 8pt,
  chip([Du brauchst], [Spielkarten, Stift]),
  chip([Zeit], [ca. 25 Minuten]),
  chip([Ziel], [Du kannst Merge Sort erklären, anwenden und das Prinzip der Rekursion beschreiben.]),
)

/*----------------------------------------------------------------*
 * Führt in die Grundidee von Merge Sort ein: erst teilen, dann    *
 * sortiert zusammenführen. Die kurze Kartenreihe macht sichtbar,  *
 * dass weiterhin mit denselben Zahlen gearbeitet wird.            *
 *----------------------------------------------------------------*/
#infobox([Worum geht es?], [
  #grid(
    columns: (2fr, 1fr),
    gutter: 12pt,
    [
      Bei *Merge Sort* wird das Problem immer wieder *halbiert*, bis es trivial ist - und dann *sortiert zusammengesetzt*.
      Eine einzelne Karte ist automatisch sortiert. Zwei sortierte Hälften lassen sich einfach zusammenführen.

      *Merksatz:* Merge Sort = *teilen bis einzeln, dann sortiert zusammenführen.*
    ],
    [#figure(
      image("assets/merge-sort.png", width: 50%),
    )],
  )
])

/*----------------------------------------------------------------*
 * Diese Doppelseite erklärt den rekursiven Gedanken von Merge     *
 * Sort. Basisfall und rekursiver Fall werden sprachlich getrennt  *
 * und durch Vor- und Nachteile ergänzt.                           *
 *----------------------------------------------------------------*/
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #infobox([Rekursion - was steckt dahinter?], [
      Merge Sort arbeitet *rekursiv*: Das Verfahren wendet sich selbst auf kleinere Teilprobleme an.
      Das funktioniert, weil es zwei klar getrennte Fälle gibt:
      - *Basisfall:* Eine Karte alleine ist bereits sortiert. Hier hört die Aufteilung auf.
      - *Rekursiver Fall:* Mehr als eine Karte -> halbieren und das Verfahren auf jede Hälfte erneut anwenden.

      /*  #text(weight: "bold", fill: blue)[Analogie]
            Stell dir eine Matrjoschka-Puppe vor. Du öffnest sie immer wieder - bis du zur kleinsten Puppe kommst. Dann setzt du alles in umgekehrter Reihenfolge zusammen.

      */    ])
  ],
  [
    #infobox(
      [So führst du zwei Stapel zusammen (Merge-Schritt)],
      [
        Das Zusammenführen ist das Herzstück von Merge Sort:
        1. Lege zwei sortierte Stapel nebeneinander.
        2. Vergleiche jeweils die *vorderste Karte* beider Stapel.
        3. Lege die *kleinere Karte* auf den Ergebnisstapel.
        4. Wiederhole, bis beide Stapel leer sind.

        #v(4pt)
        #text(weight: "bold", fill: blue)[Wichtig]
        Du suchst *nicht* die kleinste Karte im gesamten Rest - du schaust immer nur auf die vorderste Karte jedes Stapels.
      ],
      fill: yellow,
    )
  ]
  /*[
    #infobox([Vorteile der Rekursion], [
      - Die Beschreibung des Verfahrens ist kurz und elegant.
      - Das Denken in Teilproblemen ist natürlich und übertragbar.
    ], fill: green)

    #infobox([Nachteile der Rekursion], [
      - Jede Aufteilungsebene benötigt zusätzlichen Speicher: Solange eine Ebene noch nicht fertig zusammengeführt ist, müssen alle Zwischenstapel gleichzeitig im Gedächtnis behalten werden.
      - Bei 8 Karten liegen auf dem Höhepunkt bis zu 4 Ebenen gleichzeitig "offen" - die Hälften, Viertel und Achtel existieren alle gleichzeitig, bevor sie zusammengesetzt werden.
      - Es kann schwer sein, den Überblick zu behalten, auf welcher Ebene man sich gerade befindet.
    ], fill: red)
  ],*/
)

/*----------------------------------------------------------------*
 * Erklärt den eigentlichen Merge-Schritt als Herzstück des        *
 * Verfahrens. Die Liste ist bewusst handlungsorientiert formuliert *
 * und endet mit einer klaren Abgrenzung zu anderen Sortierideen.  *
 *----------------------------------------------------------------*/


/*--------------------------------------------------------------*
 * Seite 2 zeigt das vollständige Beispiel mit vier Karten.      *
 * Zuerst wird das Teilen als Baumdiagramm dargestellt, danach   *
 * das sortierte Zusammenführen in mehreren Merge-Schritten.     *
 *--------------------------------------------------------------*/
#pagebreak()

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [#infobox(
    [Vorteile der Rekursion],
    [
      - Die Beschreibung des Verfahrens ist kurz und elegant.
      - Das Denken in Teilproblemen ist natürlich und übertragbar.
    ],
    fill: green,
  )],
  [#infobox(
    [Nachteile der Rekursion],
    [
      - Jede Ebene braucht zusätzlichen Speicher.
      - Mehrere Ebenen sind gleichzeitig offen.
      - Man verliert leicht den Überblick.
    ],
    fill: red,
  )],
)

#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #infobox([Beispiel], [
      Wir starten mit vier Karten:
      #card-row("7H", "3H", "5H", "2H")

      Hier zählt nur die *Zahl* auf der Karte. Die Farbe ist egal.

      #v(4pt)
      #text(weight: "bold", fill: blue)[Teilen:]
      #align(center)[
        #merge-tree[
          - #tree-cards("7H", "3H", "5H", "2H")
            - #tree-cards("7H", "3H")
              - #tree-cards("7H")
              - #tree-cards("3H")
            - #tree-cards("5H", "2H")
              - #tree-cards("5H")
              - #tree-cards("2H")
        ]
      ]
    ])
  ],
  [
    #infobox(
      [Zusammenführen (Merge)],
      [
        #set text(size: 14pt)
        #table(
          columns: (auto, 1fr, 1fr, 1fr),
          inset: 5pt,
          stroke: 0.7pt + black,
          align: left + horizon,
          [*Schritt*], [*Linker Stapel*], [*Rechter Stapel*], [*Ergebnis*],
          [Merge 1], [7], [3], [-> 3, 7],
          [Merge 2], [5], [1], [-> 1, 5],
          [Merge 3], [3, 7], [1, 5], [-> 1, 3, 5, 7],
        )
      ],
      fill: gray,
    )

    #infobox(
      [Merge 3 im Detail],
      [
        #merge-label([Vergleiche 3 und 2])
        2 kommt zuerst.

        #v(3pt)
        #merge-label([Vergleiche 3 und 5])
        3 kommt danach.

        #v(3pt)
        #merge-label([Vergleiche 7 und 5])
        5 kommt als Nächstes.

        #v(3pt)
        #merge-label([Letzte Karte])
        Zuletzt bleibt 7 übrig.
      ],
      fill: yellow,
    )
  ],
)
#infobox(
  [Merke],
  [
    Beim Teilen arbeitest du *von oben nach unten*.
    Beim Zusammenführen arbeitest du *von unten nach oben*.
  ],
  fill: light-blue,
)


/*--------------------------------------------------------------*
 * Seite 3 leitet in die eigenständige Arbeitsphase über.        *
 * Lernende erhalten sowohl den Arbeitsauftrag als auch ein       *
 * vorbereitetes Baumdiagramm, das sie mit eigenen Stapeln füllen. *
 *--------------------------------------------------------------*/
#pagebreak()

#infobox(
  [Jetzt bist du dran],
  [
    Lege diese 8 Karten vor dich:
    #card-row("9S", "5S", "3S", "8S", "4S", "7S", "2S", "6S")
  ],
  fill: light-blue,
)

#grid(
  columns: (1.5fr, 1fr),
  gutter: 10pt,
  [
    #infobox([Dein Arbeitsauftrag], [
      1. Zeichne das Baumdiagramm: Teile die 8 Karten schrittweise in Hälften auf, bis jede Gruppe nur noch 1 Karte enthält.
      2. Führe die Stapel Schritt für Schritt zusammen und fülle die Tabelle aus.
      3. Vergleiche dein Ergebnis mit der Selbstkontrolle.
    ])
  ],
  [
    #infobox(
      [Denkhilfe],
      [
        - Auf welcher Ebene des Baums befindest du dich gerade?
        - Welche zwei Stapel führst du zusammen?
        - Schaust du wirklich nur auf die vorderste Karte?
      ],
      fill: yellow,
    )
  ],
)

#infobox(
  [Baumdiagramm (zum Ausfüllen)],
  [
    Trage beim Teilen nacheinander die passenden Stapel ein.
    Die leeren Kartenfelder zeigen nur, wie viele Karten an jeder Stelle liegen.
    #align(center)[
      #merge-tree[
        - #tree-cards("9S", "5S", "3S", "8S", "4S", "7S", "2S", "6S")
          - #tree-fields(4)
            - #tree-fields(2)
              - #tree-fields(1)
              - #tree-fields(1)
            - #tree-fields(2)
              - #tree-fields(1)
              - #tree-fields(1)
          - #tree-fields(4)
            - #tree-fields(2)
              - #tree-fields(1)
              - #tree-fields(1)
            - #tree-fields(2)
              - #tree-fields(1)
              - #tree-fields(1)
      ]
    ]
  ],
  fill: gray,
)

/*--------------------------------------------------------------*
 * Die letzte Seite sammelt die schriftliche Sicherung.          *
 * Tabelle, Selbstkontrolle und Zusatzfragen sorgen dafür, dass  *
 * sowohl Vorgehen als auch Begriffe noch einmal aktiviert werden. *
 *--------------------------------------------------------------*/

#infobox(
  [Tabelle (zum Ausfüllen)],
  [
    #set text(size: 14pt)
    #table(
      columns: (auto, 1fr, 1fr, 1fr),
      inset: 10pt,
      stroke: 0.7pt + black,
      align: left + horizon,
      [*Schritt*], [*Linker Stapel*], [*Rechter Stapel*], [*Zusammengeführt*],
      [1], [], [], [],
      [2], [], [], [],
      [3], [], [], [],
      [4], [], [], [],
      [5], [], [], [],
      [6], [], [], [],
      [7], [], [], [],
    )
  ],
  fill: gray,
)

#grid(
  columns: (1.5fr, 1fr),
  gutter: 10pt,
  [
    #infobox(
      [Zusatzfragen Vergleich],
      [
        Nenne je einen Vorteil von Merge Sort gegenüber Selection Sort - und einen Nachteil.
        #v(10pt)
        #line(length: 100%)
      ],
      fill: yellow,
    )
  ],
  [
    #infobox(
      [Selbstkontrolle],
      [
        #card-row("2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S")
      ],
      fill: green,
    )
  ],
)

#infobox(
  [Zusatzfrage Rekursion],
  [
    Erkläre in einem Satz, was ein "Basisfall" ist und warum er wichtig ist.
    #v(10pt)
    #line(length: 100%)
  ],
  fill: yellow,
)
