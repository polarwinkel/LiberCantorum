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
  
  \time 6/8
  g4 g8 g8. f16 e8 a4 a8 a4. a4 a8 c'8. b16 a8 a4 g8 g4. \break
g4 d8 d8 g8 b8 a4. g4. \break
f4 f8 f8. e16 d8 e4 g8 c'4. f4 f8 f8. e16 d8 e4 g8 c'4. \break
c'4 b8 d'8. c'16 a8 a4. g4. g4 g8 g8 a8 b8 d'4. c'4. \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Kei -- nen Trop -- fen im Be -- cher mehr und der Beu _ -- tel schlaff und leer,
lech -- zend Herz _ und Zun -- ge.
An -- ge -- tan _ hat's mir dein Wein, dei -- ner Aüg _ -- lein hel -- ler Schein,
Lin -- den -- wir -- tin, du jun -- ge, Lin -- den -- wir -- tin, du jun -- ge!
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