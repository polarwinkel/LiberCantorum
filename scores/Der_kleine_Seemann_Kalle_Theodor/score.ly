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
  \key g \major
  
  \time 4/4
  b,4 e4 e8 fis8 g4 g8 fis8 e4 e8 fis8 g4. fis8 \break
e4 e8 fis8 g8 g8 fis8 e8 fis4 b,4 b,4 r8 \break
b,8 fis4 fis8 g8 a4 a8 g8 fis4 fis8 g8 a4. \break
fis8 g4 g8 a8 b8 a8 g8 fis8 g4 e4 e4 r4 \break
b4 b4 b4 b8 b8 c'4 c'4 b4 a4 g4 g4 fis4 e4 fis4 b,4 b,2 \break
e4 g8 g8 fis4 a4 g4 b8 b8 a4 c'4 \break
b4 a8 g8 fis4 b,4 e2 r4 b,4 e2 r4 b,4 e2 \bar "|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Der jüng -- ste und bes -- te Ma -- tro -- se an Bord, _ das war der klei -- ne Kal -- le The -- o -- dor.
Die Mut -- ter die wein -- te geh bit -- te nicht fort! doch in rief die See, den Kal -- le The -- o -- dor.
Wenn der Strum in den Wan -- ten pfiff, dann schrief er laut A -- hoi, jo -- he!
Hat -- te kein Heim -- weh, denn sei -- ne Hei -- mat war jetzt die grau -- e See. A -- hoi, jo -- he!
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
    \tempo 2=64
  }
}