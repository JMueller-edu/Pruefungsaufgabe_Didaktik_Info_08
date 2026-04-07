/*--------------------------------------------*
 * Copyright (C) 2026 Jan Müller              *
 * SPDX-License-Identifier: GPL-3.0-or-later  *
 *--------------------------------------------*/

// Externe Pakete für Kartenlayout und einfache Ablaufdiagramme.
#import "@preview/deckz:0.3.1"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: diamond, pill
#import "@preview/ccicons:1.0.1": *
#import "@preview/zebra:0.1.0": datamatrix, qrcode

// Dokumentmetadaten für Titelzeile und Fußbereich.
#set document(
  title: [Stationskarte Selection Sort:],
  author: "Herr A. Firle - Herr I. Röhse - Herr J. Müller -",
  description: [Weiterbildungskurs Informatik 08 - Baustein 05 Didaktik - #cc-by-nc-sa],
)

// Drucklayout für eine quer gedrehte A4-Stationskarte.
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

// Grundtypografie: gut lesbar, linksbündig, mit kompaktem Zeilenabstand.
#set text(lang: "de", size: 12pt)
#set par(justify: false, leading: 0.82em)

// Farbpalette für wiederkehrende Boxen und Hervorhebungen.
#let blue = rgb("#2E5E8A")
#let light-blue = rgb("#EEF6FC")
#let green = rgb("#EAF7EC")
#let yellow = rgb("#FFF6D8")
#let red = rgb("#FFF0EF")
#let gray = rgb("#F6F7F8")
#let dark = rgb("#253746")

// Standardbox für inhaltliche Abschnitte wie Erklärungen, Hinweise und Aufgaben.
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

// Kleine Infokacheln für organisatorische Angaben wie Material, Zeit und Ziel.
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

// Kopfbereich mit Titel und dekorativer Kartenhand.
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
      #text(size: 14pt, weight: "bold")[Sortieren nach Selection Sort entdecken]
      #v(3pt)
      #text(size: 8.8pt)[Informatik · Klasse 10]
      \
      #text(size: 7pt)[_Dieses Material wurde im Textsatzsystem Typst mit Unterstützung von ChatGPT erstellt_]
    ],
    [
      #align(center)[
      #deckz.hand("7H", "3H", "9H", "2H", "6H", format: "mini", angle: 16deg, width: 3.5cm)
      #text(size: 8.8pt)[https://gist.github.com/JMueller-edu/578f6deba3f7c91e9b83b23a49734637#file-selection-sort-stationskarte-typ]
    ]],
    [
      #align(right)[
        #qrcode("https://gist.github.com/JMueller-edu/578f6deba3f7c91e9b83b23a49734637#file-selection-sort-stationskarte-typ",height: 65pt, background-fill: white)
      ]],
  )
]

// Hilfsfunktion, um eine Kartenreihe einheitlich zu setzen.
#let card-row(..cards) = align(center)[
  #deckz.line(..cards, format: "small", spacing: 8pt)
]

// Kompakte Zustandsanzeige für bereits sortierten Teil und verbleibenden Rest.
#let state-mini(sorted, rest) = block(
  inset: 6pt,
  radius: 7pt,
  stroke: 0.75pt + rgb("#D0D7DE"),
  fill: white,
  width: 100%,
)[
  #grid(
    columns: (auto, 1fr),
    gutter: 6pt,
    row-gutter: 4pt,
    [#text(size: 8.5pt, weight: "bold", fill: blue)[Fertig:]],
    [
      #if sorted.len() == 0 {
        deckz.back(format: "mini")
      } else {
        deckz.line(..sorted, format: "mini", spacing: 4pt)
      }
    ],

    [#text(size: 8.5pt, weight: "bold", fill: blue)[Rest:]],
    [
      #if rest.len() == 0 {
        emph[keine Karten mehr]
      } else {
        deckz.line(..rest, format: "mini", spacing: 4pt)
      }
    ],
  )
]

