\version "2.24.4"
\header {tagline=""}
\paper  {
myStaffSize = #20
#(define fonts (make-pango-font-tree 
    "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
    (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

musicOne = \relative f' {
  \key f \major
  \repeat volta 2 { f8 f8 g8 a4 a8 g8 a4 a8 g8 a4 a8 \break
    g8 a4 bes4 c4 d8 c8 c4. bes8 a2 } \break
  c2 c4. c8 s2 d4. 8 bes8 a8 bes8 d8 c2r8.  a4. c8 g2 \break
  a4. c8 g2 a4. bes8 c4 d8 c8 c4. bes8 a2. \bar "|."
}
verseOne = \lyricmode {
  Es ist für uns ei -- ne Zeit an -- ge -- kom -- men
  die bringt uns ei -- ne _ gro -- ße Freud
  Ü -- ber's Schnee be -- glä _ -- nzte  _ _ Feld
  wan -- dern wir, wan -- dern wir
  durch die wei -- te, _ wei -- ße Welt
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
