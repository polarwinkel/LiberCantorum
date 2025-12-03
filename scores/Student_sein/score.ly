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
  d4 b4 g4 e8. fis16 e8. e16 d4 b,4 r8 d8 e8 fis8 g4. g8 b4. a8 a2 r4 \break
a4 c'4. a8 fis8 fis8 e8 fis8 a4 g4 r8 g8 fis8 fis8 a4. fis8 fis4 g4 d2 r4 \break
d4 a4 fis4 d8 e8 fis8 g8 b4 g4 r8 g8 a8 b8 c'4. a8 b4. g8 b4 a4 r4 \break
d4 b4. a8 g8 fis8 a8. g16 fis4 e4 r8 c'8 b8 a8 g4. g8 a4. a8 b2 r4 \break
d4 b4. a8 g8 fis8 a8. g16 fis4 e4 r8 c'8 b8 a8 d'4. g8 b4 a4 g2 \bar "."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Stu -- dent sein, wenn die Veil -- chen blü -- hen, das er -- ste Lied die Ler -- che singt,
der Mai -- en -- son -- ne jun -- ges Glü -- hen trieb -- wek -- kend in die Er -- de dringt!
Stu -- dent sein, wenn die wei -- ßen Schlei -- er vom blau -- en Him -- mel grü -- ßend weh 'n:
das ist des Da -- seins schön -- ste Fei -- er! Herr lass sie nie zu En -- de geh'n!
Das ist des Da -- seins schön -- ste Fei -- er! Herr, lass sie nie zu En -- de geh'n!
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