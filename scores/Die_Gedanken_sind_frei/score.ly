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
  \key a \major
  
  \time 3/4
  %\alternative{{e8 e8}{e4}}
\repeat volta 2 {e8 e8 a4 a4 | cis'8 a8 e2 | e4 d4 b,4 | e4 cis4 a,4 }\break
a4 gis4 b4. gis8 a4 cis'4 a4 gis4 b4. gis8 a4 cis'4 \break
a4 fis4 fis4 a8 fis8 e2 e8 cis'8 cis'8 b8 a4 gis4 a2 \bar "|."
}
chordsOne = \chordmode {
  s4 a1. e2.:7 a2. e2. a2. e2.:7 a2 a4:7 d2. a2. a2 e4:7 a2
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