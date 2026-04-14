/*--------------------------------------------*
* Copyright (C) 2026 Jan Müller              *
* SPDX-License-Identifier: GPL-3.0-or-later  *
*--------------------------------------------*/

/*--------------------------------------------------------------------*
* Diese Stationskarte orientiert sich bewusst am Layout der bereits    *
* vorhandenen Sortier-Stationskarten und überträgt das Schema auf die  *
* Station zum Thema Laufzeit.                                          *
*--------------------------------------------------------------------*/
#import "@preview/ccicons:1.0.1": *
#import "@preview/zebra:0.1.0": qrcode

#set document(
  title: [Stationskarte Laufzeit:],
  author: "Herr A. Firle - Herr I. Röhse - Herr J. Müller -",
  description: [Weiterbildungskurs Informatik 08 - Baustein 05 Didaktik - #cc-by-nc-sa],
)

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

#set text(lang: "de", size: 12pt)
#set par(justify: false, leading: 0.82em)

#let blue = rgb("#2E5E8A")
#let light-blue = rgb("#EEF6FC")
#let green = rgb("#EAF7EC")
#let yellow = rgb("#FFF6D8")
#let red = rgb("#FFF0EF")
#let gray = rgb("#F6F7F8")
#let repo-url = "https://github.com/JMueller-edu/Pruefungsaufgabe_Didaktik_Info_08.git"

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
      #text(size: 14pt, weight: "bold")[Laufzeit und Wachstum entdecken]
      #v(3pt)
      #text(size: 8.8pt)[Informatik · Klasse 10]
      \
      #text(size: 7pt)[_Dieses Material wurde im Textsatzsystem Typst mit Unterstützung von ChatGPT erstellt_]
    ],
    [
      #align(center)[
        #image("assets/Laufzeit.png", width: 30%)
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

#let road-part(kind) = {
  if kind == "leer" {
    block(
      inset: 5pt,
      stroke: 0.7pt + rgb("#C7D2DB"),
      radius: 5pt,
      fill: white,
      width: 100%,
    )[
      #align(center)[#text(size: 9pt)[Lücke]]
    ]
  } else {
    block(
      inset: 5pt,
      stroke: 0.7pt + rgb("#C7D2DB"),
      radius: 5pt,
      fill: yellow,
      width: 100%,
    )[
      #align(center)[#text(size: 9pt, weight: "bold")[Strich]]
    ]
  }
}

#let hint-card(title, body, fill: yellow) = block(
  inset: 8pt,
  radius: 8pt,
  stroke: 0.75pt + rgb("#D6C98A"),
  fill: fill,
  width: 100%,
)[
  #text(weight: "bold", fill: blue)[#title]
  #v(2pt)
  #body
]

#let task-color(task) = {
  if task == 1 {
    rgb("#2E5E8A")
  } else if task == 2 {
    rgb("#2F7D4A")
  } else if task == 3 {
    rgb("#B56A1E")
  } else {
    rgb("#7A4FB0")
  }
}

#let task-symbol(task) = {
  if task == 1 {
    [●]
  } else if task == 2 {
    [■]
  } else if task == 3 {
    [▲]
  } else {
    [◆]
  }
}

#let task-badge(task) = block(
  inset: (x: 6pt, y: 3pt),
  radius: 999pt,
  fill: task-color(task),
)[
  #set text(size: 7pt, weight: "bold", fill: white)
  #task-symbol(task) Aufgabe #task
]

#let cut-card(task, title, body, fill: white) = block(
  inset: 7pt,
  radius: 8pt,
  stroke: 0.8pt + rgb("#B7C5D1"),
  fill: fill,
  width: 100%,
  height: 100%,
)[
  #set text(size: 7.6pt)
  #grid(
    columns: (auto, 1fr),
    gutter: 5pt,
    align: (left, top),
    task-badge(task),
    [#text(size: 8.4pt, weight: "bold", fill: blue)[#title]],
  )
  #v(3pt)
  #body
]

#let blank-cut-card() = block(
  inset: 7pt,
  radius: 8pt,
  stroke: 0.8pt + rgb("#D9E0E6"),
  fill: white,
  width: 100%,
  height: 100%,
)[]

