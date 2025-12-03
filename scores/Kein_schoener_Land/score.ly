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
  
  \time 3/4
  d8 d8 d8 g4 b4 a8 g8 a4. d8 d8 d8 g4 b4 a8 g8 a4. \break
b8 g8 a8 b8 d'8 c'8 b8 a8 g8 a8 c'8 b8 a8 g8 a8 b4 r8 \break
b8 g8 a8 b8 d'8 c'8 b8 a8 g8 a8 c'8 b8 a8 g4 fis4 g4 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Kein schö -- ner Land in die -- ser Zeit, als hier das uns -- re weit und breit,
wo wir uns fin  _ -- den wohl un -- ter Lin _ -- den zur A -- bend -- zeit
wo wir uns fin _ -- den wohl un -- ter Lin _ -- den zur A -- bend -- zeit.
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
    \tempo 2=54
  }
}