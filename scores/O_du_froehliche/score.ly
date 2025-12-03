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
  g2 a2 g4. f8 e4 f4 g2 a2 g4. f8 e4 f4 \break
g2 g2 a2 b4 c'4 b2 a2 g1 \break
d4. e8 d4 e4 f4. g8 f2 e4. f8 e4 f4 g4. a8 g2 \break
c'4 b4 a4 g4 c'4 a4 g4 f4 e2 d2 c1
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  O du fröh -- lich --e, _ O du se -- li -- ge, _
gna -- den -- brin -- gen -- de Weih -- nachts -- zeit!
We -- lt ging ver -- lo - ren, Chri -- st ward ge -- bo - ren:
Fre - ue, _ freu -- e dich, O Chris -- ten -- heit!
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
    \tempo 2=70
  }
}