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
  d8. d16 e4 d4 g4 fis2 d8. d16 e4 d4 a4 g2 \break
d8. d16 d'4 b4 g8. g16 fis4 e4 c'8. c'16 b4 g4 a4 g2 r4 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Zum Ge -- burts -- tag viel Glück, zum Ge -- burts -- tag viel Glück,
zum Ge -- burts -- tag lie -- be _ _ zum Ge -- burts -- tag viel Glück!
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
    \tempo 2=60
  }
}