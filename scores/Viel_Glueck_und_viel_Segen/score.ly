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
  \key c \major
  
  \time 4/4
  g4 c'4 b4 a8 b8 c'4 g4 g4 a4 g4 f4 e4 g4 \break
e4 f4 g4 a4 g4 e4 g4 f8 e8 d4 d4 c2
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Viel Glück und vi -- el Se -- gen auf all dei -- nen We -- gen,
Ge -- sund -- heit und Froh -- sinn sei au -- ch mit da -- bei.
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