#headline-box()

#grid(
  columns: (1.2fr, 0.8fr, 4fr),
  gutter: 8pt,
  chip([Du brauchst], [Tabellenkalkulation, Stift]),
  chip([Zeit], [ca. 25 Minuten]),
  chip([Ziel], [Du erkennst, dass Laufzeit quadratisch wachsen kann, und stellst einen Bezug zu Bubble Sort her.]),
)

#infobox([Worum geht es?], [
  Ein alter Witz erzählt von einem Lehrling, der Fahrbahnmarkierungen auf eine Straße malt. In der ersten Stunde schafft er viel, danach immer weniger. Seine Begründung: Er muss nach jedem Strich wieder zurück zum Farbeimer laufen und der Weg wird jedes Mal länger.

  An dieser Station untersuchst du, wie stark dadurch die *Gesamtzeit* ansteigt und was das mit der Laufzeit eines Algorithmus zu tun hat.
])

#grid(
  columns: (1.1fr, 0.9fr),
  gutter: 12pt,
  [
    #infobox([Modell der Situation], [
      - Der Lehrling läuft *1,2 Sekunden pro Meter*.
      - Für einen *1 Meter langen Strich* braucht er *10 Sekunden*.
      - Zwischen zwei Strichen liegt jeweils *1 Meter Abstand*.
      - Er beginnt am Farbeimer zuerst mit einer *Lücke*, dann folgt der erste Strich.
      - Nach jedem Strich läuft er *zum Farbeimer zurück*.
    ])
  ],
  [
    #infobox([So sieht das Muster aus], [
      #grid(
        columns: (1fr, 1fr, 1fr, 1fr, 1fr),
        gutter: 4pt,
        road-part("leer"),
        road-part("strich"),
        road-part("leer"),
        road-part("strich"),
        road-part("leer"),
      )
      #v(6pt)
      *Merksatz:* Jeder neue Strich liegt weiter vom Farbeimer entfernt als der vorherige.
    ], fill: green)
  ],
)

#infobox([Wichtig], [
      Hier geht es *nicht* um eine genaue Programmiersprache, sondern um die Frage:
      *Wie wächst der Aufwand, wenn das Problem größer wird?*
    ], fill: red)

/*#grid(
  columns: (1fr, 1fr),
  gutter: 12pt,
  [
    #infobox([So gehst du vor], [
      1. Erstelle für Aufgabe 1 eine Tabelle in Excel oder Calc.
      2. Trage für mehrere Straßenlängen die Gesamtzeit ein.
      3. Suche anschließend ein Muster zwischen Straßenlänge und Laufzeit.
      4. Übertrage deine Beobachtung auf Bubble Sort.
    ])
  ],
  [
    #infobox([Wichtig], [
      Hier geht es *nicht* um eine genaue Programmiersprache, sondern um die Frage:
      *Wie wächst der Aufwand, wenn das Problem größer wird?*
    ], fill: red)
  ],
)
*/
#pagebreak()



#grid(
  columns: (2fr, 1fr),
  gutter: 10pt,
  [
    #infobox([Arbeitsauftrag 1], [
  Bestimme die Laufzeit des Lehrlings bei einer Straßenlänge von *100 m, 200 m, 300 m, 400 m und 500 m*.
  Benutze dafür eine Tabellenkalkulation. Lege die Tabelle so an, dass du Werte aus der jeweils vorherigen Zeile weiterverwenden kannst.
], fill: light-blue)
    #infobox([Denkhilfe], [
      Für jeden weiteren Strich kommen drei Zeitanteile zusammen:
      - der Hinweg,
      - der Rückweg,
      - das eigentliche Malen des Strichs.
      Deshalb wird die Zeit nicht in jedem Schritt gleich stark größer.
    ], fill: yellow)
  ],
  [
    #infobox([Tabellenvorlage], [
      #table(
        columns: (auto, auto, auto, auto),
        inset: 5pt,
        stroke: 0.7pt + black,
        align: left + horizon,
        [*Länge*], [*Hinweg*], [*Rückweg*], [*Gesamtzeit*],
        [0], [0], [0], [0],
        [100], [], [], [],
        [200], [], [], [],
        [300], [], [], [],
        [400], [], [], [],
        [500], [], [], [],
      )
    ])
  ],
)



