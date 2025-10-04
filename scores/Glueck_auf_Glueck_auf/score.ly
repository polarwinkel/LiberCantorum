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
  \time 4/4
  g'2 fis4 a4 g2 r2 b2 a4 c4 b2 r4 \break
  g8 a8 b4 b4 b4 a8 b8 c4 a8. a16 a4 \break
  a8 b8 c4 e4 e4 d8 c8 d4 b8. b16 b4 \break
  a4 g2 a2 b4 e4 d4 c4 b2 a2 g2 %"|."
}
verseOne = \lyricmode {
  Glück auf, Glück auf! Der Stei -- ger kommt
  und er hat sein hel -- les _ Licht bei der Nacht,
  und er hat sein hel -- les _ Licht bei der Nacht
  schon an -- ge -- zü - nd, schon an -- ge -- zündt.
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
