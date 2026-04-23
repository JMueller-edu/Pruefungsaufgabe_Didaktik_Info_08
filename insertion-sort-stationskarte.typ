/*--------------------------------------------*
* Copyright (C) 2026 Jan Müller              *
* SPDX-License-Identifier: GPL-3.0-or-later  *
*--------------------------------------------*/

/*--------------------------------------------------------------------*
* Importiert nur die Pakete, die diese Stationskarte konkret benutzt. *
* `deckz` zeichnet Karten, `ccicons` die Lizenz und `qrcode` den      *
* schnellen Link zum GitHub-Repository im Kopfbereich.                *
*--------------------------------------------------------------------*/
#import "@preview/deckz:0.3.1"
#import "@preview/ccicons:1.0.1": *
#import "@preview/zebra:0.1.0": qrcode

/*---------------------------------------------------------------*
* Hinterlegt die Metadaten, die in Kopf- und Fußzeile auftauchen. *
* So bleiben Titel, Autor:innenangabe und Beschreibung zentral    *
* gepflegt und müssen nicht mehrfach im Dokument wiederholt werden. *
*---------------------------------------------------------------*/
#set document(
  title: [Stationskarte Insertion Sort:],
  author: "A. Firle - I. Rhöse - J. Müller -",
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
    columns: (2fr, 2fr, 1fr),
    gutter: 10pt,
    [
      #text(size: 16.5pt, weight: "bold")[Stationskarte]
      #linebreak()
      #text(size: 14pt, weight: "bold")[Sortieren nach Insertion Sort entdecken]
      #v(3pt)
      #text(size: 8.8pt)[Informatik · Klasse 10]
      \
      #text(size: 7pt)[_Dieses Material wurde im Textsatzsystem Typst mit Unterstützung von ChatGPT erstellt_]
    ],
    [
      #align(center)[
      #deckz.hand("7H", "3H", "9H", "2H", "6H", format: "mini", angle: 16deg, width: 3.5cm)
      #text(size: 8.8pt)[#repo-url]
    ]],
    [
      #align(right)[
        #qrcode(repo-url, height: 80pt, background-fill: white)
      ]],
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

/*---------------------------------------------------------------*
* Zentraler Abstand für Karten in den Schrittansichten.          *
* Eine eigene Konstante macht kleine Layoutkorrekturen leichter, *
* ohne dass mehrere `stack`-Aufrufe angepasst werden müssen.     *
*---------------------------------------------------------------*/
#let card-step-spacing = 4pt

/*-----------------------------------------------------------------*
* Rendert genau eine Karte innerhalb einer Schrittansicht.         *
* Die aktuell betrachtete Karte wird leicht angehoben und mit      *
* etwas visuellem Rauschen markiert, damit Lernende sofort sehen,  *
* welche Karte gerade eingefügt wird.                              *
*-----------------------------------------------------------------*/
#let sequence-card(card, current: false) = {
  if current {
    move(
      dy: -2pt,
      deckz.render(card, format: "small", noise: 2),
    )
  } else {
    deckz.render(card, format: "small")
  }
}

/*-------------------------------------------------------------------*
* Baut eine komplette Kartenfolge für einen Zwischenschritt auf.     *
* `sorted` steht links für den bereits sortierten Teil, `current`    *
* optional für die neue Karte und `rest` für den verbleibenden Rest. *
* Mit `highlight-current` wird nur die aktuelle Karte hervorgehoben. *
*--------------------------------------------------------------------*/
#let sequence(sorted, current: none, rest: (), highlight-current: false) = {
  let current-slot = if current == none {
    ()
  } else {
    (sequence-card(current, current: highlight-current),)
  }
  let slots = sorted.map(card => sequence-card(card)) + current-slot + rest.map(card => sequence-card(card))

  if slots.len() == 0 {
    emph[keine Karten]
  } else {
    align(center)[
      #stack(
        dir: ltr,
        spacing: card-step-spacing,
        ..slots,
      )
    ]
  }
}

/*------------------------------------------------------------------*
* Zeichnet eine kompakte Zustandsbox für Vorher- oder Nachherbild.  *
* Titel, Kartenfolge und optionale Zusatznotiz werden hier          *
* gekapselt, damit beide Zustände mit derselben Logik gesetzt sind. *
*-------------------------------------------------------------------*/
#let state-box(title, sorted, current: none, rest: (), highlight-current: false, note: none) = block(
  inset: 6pt,
  radius: 7pt,
  stroke: 0.75pt + rgb("#D0D7DE"),
  fill: white,
  width: 100%,
)[
  #text(size: 8.5pt, weight: "bold", fill: blue)[#title]
  #sequence(sorted, current: current, rest: rest, highlight-current: highlight-current)
  #if note != none [
    #align(left)[
      #text(size: 8.5pt, weight: "bold", fill: blue)[#note]
    ]
  ]
]

