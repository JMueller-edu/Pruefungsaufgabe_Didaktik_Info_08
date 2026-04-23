/*--------------------------------------------*
* Sammeldatei für Überblick + Stationskarten  *
*--------------------------------------------*/

/*
Diese Datei bindet zuerst die Überblickskarte im Hochformat und danach
alle vier Stationskarten ein. Da die Einzeldateien ihr Seitenlayout
selbst setzen, bleiben Hoch- und Querformat in der gemeinsamen PDF
jeweils erhalten.
*/

#include "ueberblick-stationenlernen.typ"
#pagebreak()

#include "selection-sort-stationskarte.typ"
#pagebreak()

#include "insertion-sort-stationskarte.typ"
#pagebreak()

#include "laufzeit-stationskarte.typ"
#pagebreak()

#include "merge-sort-stationskarte.typ"
