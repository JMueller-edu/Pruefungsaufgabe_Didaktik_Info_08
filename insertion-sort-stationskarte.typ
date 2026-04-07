/*--------------------------------------------*
 * Copyright (C) 2026 Jan Müller              *
 * SPDX-License-Identifier: GPL-3.0-or-later  *
 *--------------------------------------------*/


// Kartenpaket für die Darstellung von Spielkarten in den Beispielen.
#import "@preview/deckz:0.3.1"
#import "@preview/ccicons:1.0.1": *
#import "@preview/zebra:0.1.0": datamatrix, qrcode

// Dokumentmetadaten für Kopf- und Fußbereich.
#set document(
  title: [Stationskarte Insertion Sort:],
  author: "Herr A. Firle - Herr I. Röhse - Herr J. Müller -",
  description: [Weiterbildungskurs Informatik 08 - Baustein 05 Didaktik - #cc-by-nc-sa],
)

// Grundlayout der quer gesetzten A4-Seite.
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

// Einheitliche Grundtypografie für das Material.
#set text(lang: "de", size: 12pt)
#set par(justify: false, leading: 0.82em)

// Farbpalette für wiederkehrende Boxen und Hervorhebungen.
#let blue = rgb("#2E5E8A")
#let light-blue = rgb("#EEF6FC")
#let green = rgb("#EAF7EC")
#let yellow = rgb("#FFF6D8")
#let red = rgb("#FFF0EF")
#let gray = rgb("#F6F7F8")

// Standardbox für Erklärungen, Aufgaben und Hinweise.
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

// Kleine Infokachel für Material, Zeit und Ziel.
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

// Kopfbereich der Stationskarte mit Titel und dekorativer Kartenhand.
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
      #text(size: 8.8pt)[https://github.com/JMueller-edu/Pruefungsaufgabe_Didaktik_Info_08.git]
    ]],
    [
      #align(right)[
        #qrcode("https://github.com/JMueller-edu/Pruefungsaufgabe_Didaktik_Info_08.git",height: 80pt, background-fill: white)
      ]],
  )
]

// Hilfsfunktion für eine gleichmäßig gesetzte Kartenreihe.
#let card-row(..cards) = align(center)[
  #deckz.line(..cards, format: "small", spacing: 8pt)
]

// Abstand zwischen Karten in den Schrittansichten.
#let card-step-spacing = 4pt

// Einzelne Karte in der Schrittansicht.
// Die aktuelle Karte wird leicht verschoben und mit etwas "noise"
// optisch hervorgehoben, damit sie direkt ins Auge fällt.
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

// Baut eine einfache Kartenfolge ohne besondere Hervorhebung,
// z. B. für den Zustand am Ende eines Schritts.
#let plain-sequence(sorted, current: none, rest: ()) = {
  let current_part = if current == none { () } else { (current,) }
  let all-cards = (
    sorted
    + current_part
    + rest
  )

  if all-cards.len() == 0 {
    emph[keine Karten]
  } else {
    align(center)[
      #stack(
        dir: ltr,
        spacing: card-step-spacing,
        ..all-cards.map(card => sequence-card(card)),
      )
    ]
  }
}

// Baut die Kartenfolge für den Zustand vor dem Einfügen:
// sortierter Teil links, aktuelle Karte, restliche Karten rechts.
#let segmented-sequence(sorted, current: none, rest: ()) = {
  let sorted-slots = sorted.map(card => sequence-card(card))
  let current-slot = if current == none {
    ()
  } else {
    (sequence-card(current, current: true),)
  }
  let rest-slots = rest.map(card => sequence-card(card))
  let all-slots = sorted-slots + current-slot + rest-slots

  if all-slots.len() == 0 {
    emph[keine Karten]
  } else {
    align(center)[
      #stack(
        dir: ltr,
        spacing: card-step-spacing,
        ..all-slots,
      )
    ]
  }
}

