# TODO:
# tool soll so funktionieren:
# ./importCapx.py -t example-title blah.capx
# die capx datei wird importiert und in die scores/ dateistruktur importiert, d.h. eine .yaml und ein .ly
# datei werden unter scores/example-title/score.ly und scores/example-title/score.yaml angelegt
# wenn -t nicht angegeben wird, wird der Titel aus dem Dateinamen extrahiert
#
# Funktionsweise:
# konvertiert von capx zu musicxml mittels
# musescore blah.capx -o blah.musicxml
# dann von musicxml zu lilypond mittels
# musicxml2ly -m blah.musicxml -o blah.ly
