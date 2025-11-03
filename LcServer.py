#!/usr/bin/python3
#coding: utf-8
'''
LcServer
'''

import os
from flask import Flask, render_template, request, send_from_directory, redirect
import json
import yaml
from ruamel.yaml import YAML
from ruamel.yaml.scalarstring import LiteralScalarString
from jinja2 import Template
import re

# load settings:

settingsfile = 'LcServer.conf'

with open(settingsfile, 'r') as settingsf:
    try:
        settings = yaml.safe_load(settingsf)
        host = settings['host']
        port = settings['port']
        debug = settings['debug']
    except:
        print('Error in settings-file '+settingsfile)
        exit

# helper

def extractScore(path):
    text = open(path, 'r', encoding='utf-8').read()
    # Suche "musicOne =" gefolgt von optionalem Space und evtl. Token (z.B. "\relative c")
    # dann die öffnende "{" und extrahiere den Inhalt bis zur passenden schließenden "}" (verschachtelt unterstützt)
    m = re.search(r'musicOne\s*=\s*(?:[^\{]*\{)', text)
    start = m.end() - 1  # Position der ersten "{"
    depth = 0
    i = start
    n = len(text)
    while i < n:
        ch = text[i]
        if ch == '{':
            depth += 1
        elif ch == '}':
            depth -= 1
            if depth == 0:
                # Inhalt zwischen erster "{" und zugehöriger "}" (ohne äußere Klammern)
                s = text[start+1:i]
                m = re.search(r'^[ \t]*\\key.*$', s, flags=re.MULTILINE)
                key = m.group(0).strip().removeprefix(r'\key').strip() if m else ''
                s = re.sub(r'^[ \t]*\\key.*\n?', '', s, count=1, flags=re.MULTILINE)
                m = re.search(r'^[ \t]*\\time.*$', s, flags=re.MULTILINE)
                time = m.group(0).strip().removeprefix(r'\time').strip() if m else ''
                music = re.sub(r'^[ \t]*\\time.*\n?', '', s, count=1, flags=re.MULTILINE)
                break
        i += 1
    m = re.search(r'verseOne\s*=\s*(?:[^\{]*\{)', text)
    if not m:
        verse = ''
    else:
        start = m.end() - 1
        depth = 0
        i = start
        n = len(text)
        while i < n:
            ch = text[i]
            if ch == '{':
                depth += 1
            elif ch == '}':
                depth -= 1
                if depth == 0:
                    verse = text[start+1:i]
                    break
            i += 1
    m = re.search(r'^[ \t]*\\tempo 2 =.*$', text, flags=re.MULTILINE)
    tempo = m.group(0).strip().removeprefix(r'\tempo 2 =').strip() if m else ''
    return {'key': key, 'time': time, 'music': music, 'verse': verse, 'tempo': tempo}

# WebServer stuff:

lcServer = Flask(__name__, template_folder='template')

# routes

