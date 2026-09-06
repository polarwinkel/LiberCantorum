\version "2.24.4"
\header { tagline = "" }
\paper {
  myStaffSize = #20
  #(define fonts (make-pango-font-tree
      "Latin Modern Roman" "Latin Modern Sans" "Latin Modern Mono"
      (/ myStaffSize 20)))
}
#(set-global-staff-size 25)

% Source: raw-scores/IMG_20260906_154241_693.jpg, page 220.
% No metronome mark in the source; quarter = 104 is editorial.
musicOne = \fixed c' {
  \key g \major
  \tempo "Kräftig und gehalten" 4 = 104
  \time 4/4
  \autoBeamOff
  \partial 8*3
  d8 e8. fis16 |
  g4. fis8 g8. a16 b8. c'16 |
  d'2 r8 d'8 d'8. b16 | \break
  c'4. a8 b8. g16 e'8. c'16 |
  a8.([ b16]) a4 r8 d8 e8. fis16 |
  g4. fis8 \break g8. a16 b8. cis'16 |
  d'2 r8 a8 a8. a16 |
  fis'4 d'4 a8. a16 b8. cis'16 | \break
  e'4 d'4 r8 d'8\p e'8. d'16 |
  c'!4. a8 b8. g16 e'8. c'16 |
  a2 r8 d'8 e'8. d'16 | \break
  c'4. a8 b8. g16 d'8. b16 |
  a8.([ b16]) a4 r8
  \repeat volta 2 {
    d8\f b8. a16 | \break
    g8. d16 b8. a16 g8. b16 e'8. d'16 |
    d'8.([ c'16]) a4 r8 \break a8 c'8. b16 |
    % The printed dot after g16 ("und") overfills 4/4 by a 32nd; omitted here.
    b4. b8 a8. g16 a8. b16 |
    g2 r8
  }
}
chordsOne = \chordmode {
}
verseOne = \lyricmode {
  \set stanza = "1."
  Drei Klän -- ge sind's, sie tö -- nen hold und rein
  voll Har -- mo -- nie durch un -- ser Bur -- schen -- le -- ben,
  drei Klän -- ge sind's, die uns wie gold -- ner Wein
  zu fro -- hem Schlag das frei -- e Herz er -- he -- ben;
  sie will ich prei -- sen noch mit grau -- em Haar,
  bis mich der Tod ins Dun -- kel zieht her -- nie -- der:
  der Schlä -- ger Klang, der Glä -- ser Klang, den Klang der Lie -- der,
  sie will ich prei -- sen nun und im -- mer -- dar!
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
  \midi { \tempo 4 = 104 }
}
