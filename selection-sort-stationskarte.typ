/*--------------------------------------------*
* Copyright (C) 2026 Jan Müller              *
* SPDX-License-Identifier: GPL-3.0-or-later  *
*--------------------------------------------*/

/*--------------------------------------------------------------------*
* Importiert nur die Pakete, die diese Stationskarte konkret benutzt. *
* `deckz` zeichnet Karten, `fletcher` das Aktionsdiagramm, `ccicons`  *
* die Lizenz und `qrcode` den Link zum GitHub-Repository.             *
*--------------------------------------------------------------------*/
#import "@preview/deckz:0.3.1"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node
#import fletcher.shapes: pill
#import "@preview/ccicons:1.0.1": *
#import "@preview/zebra:0.1.0": qrcode

/*---------------------------------------------------------------*
* Hinterlegt die Metadaten, die in Kopf- und Fußzeile auftauchen. *
* So bleiben Titel, Autor:innenangabe und Beschreibung zentral    *
* gepflegt und müssen nicht mehrfach im Dokument wiederholt werden. *
*---------------------------------------------------------------*/
#set document(
  title: [Stationskarte Selection Sort:],
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
      #text(size: 14pt, weight: "bold")[Sortieren nach Selection Sort entdecken]
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
        #qrcode(repo-url, height: 65pt, background-fill: white)
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

/*-----------------------------------------------------------------*
* Rendert eine kleine Kartenfolge für die Mini-Zustandsanzeige.    *
* Ist die Folge leer, wird stattdessen der jeweils übergebene      *
* Platzhalter ausgegeben, also Kartenrückseite oder Leerhinweis.   *
*-----------------------------------------------------------------*/
#let mini-sequence(cards, empty) = {
  if cards.len() == 0 {
    empty
  } else {
    deckz.line(..cards, format: "mini", spacing: 4pt)
  }
}

/*----------------------------------------------------------------*
* Zeichnet die kompakte Zustandsanzeige für einen Selection-Schritt. *
* Links steht, was bereits sicher einsortiert ist, rechts der noch  *
* zu betrachtende Rest.                                             *
*----------------------------------------------------------------*/
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
      #mini-sequence(sorted, deckz.back(format: "mini"))
    ],

    [#text(size: 8.5pt, weight: "bold", fill: blue)[Rest:]],
    [
      #mini-sequence(rest, emph[keine Karten mehr])
    ],
  )
]

/*----------------------------------------------------------------*
* Visualisiert die Aktion eines Beispielschritts als Mini-Diagramm. *
* So wird neben dem Text sofort sichtbar, ob die kleinste Karte     *
* nach vorne geholt wird oder bereits vorne liegt.                  *
*----------------------------------------------------------------*/
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

/*----------------------------------------------------------------*
* Baut einen kompletten Beispielschritt für das Lehrbeispiel.      *
* Ein Schritt enthält den Zustand vor dem Suchen, die gefundene    *
* kleinste Karte, die sprachliche Erklärung und den neuen Zustand. *
*----------------------------------------------------------------*/
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
  chip([Ziel], [Du kannst Selection Sort erklären und selbst anwenden.]),
)

/*----------------------------------------------------------------*
* Führt knapp in die Grundidee von Selection Sort ein.            *
* Text und Bild stehen nebeneinander, damit die verbale Erklärung *
* sofort an eine konkrete Darstellung gekoppelt wird.             *
*----------------------------------------------------------------*/
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
        image("assets/selction-sort.png"),
      )
    ],
  )])

/*----------------------------------------------------------------*
* Stellt Arbeitsroutine und typische Fehlvorstellungen direkt      *
* gegenüber. So sehen Lernende auf einen Blick, was sie tun sollen *
* und was Selection Sort gerade nicht bedeutet.                    *
*----------------------------------------------------------------*/
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

/*--------------------------------------------------------------*
* Seite 2 beginnt mit einem vollständig vorbereiteten Beispiel. *
* Von hier aus wird Schritt für Schritt sichtbar, wie immer die *
* kleinste Karte des Restes nach vorne geholt wird.             *
*--------------------------------------------------------------*/
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

/*--------------------------------------------------------------*
* Auf der nächsten Seite wird das Beispiel vollständig beendet. *
* Die letzten beiden Schritte zeigen sowohl einen echten Tausch *
* als auch den Fall, dass kein Tausch mehr nötig ist.           *
*--------------------------------------------------------------*/
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

/*----------------------------------------------------------------*
* Die Abschlussfrage sichert die zentrale Denkbewegung von        *
* Selection Sort sprachlich ab. So wird noch einmal bewusst,      *
* dass hier nicht die nächste, sondern die kleinste Karte zählt. *
*----------------------------------------------------------------*/
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