@lcServer.route('/', methods=['GET'])
#@lcServer.route('/index.html', methods=['GET'])
def index():
    '''show canti-list'''
    cantus = request.args.get('cantus')
    if not cantus:
        out = '<span style="color: red;"><b>Achtung:</b> Der LcServer ist <u>nicht</u> sicher für den öffentlichen Gebrauch!</span>\n'
        out += '<ul>\n'
        for folder in os.listdir('scores/'):
            out += '<li><a href="?cantus='+folder+'">'+folder+'</a></li>\n'
        out += '</ul>\n'
    else:
        score = {'cantus': cantus, 'title': '', 'lyricsBy': '', 'musicBy': '', 'key': '', 'time': '', 'tempo': '60', 'music': '', 'verse': '', 'strophes': ''}
        if not cantus == '_new':
            #get the cantus-data from the yaml-file:
            mus = extractScore('scores/'+cantus+'/score.ly')
            score['key'] = mus['key']
            score['time'] = mus['time']
            score['tempo'] = mus['tempo']
            score['music'] = mus['music']
            score['verse'] = mus['verse']
            with open('scores/'+cantus+'/lyrics.yaml') as f:
                lyrics = yaml.safe_load(f)
            score['title'] = lyrics['title']
            if 'lyrics' in lyrics.keys():
                score['lyricsBy'] = lyrics['lyrics']
            if 'music' in lyrics.keys():
                score['musicBy'] = lyrics['music']
            score['strophes'] = lyrics['strophes']
        out = '''
            <a href="{cantus}.html">anzeigen</a><br>
            <h1>Bearbeiten</h1>
            <h2>{cantus}</h2>
            <form action="/post" method="post">
            <label for="cantus">Cantus:</label><input type="hidden" name="cantus" id="cantus" value="{cantus}"><br>
            <label for="title">Titel:</label><input type="text" id="title" name="title" value="{title}"><br>
            <label for="lyricsBy">Lyrics von:</label><input type="text" id="lyricsBy" name="lyricsBy" value="{lyricsBy}"><br>
            <label for="musicBy">Musik von:</label><input type="text" id="musicBy" name="musicBy" value="{musicBy}"><br>
            <label for="key">Tonart:</label><input type="text" id="key" name="key" value="{key}"><br>
            <label for="time">Takt:</label><input type="text" id="time" name="time" value="{time}"><br>
            <label for="tempo">Tempo:</label><input type="text" id="tempo" name="tempo" value="{tempo}"><br>
            <h3>Music</h3>
            <label for="music">Noten:</label>
            <textarea id="music" name="music">{music}</textarea><br>
            <details>
                <summary>Beispiel-Noten</summary>
                <code><pre>
  TODO
  a'4 gis4 b4. gis8 a4 cis4 a4 gis4 b4. gis8 a4 cis4 \\break
  a4 fis4 fis4 a8 fis8 e2 e8 cis'8 cis8 b8 a4 gis4 a2 \\bar "|."
                </pre></code>
            </details>
            <label for="verse">Vers:</label><br>
            <textarea id="verse" name="verse">{verse}</textarea><br>
            <details>
                <summary>Beispiel-Vers</summary>
                <code><pre>
  <<
  TODO
  >>
  Kein Mensch kann sie wis -- sen, kein Jä -- ger sie -- schie -- ßen.
  Es blei -- bet da - bei: Die Ge -- da -- n -- ken sind frei.
                </pre></code>
            </details>
            <h3>Lyrics</h3>
            <label for="strophes">Strophen:</label>
            <textarea id="strophes" name="strophes">{strophes}</textarea><br>
            <input type="submit" value="Speichern" onclick="send()">
            </form>
            <hr>
        '''.format(**score)
    return render_template('template.html', title='LcServer', lyrics=out)

# send static files:
@lcServer.route('/<path:filename>.html', methods=['GET'])
def sendHtml(filename):
    return send_from_directory('out', filename+'.html')
@lcServer.route('/<path:filename>.svg', methods=['GET'])
def sendSvg(filename):
    return send_from_directory('out', filename+'.svg')
@lcServer.route('/<path:filename>.midi', methods=['GET'])
def sendMidi(filename):
    return send_from_directory('out', filename+'.midi')
@lcServer.route('/<path:filename>.css', methods=['GET'])
def sendCss(filename):
    return send_from_directory('template', filename+'.css')
@lcServer.route('/<path:filename>.woff2', methods=['GET'])
def sendWoff2(filename):
    return send_from_directory('template', filename+'.woff2')

# handle post:
@lcServer.route('/post', methods=['POST'])
def handle_post():
    cantus = request.form['cantus']
    mus = {'key': request.form['key'],
            'time': request.form['time'],
            'tempo': request.form['tempo'],
            'music': request.form['music'],
            'verse': request.form['verse']}
    
    score = render_template('score.ly',
            key=mus['key'], time=mus['time'], tempo=mus['tempo'],
            music=mus['music'], verse=mus['verse'])
    with open('scores/'+cantus+'/score.ly', 'w') as scfile:
        scfile.write(score)
    
    lyrics = {'title': request.form['title'],
            'lyrics': request.form['lyricsBy'],
            'music': request.form['lyricsBy'],
            'strophes': LiteralScalarString(request.form['strophes'])}
    yaml = YAML()
    with open('scores/'+cantus+'/lyrics.yaml', 'w', encoding='utf-8') as f:
        yaml.dump(lyrics, f)
    
    os.system('python3 buildSite.py -f -c '+cantus)
    return  redirect(cantus+'.html')

# run it:

if __name__ == "__main__":
    lcServer.run(host=host, debug=debug, port=port)
