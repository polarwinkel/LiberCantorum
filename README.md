# LiberCantorum

[en]Songbook-generator based on Lilypond, creating a pdf-songbook and a static web-version including a midi-playback

Featuring mostly german songs so far and therefore assuming mostly german users the documentation is german - let me know if a international (-> en) version is desired[/en]

Ein Liederbuch-Generator auf Lilypond-Basis, der mit LaTex ein pdf-Liederbuch erstellt sowie eine statische web-Version samt midi-Playback als Klavierbegleitung.

## Entwicklungsstand

Aktuell ist LiberCantorum im Alpha-Stadium. Rechne mit Fehlern und Änderungen!

## Bedienung

LiberCantorum ist aktuell auf die Ausführung auf Linux-Systemen ausgelegt.

Nach dem Klonen des Repositories sind die Pakete aus der `dependencies.txt` noch zu installieren (angegeben sind die Paketnamen unter Debian 13 (trixie)). [TODO: Die Liste ist aktuell noch nicht vollständig]

Die Lieder (im Code `canti`) liegen als Lilypond-Datei `score.ly` in Ordnern im `scores`-Verzeichnis. Es wird empfohlen die Struktur von `Die_Gedanken_sind_frei` für eigene Lieder zu übernehmen.

Dazu ist eine `lyrics.yaml`-Datei nötig, die den `title` und die `strophes: |+` (vorformattiert mit Zeilenumbrüchen, daher das `|+`) enthält; vergleiche `/scores/Die_Gedanken_sind_frei/`

Werden eigene Lieder hinzugefügt kann der Ordnername mit einem `_` begonnen werden. Dann werden diese in git ignoriert und sind "private". Ebenso können vorhandene Canti für den privaten Gebrauch angepasst werden indem der Cantus-Ordner kopiert wird mit `_`-präfix, dieser wird beim Build bevorzugt.

Eine eigene Zusammenstellung von Canti ist durch Erstellen einer Datei `canti.yaml` möglich, in der die gewünschten Ordnernamen in der gewünschten Reihenfolge als `- `-Liste angegeben werden, z.B.:

```
- Die_Gedanken_sind_frei
- _Als_die_Roemer_frech_geworden
```
 
## Konvention

_(bei nicht-Zustimmung gerne eine Issue erstellen um es zu diskutieren)_

Die Lilypond-Dateien sollen auf einen Druck auf Din-A5-Format ausgelegt sein, wobei diese auch in schwachem Licht auch von älteren Menschen lesbar sein sollen.
Dadurch ist auch ein Druck in kleiner auf ansonsten üblicher Liederbuch-Größe gewährleistet.

Entgegen vieler Liederbücher sollen die Noten möglichst nicht zufällig umbrechen, sondern nach einer sinnvollen Taktzahl um die Orientierung zu verbessern - auf Kosten von etwas Platz.
Gleiches gilt für die Strophen.

In LaTeX-Manier ist das pdf-Liederbuch auf großzügige, und damit übersichtliche, Platznutzung angelegt. Die erzeugte LaTeX-Quelldatei kann bei Bedarf nach dem Build manuell angepasst werden.
