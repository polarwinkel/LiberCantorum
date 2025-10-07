\version "2.24.4"
\header {tagline=""}
\paper  {
myStaffSize = #20
#(define fonts (make-pango-font-tree 
    "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
    (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

musicOne = \relative a {
    \key d \minor
    c8 f4 f8 a8. g16 f8 g4 g8 bes8 a8 g8 d4 d8 f8. e16 d8 a'2 \break
    c8 c4 bes8 d,8. bes16 bes'8 bes4 a8 c,4 a'8 a4 g8 a4 bes8 c4 d8 c8 r8\break
    c8 c4 bes8 d,8. bes16 bes'8 bes4 a8 c,4 a'8 a4 g8 bes4 a8 f2 \bar "|."
}
verseOne = \lyricmode {
  Im Schwar -- zen Wal -- fisch zu As -- ka -- lon, _ da trank ein Mann _ drei Tag',
  bis dass er steif wie ein Be -- sen -- stiel am Mar -- mor -- ti -- sche lag, _ _
  bis dass er steif wie ein Be -- sen -- stiel am Mar -- mor -- ti -- sche lag.
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
