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
  \key d \minor
  
  \time 4/4
  f4 g f bes a g2 f4 a a a d' c' bes2 a4 a a a bes a g2 r4 \break
f4 g f bes a g2 f4 a a a d' c' bes2 a4 a a a bes a g g f2 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Der Mond ist auf -- ge -- gan -- gen, die gold' -- nen Stern -- lein pran -- gen
am Him -- mel hell und klar;
Der Wald steht still und schwei -- get und aus den Wie -- sen stei -- get
der wei -- ße Ne -- bel wun -- der -- bar.
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