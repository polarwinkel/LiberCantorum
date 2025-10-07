\version "2.24.4"
\header {tagline=""}
\paper  {
myStaffSize = #20
#(define fonts (make-pango-font-tree 
    "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
    (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

musicOne = \relative d' {
    \time 4/4
    \key d \major
    d4. a8 d4 fis4 fis4. fis8 e4 d4 cis8 d8 e8 fis8 g4 fis4 d4 a4 a'2 d,4. a8 d4 fis4 fis4. e8 e4 d4 % 7
    b8 cis8 d8 e8 fis4 g4 a4 a,4 d2 fis4. fis8 b8 fis8 d8 b8 fis'4 r4 r2 fis4. fis8 b8 fis8
    d8 b8 fis'4 r4 r2 d4 d4 g4 g4 e4  e4 a2 d4. a8 fis4 d4 fis8 e8 e8 d8  d2 \bar "|."
}
verseOne = \lyricmode {
  Wü -- tend wälzt sich einst im Bet -- te Kur _ -- fürst _ Fried -- rich von der Pfalz,
  ge -- gen al -- le E -- ti -- ket -- te brüll _ te _ er aus vol -- lem Hals:
  Wie kam ge -- stern ich ins Nest? Bin scheint's wie -- der voll ge -- west!
  Wie kam ge -- stern ich ins Nest? Bin scheint's wie -- der voll _ ge _ -- west!
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
    \tempo 2 = 68
  }
}
