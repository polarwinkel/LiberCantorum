\version "2.24.4"
\header {tagline=""}
\paper  {
myStaffSize = #20
#(define fonts (make-pango-font-tree 
    "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
    (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

musicOne = \relative {
  \key g \major % Tonart
  \time 3/4
  %\alternative{{e8 e8}{e4}}
  \repeat volta 2 { g'8. d16 d4 g4 |e8. e16 e2 | fis8 g8 a4 fis4 | g8 b8 g2 } \break
  fis8. g16 a4 a4 | b8 g8 a4 a4 | fis8. g16 a4 a4 | b8 g8 a4 a4 \break
  g8. fis16 e8 c'8 b8 a8 | b4 a4 g4 | g8. fis16 e8 c'8 b8 a8 | b4 a4 g4 \bar "|."
}
verseOne = \lyricmode {
  Gau -- de -- a -- mus i -- gi -- tur, ju -- ve -- nes dum su _ -- mus;
  post jo -- cun -- dam ju -- ven -- tu -- tem, post mo -- les -- tam se -- nec -- tu -- tem
  nos ha -- be - bi -- t hu -- - -- mus, nos ha -- be - bi -- t hu - mus. 
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
