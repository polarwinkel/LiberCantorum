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
  \key d \minor
  
  \time 4/4
  a,8 f4 e8. e16 d4 a,8 a,8 c4 bes,8. bes,16 a,4. \break
a,8 d4 d8 e8 f4 f8 g8 a2. \break
f8 g8 a4 a8. a16 d'4 c'8 a8 c'4 bes8. bes16 a4. \break
a8 a4 f8. f16 f4 e8 f8 g2. \break
f8 g8 a4 a8. a16 d'4 c'8 a8 c'4 bes8. bes16 a4. \break
a8 a4 f8. f16 f4 e8 e8 d2. \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Der Sang ist ver -- schol -- len, der Wein ist ver -- raucht, 
stumm irr' ich und träu -- mend um -- her.
Es _ tau -- meln die Häu -- ser vom Stur -- me um -- haucht,
es tau -- meln die Wel -- len ins Meer, 
es tau -- meln die Häu -- ser vom Stur -- me um -- haucht,
es tau -- meln die Wel -- len ins Meer.
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
    \tempo 2=54
  }
}