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
  \key a \major % Tonart
  \time 3/4
  %\alternative{{e8 e8}{e4}}
  \repeat volta 2 {e'8 e8 a4 a4 | cis8 a8 e2 | e4 d4 b4 | e4 cis4 a4 }\break
  a'4 gis4 b4. gis8 a4 cis4 a4 gis4 b4. gis8 a4 cis4 \break
  a4 fis4 fis4 a8 fis8 e2 e8 cis'8 cis8 b8 a4 gis4 a2 \bar "|."
}
verseOne = \lyricmode {
  <<
    {Die Ge -- dan -- ken si -- nd frei, wer kann sie er -- ra -- ten,}
    \new Lyrics {
      \set associatedVoice = "melody"
      sie - flie -- hen vor - bei, wie nächt -- lich -- e Schat -- ten.
    }
  >>
  Kein Mensch kann sie wis -- sen, kein Jä -- ger sie -- schie -- ßen.
  Es blei -- bet da - bei: Die Ge -- da -- n -- ken sind frei.
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