/*----------------------------------------------------------------*
* Baut einen kompletten Beispielschritt für das Lehrbeispiel.     *
* Ein Schritt enthält den Zustand vor dem Einfügen, die sprachliche *
* Erklärung und den Zustand nach dem Einfügen in genau einer Box. *
*----------------------------------------------------------------*/
#let insertion-panel(number, sorted-before, current, rest-before, target-note, text-line, sorted-after, next-current: none, next-rest: ()) = {
  infobox(
    [Schritt #number],
    [
      #state-box(
        [Die neue Karte ist leicht hervorgehoben],
        sorted-before,
        current: current,
        rest: rest-before,
        highlight-current: true,
        note: target-note,
      )
      #v(4pt)
      #text(size: 9pt, weight: "bold", fill: blue)[Neue Karte: #deckz.inline(current)]
      #v(2pt)
      #text(size: 12pt)[#text-line]
      #v(4pt)
      #state-box(
        [Reihenfolge danach],
        sorted-after,
        current: next-current,
        rest: next-rest,
      )
    ],
    fill: gray,
  )
}

/*---------------------------------------------------------------*
* Startet die erste Seite mit Kopfbereich und organisatorischem  *
* Überblick. Damit ist sofort klar, welches Material gebraucht   *
* wird und welches Lernziel die Station verfolgt.                *
*---------------------------------------------------------------*/
#headline-box()

#grid(
  columns: (1fr, 1fr, 2fr),
  gutter: 8pt,
  chip([Du brauchst], [Spielkarten, Stift]),
  chip([Zeit], [ca. 20 Minuten]),
  chip([Ziel], [Du kannst Insertion Sort erklären und selbst anwenden.]),
)

/*----------------------------------------------------------------*
* Führt knapp in die Grundidee von Insertion Sort ein.            *
* Text und Bild stehen nebeneinander, damit die verbale Erklärung *
* sofort an eine konkrete Darstellung gekoppelt wird.             *
*----------------------------------------------------------------*/
#infobox([Worum geht es?], [
  #grid(
    columns: (1fr, 1fr),
    gutter: 12pt,
    [
      Bei *Insertion Sort* ist der linke Teil schon geordnet.

      Du nimmst immer die *nächste Karte rechts*.

      Diese Karte schiebst du an die *passende Stelle* im sortierten Teil.

      *Merksatz:*

      Insertion Sort = *nächste Karte nehmen und passend einfügen.*
    ],
    [
     #image("assets\insertion-sort.png")
    ],
  )
])

/*----------------------------------------------------------------*
* Stellt Arbeitsroutine und typische Fehlvorstellungen direkt      *
* gegenüber. So sehen Lernende auf einen Blick, was sie tun sollen *
* und was Insertion Sort gerade nicht bedeutet.                    *
*----------------------------------------------------------------*/
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,

  [
    #infobox([So arbeitest du in jeder Runde], [
      1. Links liegt schon ein *sortierter Teil*.
      2. Nimm die *nächste Karte rechts*.
      3. Vergleiche sie mit den Karten links.
      4. Schiebe sie an die *richtige Stelle*.
    ])
  ],

  [
    #infobox(
      [Wichtig],
      [
        - Du suchst *nicht* die kleinste Karte im Rest.
        - Du nimmst immer die *nächste Karte*.
        - Die *erste Karte* gilt schon als sortiert.
        - Manchmal bleibt die neue Karte einfach *ganz rechts*.
      ],
      fill: red,
    )
  ],
)

/*---------------------------------------------------------------*
* Seite 2 beginnt mit einem vollständig vorbereiteten Beispiel.  *
* Die erste Karte gilt schon als sortiert und dient als Startpunkt *
* für die folgenden Einfügeschritte.                             *
*---------------------------------------------------------------*/
#pagebreak()

#infobox(
  [Beispiel],
  [
    Wir starten mit diesen Karten:
    #card-row("7H", "3H", "9H", "2H", "6H")
    Hier zählt nur die *Zahl* auf der Karte. Die Farbe ist egal.

    Die *erste Karte* gilt schon als sortiert.
  ],
  fill: light-blue,
)