// Reserve: vereinfachter Ablauf einer Selection-Sort-Runde als Diagramm.
#let round-diagram() = align(center)[
  #diagram(
    spacing: (8mm, 6mm),
    node-stroke: 0.8pt + blue,
    edge-stroke: 0.8pt + blue,
    node-fill: white,
    mark-scale: 85%,

    node((0, 0), [Rest anschauen], shape: pill, fill: light-blue, name: <a>),
    node((1, 0), [kleinste Karte finden], shape: pill, fill: light-blue, name: <b>),
    node((0, 1), [nach vorne holen], shape: pill, fill: green, name: <c>),
    node((1, 1), [links ist eine Karte mehr fertig], shape: pill, fill: yellow, name: <d>),

    edge(<a>, <b>, "->"),
    edge(<b>, <c>, "->"),
    edge(<c>, <d>, "->"),
  )
]

// Reserve: Vergleichsdiagramm für die Entscheidung "Tausch nötig oder nicht?".
#let compare-diagram() = align(center)[
  #diagram(
    spacing: (10mm, 6mm),
    node-stroke: 0.8pt + blue,
    edge-stroke: 0.8pt + blue,
    node-fill: white,
    mark-scale: 85%,

    node((0, 0), [kleinste Karte \ im Rest], shape: diamond, fill: yellow, name: <a>),
    node((1, 1), [Tausch], shape: pill, fill: green, name: <b>),
    node((-1, 1), [kein Tausch], shape: pill, fill: light-blue, name: <c>),

    edge(<a>, <b>, [nein], "-|>", corner: right),
    edge(<a>, <c>, [ja], "-|>", corner: left),
  )
]

// Kleines Aktionsdiagramm innerhalb eines Beispielschritts.
#let action-diagram(label, fill: green) = align(center)[
  #diagram(
    spacing: (8mm, 5mm),
    node-stroke: 0.8pt + blue,
    edge-stroke: 0.8pt + blue,
    node-fill: white,
    mark-scale: 85%,

    node((0, 0), [kleinste Karte], shape: pill, fill: light-blue, name: <a>),
    node((1, 0), label, shape: pill, fill: fill, name: <b>),
    edge(<a>, <b>, "->"),
  )
]

// Baut ein vollständiges Schrittfeld für das durchgerechnete Beispiel:
// Zustand vorher, gefundene kleinste Karte, Erklärung und Zustand nachher.
#let step-panel(number, sorted-before, rest-before, found, text-line, sorted-after, rest-after, swap: true) = {
  let action-label = if swap { [nach vorne] } else { [schon vorne] }
  let action-fill = if swap { green } else { yellow }

  infobox(
    [
      Schritt #number
    ],
    [
      #state-mini(sorted-before, rest-before)
      #v(4pt)
      #grid(
        columns: (auto, 1fr),
        gutter: 8pt,
        align: center + horizon,
        [#deckz.medium(found)], [#text(size: 12pt)[#text-line], #action-diagram(action-label, fill: action-fill)],
      )
      #state-mini(sorted-after, rest-after)
    ],
    fill: gray,
  )
}

// Einstieg mit Titel und organisatorischem Überblick.
#headline-box()

#grid(
  columns: (1fr, 1fr, 2fr),
  gutter: 8pt,
  chip([Du brauchst], [Spielkarten, Stift]),
  chip([Zeit], [ca. 20 Minuten]),
  chip([Ziel], [Du kannst Selection Sort erklären und selbst anwenden.]),
)

// Erste Erklärung: Grundidee des Verfahrens plus anschauliches Bild.
#infobox([Worum geht es?], [
  #grid(
    columns: (1fr, 1fr),
    gutter: 12pt,
    [
      Bei *Selection Sort* suchst du immer die *kleinste Karte* im noch unsortierten Teil.

      Diese Karte holst du dann *nach vorne*.

      *Merksatz:*

      Selection Sort = *kleinste Karte suchen und nach vorne tauschen.*
    ],
    [#figure(
        image("image-2.png"),
      )
    ],
  )])

// Arbeitsroutine und typische Stolperstelle nebeneinander.
#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,

  [
    #infobox([So arbeitest du in jeder Runde], [
      1. Schaue nur auf den *rechten, noch nicht fertigen Teil*.
      2. Finde dort die *kleinste Karte*.
      3. Tausche sie an die *erste Stelle dieses rechten Teils*.
      4. Danach ist links *eine Karte mehr fertig*.
    ])
  ],

  [
    #infobox(
      [Wichtig],
      [
        - Du suchst *nicht* die nächste Karte.
        - Du suchst immer die *kleinste Karte im Rest*.
        - Manchmal ist *gar kein Tausch nötig*, weil die kleinste Karte schon vorne liegt.
      ],
      fill: red,
    )
  ],
)

