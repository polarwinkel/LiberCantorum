# LiberCantorum

[en]Songbook-generator based on Lilypond, creating a pdf-songbook and a static web-version including a midi-playback

Featuring mostly german songs so far and therefore assuming mostly german users the documentation is german - let me know if a international (-> en) version is desired[/en]

Ein Liederbuch-Generator auf Lilypond-Basis, der mit LaTex ein pdf-Liederbuch erstellt sowie eine statische web-Version samt midi-Playback als Klavierbegleitung.

Schaue dir den [aktuellen Liederbuch-Build](https://libercantorum.de) einfach mal an!

## Features

- **PDF-Liederbuch**: Automatische Generierung mittels LaTeX aus Lilypond-Dateien
- **Web-Version**: Statische Website mit integrierten Noten und Liedtexten
- **MIDI-Playback**: Klavierbegleitung für alle Lieder mit html-midi-player
- **Tempo-Anpassung**: Geschwindigkeits-Kontrolle (50%-200%) für MIDI-Wiedergabe
- **Dark-Mode**: Auch für die Noten!
- **Flexible Liedauswahl**: Unterstützung für private Lieder und eigene Zusammenstellungen
- **Editor-Server**: lokaler Webserver zur Lied-Bearbeitung im Browser

## Entwicklungsstand

Aktuell ist LiberCantorum im Alpha-Stadium. Rechne mit Fehlern und ggf. zentralen Änderungen!

## Mitmachen

Du kannst das Lied [Die Gedanken sind frei](https://github.com/polarwinkel/LiberCantorum/tree/main/scores/Die_Gedanken_sind_frei) als Vorlage verwenden und nach dem Muster (vgl. auch unten [Konvention](#Konvention)) eigene Lieder erstellen, z.B. mit dem freien LilyPond-Editor [Frescobaldi](https://frescobaldi.org/).

Gerne kannst du dann die Lieder per pull-request einreichen.
Wenn du nicht weißt wie das geht kannst du es auch über ein neues issue hier im Repository bereitstellen, dann integriere ich es nach dem testen.

## Bedienung

LiberCantorum ist auf die Ausführung auf Linux-Systemen ausgelegt.

Nach dem Klonen des Repositories sind die Pakete aus der `requirements.txt` noch zu installieren (angegeben sind die Paketnamen unter Debian 13 (trixie)).
Mit z.B. `python3 buildSite.py` wird das Liederbuch anhand der Ordner in `scores` erstellt.
Der LcServer kann mit `python3 LcServer.py` gestartet werden und ist dann unter `localhost:4210` im Browser erreichbar.

Alternativ kann durch Ausführen der `install.sh` (als Root) der LcServer als Systemdienst installiert werden. Dieser läuft dann unter dem user `lc` in dessen Homeverzeichnis dann auch die Daten liegen.

Die Lieder (im Code `canti`) liegen als Lilypond-Datei `score.ly` in Ordnern im `scores`-Verzeichnis. Die Struktur muss der von von `template/score.ly` entsprechen damit auch der LcServer diese weiter verarbeiten kann.

Dazu ist eine `lyrics.yaml`-Datei nötig, die den `title` und die `strophes: |+` (vorformattiert mit Zeilenumbrüchen, daher das `|+`) enthält; vergleiche `/scores/Die_Gedanken_sind_frei/`

Werden eigene Lieder hinzugefügt kann der Ordnername mit einem `_` begonnen werden. Dann werden diese in git ignoriert und sind "private". Diese werden nur mit der Kommandozeilenoption `-s private` mit aufgenommen.
Ebenso können vorhandene Canti für den privaten Gebrauch angepasst werden indem der Cantus-Ordner kopiert wird mit `_`-präfix, dieser wird beim Build bevorzugt wenn die Option `-s private` angegeben ist.

Eine eigene Zusammenstellung von Canti ist durch Erstellen einer Datei `canti.yaml` möglich, in der die gewünschten Ordnernamen in der gewünschten Reihenfolge als `- `-Liste angegeben werden, z.B.:

```
- Die_Gedanken_sind_frei
- _Als_die_Roemer_frech_geworden
```

Dann kann das Liederbuch mit `python3 buildSite.py -s canti.yaml` gebaut werden.
 
## Konvention

Als Vorlage dient die Datei `template/score.ly`, in die in den Variablen `musicOne`, `chordsOne` und `verseOne` die Noten, optional Akkorde und optional Liedtexte eingefügt werden.

Die Lilypond-Dateien sollen auf einen Druck auf Din-A5-Format ausgelegt sein, wobei diese auch in schwachem Licht auch von älteren Menschen lesbar sein sollen.

Entgegen vieler Liederbücher sollen die Noten - sofern sinnvoll möglich - nicht zufällig umbrechen, sondern an geeigneten Stellen, um die Orientierung zu verbessern - auf Kosten von etwas Platz.

Das automatisch erstellte pdf-Liederbuch ist direkt druckreif. Die erzeugte LaTeX-Quelldatei können aber bei Bedarf nach dem Build manuell angepasst werden, sie bleiben gespeichert.

Alle Noten werden als Lilypond-code `\relative c'` verarbeitet, also relativ zur Oktave c', um die Eingabe einfach und verlässlich zu machen.

Die Lilypond-Dateien _müssen_ die Struktur von der Daten `template/score.ly` haben um mit dem LcServer bearbeitet werden zu können!

## LcServer

Die `LcServer.py` stellt einen Webserver zur Verfügung um die Lieder anzuzeigen oder zu editieren. Dieser ist auf Port 4210 auf dem localhost erreichbar.

_Für die Einrichtung für den Zugriff von "aussen" sind erweiterte IT-Kenntnisse notwendig - nur einrichten wenn die folgenden Zeilen wirklich verstanden werden!_

Soll dieser für _vertrauenswürdige, wenige Nutzer_ von aussen zugänglich gemacht werden ist ein Reverse-Proxy zu verwenden, z.B. nginx mit der config:

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

Es wird dringend empfohlen über den Reverse-Proxy sicher zu stellen, dass eine verschlüsselte Verbindung eingesetzt wird und ein Zugriff nur nach Anmeldung möglich ist.

Weiterhin ist es empfehlenswert ein WSGI-Server (wie z.B. Gunicorn oder Waitress) einzusetzen.

## Geplante Features

- ~das pdf hübscher machen~
- Index der Titel und der Liedanfänge
- ggf. (optionale) thematische Sortierung/Kapitel

- in progress: Zusatz-Information wie Autor, Erscheinungsjahr etc. in die `lyrics.yaml` aufnehmen. (könnte man schon rein schreiben, würde aktuell ignoriert)

- einzelnen Cantus als pdf zum Download anbieten
