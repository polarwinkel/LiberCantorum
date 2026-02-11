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
  \key c \major
  
  \time 4/4
  \repeat volta 2 { e8. c16 d4 r4 a,16 r4 r8 a,16 c8. c16 d4 d4 c4 e4 e4 a4 a4 c'4 c'4 a4 \break
e8. c16 d4 r4 a,16 r4 r8 a,16 c8. c16 d4 d4 c4 a,1 a,2. } \break
a4 a8. g16 e4 d8. c16 d4 d8. c16 d4 e4 c8. c16 es8. \break
e16. d4 c8 a,8 a,8 a,8 c4 a,8 a,8 a,4. \break
a,8 c4 d4 d4 c4 dis8 e4. c8 d8. c16 d8. c16 d8. c16 a,4 a,4 a4 a4 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Hit the Road, Jack, and don't you come back no more, no more, no more, no more,
Hit the Road, Jack, and don't you come back no more _
Woo wo -- man, oh wo -- man don't treat me so mean. You're the mean -- est old wo -- man that I've ev -- er seen. _
I guess if you said so _ _ I'd have to pack my things and go. That's right.
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
    \tempo 2=66
  }
}