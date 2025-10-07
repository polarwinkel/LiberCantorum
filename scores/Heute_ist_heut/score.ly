\version "2.24.4"
\header {tagline=""}
\paper  {
myStaffSize = #20
#(define fonts (make-pango-font-tree 
    "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
    (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

musicOne = \relative c' {
  \time 3/8
  \key f \major
  c8 f8 d8 c8. a16 c8 c8 f8 d8 c8. a16 c8 f8 e8 d8 c4. \break
  d8 cis8 d8 e8. a,16 a8 f'8 e8 f8 g8. c,16 c8 \break
  \repeat volta 2 {a'8 g8 f8 d8. f16 bes8 a8 bes8 g8 \alternative{{c4.}{f4}}} r8 \bar "|."
}
verseOne = \lyricmode {
  Was die Welt mor -- gen bringt, ob sie mir Sor -- gen bringt, Leid o -- der Freud?
  Kom -- me, was kom -- men mag. Son -- nen -- schein, Wet -- ter -- schlag,
  mor -- gen ist auch ein Tag, heu -- te ist \alternative{{heut!}{heut.}}
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