// Kompakte Zustandsanzeige vor dem eigentlichen Einfügeschritt.
#let state-before(sorted, current: none, rest: (), target-note: none) = block(
  inset: 6pt,
  radius: 7pt,
  stroke: 0.75pt + rgb("#D0D7DE"),
  fill: white,
  width: 100%,
)[
  #text(size: 8.5pt, weight: "bold", fill: blue)[Die neue Karte ist leicht hervorgehoben]
  #segmented-sequence(sorted, current: current, rest: rest)
  #if target-note != none [
    #align(left)[
      #text(size: 8.5pt, weight: "bold", fill: blue)[#target-note]
    ]
  ]
]

// Kompakte Zustandsanzeige nach dem Schritt.
#let state-after(sorted, current: none, rest: ()) = block(
  inset: 6pt,
  radius: 7pt,
  stroke: 0.75pt + rgb("#D0D7DE"),
  fill: white,
  width: 100%,
)[
  #text(size: 8.5pt, weight: "bold", fill: blue)[Reihenfolge danach]
  #plain-sequence(sorted, current: current, rest: rest)
]

// Vollständige Box für einen Beispielschritt:
// Zustand vorher, Erklärung, Zielposition und Zustand nachher.
#let insertion-panel(number, sorted-before, current, rest-before, found, target-note, text-line, sorted-after, next-current: none, next-rest: ()) = {
  infobox(
    [Schritt #number],
    [
      #state-before(sorted-before, current: current, rest: rest-before, target-note: target-note)
      #v(4pt)
      #text(size: 9pt, weight: "bold", fill: blue)[Neue Karte: #deckz.inline(found)]
      #v(2pt)
      #text(size: 12pt)[#text-line]
      #v(4pt)
      #state-after(sorted-after, current: next-current, rest: next-rest)
    ],
    fill: gray,
  )
}

// Einstieg mit Titel und organisatorischen Rahmendaten.
#headline-box()

#grid(
  columns: (1fr, 1fr, 2fr),
  gutter: 8pt,
  chip([Du brauchst], [Spielkarten, Stift]),
  chip([Zeit], [ca. 20 Minuten]),
  chip([Ziel], [Du kannst Insertion Sort erklären und selbst anwenden.]),
)

// Einführung in die Grundidee des Verfahrens.
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
     #image("image-16.png")
    ],
  )
])

// Arbeitsroutine und typische Missverständnisse nebeneinander.
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

// Seite 2: Start des durchgerechneten Beispiels.
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

// Die ersten beiden Einfügeschritte des Beispiels.
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  row-gutter: 10pt,

  insertion-panel(
    1,
    ("7H",),
    "3H",
    ("9H", "2H", "6H"),
    "3H",
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
    "9H",
    [↓ hinter #deckz.inline("7H")],
    [Die neue Karte ist die *9*. \ Sie ist größer als die *7* und bleibt ganz rechts.],
    ("3H", "7H", "9H"),
    next-current: "2H",
    next-rest: ("6H",),
  ),
)

// Seite 3: Abschluss des Beispiels.
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
    "2H",
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
    "6H",
    [↓ zwischen #deckz.inline("3H") und #deckz.inline("7H")],
    [Die neue Karte ist die *6*. \ Sie passt zwischen *3* und *7*.],
    ("2H", "3H", "6H", "7H", "9H"),
    next-current: none,
    next-rest: (),
  ),
)

// Zusammenfassung des vollständig sortierten Beispiels.
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

// Seite 4: eigenständige Schülerarbeit.
#pagebreak()

#infobox(
  [Jetzt bist du dran],
  [
    Lege diese Karten vor dich:
    #card-row("8S", "4S", "2S", "7S", "3S", "6S")
  ],
  fill: light-blue,
)

// Arbeitsauftrag und Denkhilfe für die eigene Durchführung.
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

// Dokumentationstabelle plus Selbstkontrolle für die Lernenden.
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

// Abschlussfrage zur sprachlichen Sicherung des Algorithmusverständnisses.
#infobox(
  [Zusatzfrage],
  [
    Erkläre in *einem Satz*:
    *Was ist der Unterschied zwischen „die kleinste Karte im Rest suchen“ und „die nächste Karte passend einfügen“?*
    #v(10pt)
    #line(length: 100%)
    #v(10pt)
    #line(length: 100%)
  ],
  fill: light-blue,
)
