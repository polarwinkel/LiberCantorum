\version "2.24.4"
\header {tagline=""}
\paper  {
myStaffSize = #20
#(define fonts (make-pango-font-tree 
    "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
    (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

musicOne = \fixed c' {
  \key g \major
  
  \time 4/4
  d4 b,4 d4 g4. a8 g4 d4 b,4. d8 c'4 b4 a4 g4 a2. \break
d4 b,4 d4 a4. a8 g4 e4 b,4. g8 fis4 d4 b,4 cis4 d2. \break
d4 d4 fis4 a4 b4 a4. g8 g4 g4 g4. fis8 e4 fis4 g2. \break
g4 fis4. fis8 g4 fis4 fis4. e8 b,4 e4 dis4 e4 fis4. e8 b2.
s4 \repeat volta 2 { g8. a16 d2. g8. a16 d2. a8 b8 c'4 c'8 d'4 ais8 c'4. b8 b8 d'8 fis2 \break
b8 d'8 fis2 a8 a8 }
\alternative {{ g4 fis4 g4. a8 b2. }{ g4 fis4 e4 fis4 g2.}} \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Das war der Graf von Rü -- des -- heim, mit Gü -- tern reich be -- glückt,
  der hat des Win -- zers hol -- der Maid zu tief ins Aug' ge -- blickt.
  Doch als er ihr die Lieb' ge -- stand, lacht sie ihm ins Ge -- sicht;
  der Graf ritt tief ge -- kränkt nach Haus und mied des Ta -- ges Licht.
  Und er saß und ver -- gaß in _ sei -- ner Burg am Rhein -- e
  sei -- nen Schmerz, denn das Herz trö -- stet Rü -- des -- hei -- mer Wein.
  Rü -- des -- hei -- mer Wein.
}

\score {
  <<
    \new ChordNames {
      \chordsOne
    }
    \new Staff {
      \new Voice = "melody" {
        \musicOne
      }
    }
    \new Lyrics \lyricsto "melody" {
      \verseOne
    }
  >>
  \layout {
    indent = 0.0
  }
}
\score {
  \unfoldRepeats
  <<
    \new Staff {
      \new Voice = "melody" {
        \musicOne
      }
    }
    \new Lyrics \lyricsto "melody" {
      \verseOne
    }
  >>
  \midi {
    \tempo 2=68
  }
}