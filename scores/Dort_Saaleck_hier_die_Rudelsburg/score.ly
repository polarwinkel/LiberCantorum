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
  e4 e8. cis16 cis4. e8 a8. e16 e4. e8 e8. d16 d4 cis4 cis4 b,4 r8 \break
b,8 cis8. a,16 a,4. cis8 a8. fis16 fis4. fis8 e8. dis16 gis4. fis8 fis4 e4 r8 \break
e8 a8. e16 e4. a8 a8. fis16 fis4. fis8 d'4. cis'8 b8 a8 a4 gis4 r4 \break
e8 cis'8. a16 a4. a8 gis8. fis16 b4. b8 a8. gis16 cis'4. b8 b4 cis'4 r8 \break
e8 cis'8. a16 a4. a8 gis8. fis16 b4. a8 gis8. e16 cis'4. b8 b4 a4 \bar"|."
}
chordsOne = \chordmode {
  
}
verseOne = \lyricmode {
  Dort Saal -- eck, hier die Ru -- dels -- burg, und un -- ten tief im Ta -- le
da rau -- schet zwi -- schen Fel -- sen durch die al -- te lie -- be Saa -- le;
und Ber -- ge hier und Ber -- ge dort zur Rech -- ten und zur Lin -- ken.
Die Ru -- dels -- burg, das ist ein Ort zum Schwär -- men und zum Trin -- ken.
Die Ru -- dels -- burg, das ist ein Ort zum Schwär -- men und zum Trin -- ken.
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
    \tempo 2=60
  }
}