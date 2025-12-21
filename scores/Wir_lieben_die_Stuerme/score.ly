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
  d8 d4 g8 a8 b4 a8 g8 a4 g8 fis8 g4 d8 d8 e4 g8 e8 d4 d4 c4 d8 c8 b,4 r8 \break
d8 d4 g8 a8 b4 a8 g8 a4 g8 fis8 g4 d8 d8 e4 g8 e8 d4 d8 d8 d4 g8 fis8 g4 r8 \break
\repeat volta 2 {d2 g2 b2 g4 d8 d8 g8 d8 g8 a8 b4 c'4 b4 a8 g8 a4 fis4 g2 r2} \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Wir lie -- ben die Stür -- me, die brau -- sen -- den Wo -- gen, der eis -- kal -- ten Win -- de rau -- es Ge -- sicht.
Wir sind schon der Mee -- re so vie -- le ge -- zo -- gen, und den -- no -- ch sank uns -- 're Fah -- -- ne _ nicht.
Hei -- jo, hei -- jo, hei -- jo hei -- jo hei -- jo -- ho, hei -- jo, hei -- jo -- ho, hei -- jo!
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