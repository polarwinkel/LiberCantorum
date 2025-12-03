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
  c4 f4. c8 a4 g4 f2 c4 f8 g8 a4 a4 bes4 a4 g2 r4 \break
g4 a4. g8 a4 | bes4 c'2 d'4 | bes4 a4 a4 g4 | g4 f2 r4 \break
g4 e8 f8 g4 a4 g4. e8 c4 c4 bes4. bes8 a4. a8 g2 r4 \break
g4 a4. g8 a4 bes4 c'2 d'4 bes4 a4 a4 g4 g4 f2 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  In al -- len gu -- ten Stun -- den, er _ -- höht von lieb und Wein, 
soll die -- ses Lied ver -- bun -- den von uns ge -- sun -- gen sein.
Uns hält der Gott zu -- sa _ -- men, der uns hier -- her ge -- bracht,
er -- neu -- ert uns -- re Flam -- men, er hat sie an -- ge -- facht.
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