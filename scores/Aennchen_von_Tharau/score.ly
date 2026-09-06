\version "2.24.4"
\header { tagline = "" }
\paper {
  myStaffSize = #20
  #(define fonts (make-pango-font-tree
      "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
      (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

% Source: raw-scores/IMG_20260906_152215_958.jpg, page 142.
% The source says "Mäßig" without a metronome mark; quarter = 96 is editorial.
% Keep full note lengths: the only breaks in the melody are the printed rests.
musicOne = \fixed c' {
  \key bes \major
  \tempo "Mäßig" 4 = 96
  \time 3/4
  \repeat volta 2 {
    f4. g8 f4 | f4 bes4 bes4 | c'4. d'8 c'4 | bes2 r4 | \break
    a4 a4 a4 | c'4. bes8 a4 | f4. g8 f4 | f2 r4 |
  }
  \break
  f4. f8 g4 | a4 f4 g4 | a4 a4 bes4 | c'2 r4 | \break
  bes4 c'4 d'4 | es'4. d'8 bes4 | bes4 c'4 a4 | bes2 r4 \bar "|."
}
chordsOne = \chordmode {
}
verseOne = \lyricmode {
  <<
    {
      \set stanza = "1."
      Änn -- chen von Tha -- rau ist's, die mir ge -- fällt,
      sie ist mein Le -- ben, mein Gut und mein Geld.
    }
    \new Lyrics {
      \set associatedVoice = "melody"
      Änn -- chen von Tha -- rau hat wie -- der ihr Herz
      auf mich ge -- rich -- tet in Lieb und in Schmerz.
    }
  >>
  Änn -- chen von Tha -- rau, mein Reich -- tum, mein Gut,
  du mei -- ne See -- le, mein Fleisch und mein Blut!
}

\score {
  <<
    \new ChordNames { \chordsOne }
    \new Staff {
      \new Voice = "melody" { \musicOne }
    }
    \new Lyrics \lyricsto "melody" { \verseOne }
  >>
  \layout { indent = 0.0 }
}
\score {
  \unfoldRepeats
  \new Staff {
    \set Staff.midiInstrument = "acoustic grand"
    \new Voice = "melody" { \musicOne }
  }
  \midi { \tempo 4 = 96 }
}
