# LiberCantorum

[en]Songbook-generator based on Lilypond, creating a pdf-songbook and a static web-version including a midi-playback

Featuring mostly german songs so far and therefore assuming mostly german users the documentation is german - let me know if a international (-> en) version is desired[/en]

Ein Liederbuch-Generator auf Lilypond-Basis, der mit LaTex ein pdf-Liederbuch erstellt sowie eine statische web-Version samt midi-Playback als Klavierbegleitung.

## Features

- **PDF-Liederbuch**: Automatische Generierung mittels LaTeX aus Lilypond-Dateien
- **Web-Version**: Statische Website mit integrierten Noten und Liedtexten
- **MIDI-Playback**: Klavierbegleitung für alle Lieder mit html-midi-player
- **Tempo-Anpassung**: Slider-Kontrolle (50%-200%) für MIDI-Wiedergabe. Implementiert als JavaScript-Workaround mit automatischer Original-Tempo-Erkennung und visuellem Feedback.
- **Flexible Liedauswahl**: Unterstützung für private Lieder und eigene Zusammenstellungen
- **Editor-Server**: lokaler Webserver zur Lied-Bearbeitung im Browser

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

Entgegen vieler Liederbücher sollen die Noten - sofern sinnvoll möglich - nicht zufällig umbrechen, sondern an geeigneten Stellen, um die Orientierung zu verbessern - auf Kosten von etwas Platz.
Gleiches gilt für die Strophen.

In LaTeX-Manier ist das pdf-Liederbuch auf großzügige, und damit übersichtliche, Platznutzung angelegt. Die erzeugte LaTeX-Quelldatei kann bei Bedarf nach dem Build manuell angepasst werden.

Alle Noten werden als Lilypond-code `\relative c'` verarbeitet, also relativ zur Oktave c'.

## LcServer

Die `LcServer.py` stellt einen Webserver zur Verfügung um die Lieder anzuzeigen oder zu editieren. Dieser ist auf Port 4210 auf dem localhost erreichbar.

_Für die Einrichtung für den Zugriff von "aussen" sind erweiterte IT-Kenntnisse notwendig - nur einrichten wenn die folgenden Zeilen wirklich verstanden werden!_

Soll dieser für _vertrauenswürdige, wenige Nutzer_ von aussen zugänglich gemacht werden ist z.B. ein Reverse-Proxy zu verwenden, z.B. nginx mit der config:

```
    # LiberCantorum
    location /lc/ {
        proxy_pass              http://127.0.0.1:4210/out/; # oeffentlicher Zugang zu den statischen Seiten
    }
    location /lcs/ {
        proxy_pass              http://127.0.0.1:4210/; # geschuetzter Zugang zum LcServer
        auth_basic              "Interner Bereich für LiberCantorum-Server!";
        auth_basic_user_file    lc.passwd;
    }
```

Es wird dringend empfohlen über den Reverse-Proxy sicher zu stellen, dass eine verschlüsselte Verbindung eingesetzt wird.

Weiterhin ist es empfehlenswert ein WSGI-Server (wie z.B. Gunicorn oder Waitress) einzusetzen.

## Geplante Features

- ~das pdf hübscher machen~
- Index der Titel und der Liedanfänge
- ggf. (optionale) thematische Sortierung/Kapitel

- in progress: Zusatz-Information wie Autor, Erscheinungsjahr etc. in die `lyrics.yaml` aufnehmen. (könnte man schon rein schreiben, würde aktuell ignoriert)

- einzelnen Cantus als pdf zum Download anbieten
