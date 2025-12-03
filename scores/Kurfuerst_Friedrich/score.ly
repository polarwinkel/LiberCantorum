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
  \key d \major
  
  \time 4/4
  d4. a,8 d4 fis4 fis4. fis8 e4 d4 cis8 d8 e8 fis8 g4 fis4 d4 a,4 a2 \break
d4. a,8 d4 fis4 fis4. e8 e4 d4 b,8 cis8 d8 e8 fis4 g4 a4 a4 d'2 \break
fis4. fis8 b8 fis8 d8 b,8 fis2 r2 fis4. fis8 b8 fis8 d8 b,8 fis2 r2 \break
d4 d4 g4 g4 e4 e4 a2 d'4. a8 fis4 d4 fis8 e8 e8 d8 d2 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Wü -- tend wälzt sich einst im Bet -- te Kur _ -- fürst _ Fried -- rich von der Pfalz,
ge -- gen al -- le E -- ti -- ket -- te brüll _ te _ er aus vol -- lem Hals:
Wie kam ge -- stern ich ins Nest? Bin scheint's wie -- der voll ge -- west!
Wie kam ge -- stern ich ins Nest? Bin scheint's wie -- der voll _ ge _ -- west!
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