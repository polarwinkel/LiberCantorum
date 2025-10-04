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
  %\time 3/4
  %\alternative{{e8 e8}{e4}}
  \repeat volta 2 { d'8 d4 b8 c8 d4 e8 fis8 g4 fis8 e8 d4 r8 \break
                    d8 fis4 e8 fis8 g4 fis8 e8 d4 cis4 d4 r8 }\break
  \repeat volta 2 { d8 a'4 a8 g8 fis4 fis8 e8 d4 d8 c8 b4 r8 } \break
  d8 d4 e8 fis8 g4 fis8 g8 a4 g8 a8 b4 r4 \break
  b8 b4 a8 b8 c4 b8 a8 g4 a4 b4 r8 b8 b4 a8 b8 d8 c8 b8 a8 g2 fis2 g2 \bar "|."
}
verseOne = \lyricmode {
  <<
    {Hier sind wir ver -- sam -- melt zu löb -- lich -- em Tun, drum Brü -- der -- chen, Er -- go bi -- ba _ -- mus.}
    \new Lyrics {
      \set associatedVoice = "melody"
      Die Glä -- ser sie klin -- gen, Ge -- sprä -- che sie ruhn; be -- her -- zi -- gt: Er -- go bi -- ba _ -- mus.
    }
  >>
  <<
    {Das heißt noch ein al -- tes, ein tüch -- ti -- ges Wort,}
    \new Lyrics {
      \set associatedVoice = "melody"
      und pas -- set zum ers -- ten und pas -- set so -- fort,
    }
  >>
  und schal -- let, ein Ech -- o, vom fest -- lich -- en Ort,
  ein herr -- lich -- es Er -- go bi -- ba _ -- mus. Ein herr -- lich -- es Er _ -- go bi -- ba _ -- mus. 
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
