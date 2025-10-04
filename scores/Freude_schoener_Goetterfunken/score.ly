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
  \key c \major % Tonart
  \time 4/4
  %\alternative{{e8 e8}{e4}}
  e'4 e4 f4 g4 g4 f4 e4 d4 |c4 c4 d4 e4 e4. d8 d4 r4 \break
  e4 e4 f4 g4 g4 f4 e4 d4 | c4 c4 d4 e4 d4. c8 c4 r4 \break
  d4 d4 e4 c4 d4 e8 f8 e4 c4 | d4 e8 f8 e4 d4 | c4 d4 g,4 e'4 \break
  e4 e4 f4 g4 g4 f4 e4 d4 c4 c4 d4 e4 d4. c8 c4 % "|."
}
verseOne = \lyricmode {
 Freu -- de schö -- ner Göt -- ter -- fun -- ken Toch -- ter aus E -- ly -- si -- um,
 wir be -- tre -- ten feu -- er -- trun -- ken himm -- lisch -- e dein Hei -- lig -- tum!
 Dei -- ne Zau -- ber bin -- den _ wie -- der was die _ Mo -- de streng ge -- teilt
 Al _ -- le Men -- schen wer -- den Brü -- der wo dein sanf -- ter Flü -- gel weilt!
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
    \tempo 2 = 70
  }
}