#v(8pt)

// Seite 2: Beginn des durchgerechneten Beispiels.
#pagebreak()

#infobox(
  [Beispiel],
  [
    Wir starten mit diesen Karten:
    #card-row("7H", "3H", "9H", "2H", "6H")
    Hier zählt nur die *Zahl* auf der Karte. Die Farbe ist egal.
  ],
  fill: light-blue,
)

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  row-gutter: 10pt,

  step-panel(
    1,
    (),
    ("7H", "3H", "9H", "2H", "6H"),
    "2H",
    [Die kleinste Karte ist die *2*. \ Ich hole die *2* ganz nach vorne.],
    ("2H",),
    ("3H", "9H", "7H", "6H"),
    swap: true,
  ),

  step-panel(
    2,
    ("2H",),
    ("3H", "9H", "7H", "6H"),
    "3H",
    [Die kleinste Karte ist die *3*. \ Die *3* liegt schon vorne.],
    ("2H", "3H"),
    ("9H", "7H", "6H"),
    swap: false,
  ),
)

// Seite 3: Fortsetzung des Beispiels bis zum sortierten Ergebnis.
#pagebreak()

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  row-gutter: 10pt,
  step-panel(
    3,
    ("2H", "3H"),
    ("9H", "7H", "6H"),
    "6H",
    [Die kleinste Karte ist die *6*. \ Ich tausche die *6* mit der *9*.],
    ("2H", "3H", "6H"),
    ("7H", "9H"),
    swap: true,
  ),

  step-panel(
    4,
    ("2H", "3H", "6H"),
    ("7H", "9H"),
    "7H",
    [Die kleinste Karte ist die *7*. \ Die *7* liegt schon richtig.],
    ("2H", "3H", "6H", "7H"),
    ("9H",),
    swap: false,
  ),
)
#infobox(
  [Ergebnis des Beispiels],
  [
    Am Ende liegen die Karten so:
    #card-row("2H", "3H", "6H", "7H", "9H")
    Nach jedem Schritt ist links *genau eine Karte mehr* sicher an der richtigen Stelle.
  ],
  fill: green,
)

// Seite 4: Eigenständige Schülerarbeit mit Kartenmaterial.
#pagebreak()

#infobox(
  [Jetzt bist du dran],
  [
    Lege diese Karten vor dich:
    #card-row("8S", "4S", "2S", "7S", "3S", "6S")
  ],
  fill: light-blue,
)


// Arbeitsauftrag und Denkhilfe als begleitende Struktur für die Bearbeitung.
#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,

  [
    #infobox([Dein Arbeitsauftrag], [
      1. Sprich jeden Schritt laut mit:
        „Ich suche die kleinste Karte im Rest.“
      2. Sortiere die Karten mit *Selection Sort*.
      3. Fülle die Tabelle aus.
      4. Vergleiche dein Ergebnis mit der Selbstkontrolle.
    ])
  ],

  [
    #infobox(
      [Denkhilfe],
      [
        Frage dich in jeder Runde:
        - *Wo beginnt der Rest?*
        - *Welche Karte dort ist die kleinste?*
        - *Muss ich tauschen oder nicht?*
      ],
      fill: yellow,
    )
  ],
)

// Dokumentationstabelle für die einzelnen Sortierschritte plus Selbstkontrolle.
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
      [*Schritt*], [*kleinste Karte*], [*Tausch?*], [*Reihenfolge danach*],
      [1], [], [], [],
      [2], [], [], [],
      [3], [], [], [],
      [4], [], [], [],
      [5], [], [], [],
    )],
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

// Abschließende Transferfrage zur inhaltlichen Sicherung.
#infobox(
  [Zusatzfrage],
  [
    Erkläre in *einem Satz*:
    *Was ist der Unterschied zwischen „die nächste Karte anschauen“ und „die kleinste Karte im Rest suchen“?*
    #v(10pt)
    #line(length: 100%)
    #v(10pt)
    #line(length: 100%)
  ],
  fill: light-blue,
)