/*--------------------------------------------------------------*
* Zeigt die ersten beiden Einfügeschritte des Beispiels.        *
* Hier wird besonders deutlich, dass die nächste Karte entweder *
* eingefügt oder einfach rechts stehen bleiben kann.            *
*--------------------------------------------------------------*/
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  row-gutter: 10pt,

  insertion-panel(
    1,
    ("7H",),
    "3H",
    ("9H", "2H", "6H"),
    [↓ vor #deckz.inline("7H")],
    [Die neue Karte ist die *3*. \ Sie ist kleiner als die *7* und kommt vor die *7*.],
    ("3H", "7H"),
    next-current: "9H",
    next-rest: ("2H", "6H"),
  ),

  insertion-panel(
    2,
    ("3H", "7H"),
    "9H",
    ("2H", "6H"),
    [↓ hinter #deckz.inline("7H")],
    [Die neue Karte ist die *9*. \ Sie ist größer als die *7* und bleibt ganz rechts.],
    ("3H", "7H", "9H"),
    next-current: "2H",
    next-rest: ("6H",),
  ),
)

/*--------------------------------------------------------------*
* Auf der nächsten Seite wird das Beispiel vollständig beendet. *
* Die letzten beiden Schritte zeigen das Einfügen ganz vorne    *
* und das Einfügen zwischen zwei bereits sortierte Karten.      *
*--------------------------------------------------------------*/
#pagebreak()

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  row-gutter: 10pt,

  insertion-panel(
    3,
    ("3H", "7H", "9H"),
    "2H",
    ("6H",),
    [↓ vor #deckz.inline("3H")],
    [Die neue Karte ist die *2*. \ Sie ist kleiner als *9*, *7* und *3* und kommt ganz nach vorne.],
    ("2H", "3H", "7H", "9H"),
    next-current: "6H",
    next-rest: (),
  ),

  insertion-panel(
    4,
    ("2H", "3H", "7H", "9H"),
    "6H",
    (),
    [↓ zwischen #deckz.inline("3H") und #deckz.inline("7H")],
    [Die neue Karte ist die *6*. \ Sie passt zwischen *3* und *7*.],
    ("2H", "3H", "6H", "7H", "9H"),
    next-current: none,
    next-rest: (),
  ),
)

/*---------------------------------------------------------------*
* Fasst das Ergebnis des Beispiels noch einmal sprachlich zusammen. *
* Die Schlussbox sichert den Kern von Insertion Sort vor dem        *
* Übergang in die eigenständige Arbeitsphase.                       *
*---------------------------------------------------------------*/
#infobox(
  [Ergebnis des Beispiels],
  [
    Am Ende liegen die Karten so:
    #card-row("2H", "3H", "6H", "7H", "9H")
    Nach jedem Schritt wächst links der *sortierte Teil*.
    Die neue Karte wird an der *passenden Stelle eingefügt*.
  ],
  fill: green,
)

/*--------------------------------------------------------------*
* Seite 4 öffnet die eigenständige Arbeitsphase.                *
* Ab hier übertragen die Lernenden das beobachtete Verfahren    *
* auf ein neues Kartenset.                                      *
*--------------------------------------------------------------*/
#pagebreak()

#infobox(
  [Jetzt bist du dran],
  [
    Lege diese Karten vor dich:
    #card-row("8S", "4S", "2S", "7S", "3S", "6S")
  ],
  fill: light-blue,
)

/*----------------------------------------------------------------*
* Kombiniert konkreten Arbeitsauftrag und sprachliche Denkhilfe. *
* So wird nicht nur das Tun angeleitet, sondern auch die passende *
* innere Sprechweise für den Algorithmus aufgebaut.               *
*----------------------------------------------------------------*/
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,

  [
    #infobox([Dein Arbeitsauftrag], [
      1. Sprich jeden Schritt laut mit
      2. Sortiere die Karten mit *Insertion Sort*.
      3. Fülle die Tabelle aus.
      4. Vergleiche dein Ergebnis mit der Selbstkontrolle.
    ])
  ],

  [
    #infobox(
      [Denkhilfe],
      [
        Frage dich in jeder Runde:
        - *Welche Karten links sind schon sortiert?*
        - *Welche Karte nehme ich jetzt?*
        - *Wo passt sie hinein?*
      ],
      fill: yellow,
    )
  ],
)

/*---------------------------------------------------------------*
* Die Tabelle macht die einzelnen Sortierschritte sichtbar.      *
* Direkt daneben steht eine Selbstkontrolle, damit Lernende ihr  *
* Endergebnis eigenständig überprüfen können.                    *
*---------------------------------------------------------------*/
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  [
    #set text(size: 14pt)
    #table(
      columns: (auto, auto, auto, 1fr),
      inset: 5pt,
      stroke: 0.7pt + black,
      align: left + horizon,
      [*Schritt*], [*neue Karte*], [*wo eingefügt?*], [*Reihenfolge danach*],
      [1], [], [], [],
      [2], [], [], [],
      [3], [], [], [],
      [4], [], [], [],
      [5], [], [], [],
      [6], [], [], [],
    )
  ],
  [
    #infobox(
      [Selbstkontrolle],
      [
        Am Ende liegen die Karten so:
        #v(3pt)
        #card-row("2S", "3S", "4S", "6S", "7S", "8S")
      ],
      fill: green,
    )
  ],
)

/*----------------------------------------------------------------*
* Die Abschlussfrage zwingt zur sprachlichen Abgrenzung zwischen *
* Selection Sort und Insertion Sort. Genau diese Verbalisierung  *
* stabilisiert meist das eigentliche Algorithmusverständnis.     *
*----------------------------------------------------------------*/
#infobox(
  [Zusatzfrage],
  [
    Erkläre in *einem Satz*:
    *Was ist der Unterschied zwischen „die kleinste Karte im Rest suchen“ und „die nächste Karte passend einfügen“?*
    #v(10pt)
    #line(length: 100%)
  ],
  fill: light-blue,
)