#grid(
  columns: (2fr, 1fr),
  gutter: 10pt,
  [
    #infobox([Arbeitsauftrag 2], [
  Finde einen mathematischen Zusammenhang zwischen der *Länge der Straße* und der *Laufzeit* des Lehrlings.

  Du darfst die Laufzeit dazu in *Minuten* umrechnen und grob auf *Hunderter* runden.
])
    #infobox([Beobachtungsfrage], [
      Prüfe, ob sich eher ein Muster wie
      - linear: $l$, 
      - quadratisch: $l^2$,
      - oder noch stärker ergibt.

      Begründe deine Entscheidung mit deinen Tabellendaten.
    ], fill: green)
  ],
  [
    #infobox([Hilfsraster für Aufgabe 2], [
      #table(
        columns: (auto, auto),
        inset: 6pt,
        stroke: 0.7pt + black,
        align: left + horizon,
        [*Länge in dam*], [*Zeit in min (gerundet)*],
        [10], [],
        [20], [],
        [30], [],
        [40], [],
        [50], [],
      )
    ])
  ],
)

#pagebreak()

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  [
    #infobox([Arbeitsauftrag 3], [
      Untersuche, wie sich die Laufzeit ändern würde, wenn der Lehrling *von hinten beginnen* würde.

      Er startet dann beim letzten Strich und arbeitet sich Schritt für Schritt bis zum Farbeimer vor.

      *Frage:* Würde sich die Gesamtzeit ändern? Begründe deine Vermutung.
      #v(18pt)
      #line(length: 100%)
      #v(18pt)
      #line(length: 100%)
        #v(18pt)
      #line(length: 100%)
    ])
  ],
  [
    #infobox([Arbeitsauftrag 4], [
      Vergleiche das Vorgehen des Lehrlings mit dem Sortierverfahren *Bubble Sort*.

      Stelle eine Vermutung auf, wie die Anzahl der zu sortierenden Objekte und die benötigte Laufzeit des Computers zusammenhängen könnten.

      Für die Zeit eines einzelnen Rechenschritts verwenden wir die Einheit *OP* (Operation).
      #v(18pt)
      #line(length: 100%)
      #v(18pt)
      #line(length: 100%)
    ])
  ],
)

#grid(
  columns: (1fr, 1fr),
  gutter: 10pt,
  [
    #infobox([Verbindung zu Bubble Sort], [
      Denke an die Grundidee:
      Nach jedem Durchgang ist hinten *ein weiteres Element an der richtigen Stelle*.

      Auch beim Lehrling ist nach jedem Durchgang *eine weitere Markierung fertig*.
    ], fill: light-blue)
  ],
  [
    #infobox([Merkkasten Laufzeit], [
      Wenn bei wachsender Problemgröße immer mehr Wege oder Vergleiche mehrfach wiederholt werden, wächst der Aufwand oft *quadratisch*.
    ], fill: red)
  ],
)

#infobox([Zusatzfrage], [
  Formuliere in *einem Satz*:
  Warum ist nicht nur wichtig, *was* gemacht wird, sondern auch *in welcher Reihenfolge und wie oft* es gemacht wird?
  #v(12pt)
  #line(length: 100%)
  #v(12pt)
  #line(length: 100%)
], fill: light-blue)

#pagebreak()

#infobox([Hinweiskärtchen zum Ausschneiden], [
], fill: light-blue)

