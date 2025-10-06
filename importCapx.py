#!/usr/bin/env python3

import argparse
import os
import subprocess
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(
        description="Importiert CapX-Dateien in scores/ Struktur"
    )
    parser.add_argument("capx_file", help="Die zu importierende CapX-Datei")
    parser.add_argument("-t", "--title", help="Titel für das Stück")
    args = parser.parse_args()

    capx_file = Path(args.capx_file)

    # Titel bestimmen
    if args.title:
        title = args.title
    else:
        title = capx_file.stem

    # Zielverzeichnis erstellen
    target_dir = Path("import") / title
    target_dir.mkdir(parents=True, exist_ok=True)

    # Dateipfade
    musicxml_file = f"/tmp/{title}.musicxml"
    ly_file = target_dir / "score.ly"
    yaml_file = target_dir / "lyrics.yaml"

    # CapX zu MusicXML
    subprocess.run(
        f'musescore "{capx_file}" -o "{musicxml_file}"', shell=True, check=True
    )

    # MusicXML zu LilyPond
    subprocess.run(
        f'musicxml2ly -m "{musicxml_file}" -o "{ly_file}"', shell=True, check=True
    )

    # YAML erstellen (basierend auf buildSite.py Struktur)
    with open(yaml_file, "w") as f:
        f.write(f"title: {title}\n")
        f.write("strophes: |+\n")
        f.write("  # Hier Liedtext einfügen\n")

    # Aufräumen
    os.unlink(musicxml_file)

    print(f"Import erfolgreich: {target_dir}")


if __name__ == "__main__":
    main()
