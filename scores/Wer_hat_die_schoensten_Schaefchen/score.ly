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
  f4 c' c' bes bes a2 g4 c' c' f bes a g2 r4 \break
g4 bes bes a a d'2 c'4 bes a a g g f2 r4
}
verseOne = \lyricmode {
  Wer hat die schön -- sten Schäf -- chen? Die hat der gol -- d'ne Mond,
der hin -- ter un -- ser'n Bäu -- men am Him -- mel dro -- ben wohnt.
}

\score {
  <<
    \new Staff {
      \new Voice = "melody" {
        \relative {
          \musicOne
        }
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
        \relative {
          \musicOne
        }
      }
    }
    \new Lyrics \lyricsto "melody" {
      \verseOne
    }
  >>
  \midi {
    \tempo 2 = 60
  }
}