#grid(
  columns: (1fr, 1fr, 1fr),
  rows: (3.5cm, 3.5cm, 3.5cm, 3.5cm),
  gutter: 8pt,
  row-gutter: 8pt,

  cut-card(1, [Hinweis 1], [
    Der Lehrling benötigt für das Anbringen der Markierungen für eine *5 m* lange Straße so viel Zeit wie für ein *4 m* langes Stück Straße und zusätzlich noch die Zeit für den letzten Strich.

    Erstelle deine Tabelle so, dass du den neuen Wert jeweils aus der Zeile darüber berechnest.
  ], fill: yellow),


  cut-card(1, [Hinweis 2], [
    Die erste Zeile unter dem Tabellenkopf wird mit Nullen gefüllt.

    In jeder folgenden Zeile gilt:
    - neue Länge = alte Länge + 2
    - Hinweg = (neue Länge - 1) x 1,2
    - Rückweg = neue Länge x 1,2
    - neue Gesamtzeit = alte Gesamtzeit + Hinweg + Rückweg + 10 s
  ], fill: yellow),

  cut-card(1, [Lösung], [
    #table(
      columns: 4,
      inset: 2pt,
      stroke: 0.4pt + black,
      align: center + horizon,
      [*Länge*], [*Hin*], [*Zurück*], [*Gesamt*],
      [0], [0], [0], [0],
      [100], [118,8], [120], [6560],
      [200], [238,8], [240], [25120],
      [300], [358,8], [360], [55680],
      [400], [478,8], [480], [98240],
      [500], [598,8], [600], [152800],
    )
  ], fill: green),

  cut-card(2, [Hinweis 1], [
    Wandle die Zeiten aus deiner Tabelle in *Minuten* um und runde grob auf volle Hunderter.
  ], fill: yellow),

  cut-card(2, [Hinweis 2], [
    Schreibe die Längen anschließend in *Dekameter* (dam) auf und notiere daneben die gerundeten Zeiten.
  ], fill: yellow),

    cut-card(2, [Hinweis 3], [
    #align(center)[
      #table(
        columns: 2,
        inset: 3pt,
        stroke: 0.4pt + black,
        align: center + horizon,
        [*Länge in dam*], [*Zeit in min*],
        [10], [100],
        [20], [400],
        [30], [900],
        [40], [1600],
        [50], [2500],
      )
    ]
  ], fill: yellow),

    cut-card(2, [Lösung], [
    Für eine Strecke der Länge $l$ in Dekametern gilt näherungsweise:
    #v(4pt)
    #align(center)[*$l^2$*]
    #v(4pt)
    Die Laufzeit wächst also ungefähr *quadratisch* mit der Länge der Straße.
  ], fill: green),

    cut-card(3, [Lösung], [
    Die Reihenfolge ändert sich, aber an der *Gesamtzeit* ändert sich nichts.

    Die einzelnen Wege werden nur anders angeordnet. Die Summe aller Teilzeiten bleibt gleich.
  ], fill: green),

  cut-card(4, [Hinweis 1], [
    *Bubble Sort* funktioniert so:

    Nimm das erste Element „in die Hand“ und durchlaufe das Feld bis zum letzten Element. Triffst du auf ein größeres Element, legst du das bisherige ab, nimmst das größere auf und gehst weiter.
    Am Ende liegt das größte Element ganz hinten richtig. Danach beginnt der Vorgang erneut bis zur vorletzten Position, dann bis zur vorvorletzten Position und so weiter.
  ], fill: yellow),

  cut-card(4, [Hinweis 2], [
    Suche die Gemeinsamkeit mit dem Lehrling, der beim *letzten Strich* beginnt und sich dann *von hinten nach vorn* zum Farbeimer vorarbeitet.
  ], fill: yellow),

    cut-card(4, [Hinweis 3], [
    Beide – Bubble Sort und der Lehrling – durchlaufen das Feld bzw. die Straße mehrfach. Nach jedem Durchgang ist hinten *ein weiteres Objekt* am richtigen Platz bzw. eine weitere Markierung fertig.

    Zusätzlich zur Wegzeit gibt es immer noch eine feste Zeit für die eigentliche Operation: Vertauschen oder Malen.
  ], fill: yellow),

    cut-card(4, [Lösung], [
    Das Vorgehen ist dem des Lehrlings sehr ähnlich.

    Eine plausible Vermutung lautet deshalb:
    Für ein Feld mit $n$ Elementen benötigt Bubble Sort ungefähr *$n^2$ OPs*.
  ], fill: green),

)
