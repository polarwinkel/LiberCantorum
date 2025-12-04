#!/usr/bin/python3
#coding: utf-8
'''
LcServer
'''

import os, shutil
from flask import Flask, render_template, request, send_from_directory, redirect
import json
import yaml
from ruamel.yaml import YAML
from ruamel.yaml.scalarstring import LiteralScalarString
from jinja2 import Template
import re

# load settings:

settingsfile = 'LcServer.conf'

if not os.path.exists(settingsfile):
    with open(settingsfile, 'w') as file:
        file.write("host: 127.0.0.1\nport: '4210'\ndebug: false")

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
    # Suche "musicOne =" gefolgt von optionalem Space und evtl. Token (z.B. "\fixed c'")
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
                # (\key, \tempo und \time entfernen)
                s = text[start+1:i]
                m = re.search(r'^[ \t]*\\key.*$', s, flags=re.MULTILINE)
                key = m.group(0).strip().removeprefix(r'\key').strip() if m else ''
                s = re.sub(r'^[ \t]*\\key.*\n?', '', s, count=1, flags=re.MULTILINE)
                m = re.search(r'^[ \t]*\\tempo.*$', s, flags=re.MULTILINE)
                time = m.group(0).strip().removeprefix(r'\tempo').strip() if m else ''
                s = re.sub(r'^[ \t]*\\tempo.*\n?', '', s, count=1, flags=re.MULTILINE)
                m = re.search(r'^[ \t]*\\time.*$', s, flags=re.MULTILINE)
                time = m.group(0).strip().removeprefix(r'\time').strip() if m else ''
                music = re.sub(r'^[ \t]*\\time.*\n?', '', s, count=1, flags=re.MULTILINE)
                break
        i += 1
    # suche chords:
    m = re.search(r'chordsOne\s*=\s*(?:[^\{]*\{)', text)
    if not m:
        chords = ''
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
                    chords = text[start+1:i]
                    break
            i += 1
    # suche lyrics:
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
    m = re.search(r'^[ \t]*\\tempo .*$', text, flags=re.MULTILINE)
    tempo = m.group(0).strip().removeprefix(r'\tempo ').strip() if m else ''
    return {'key': key, 'time': time, 'music': music, 'chords': chords, 'verse': verse, 'tempo': tempo}

# WebServer stuff:

lcServer = Flask(__name__, template_folder='template')

# routes

@lcServer.route('/', methods=['GET'])
#@lcServer.route('/index.html', methods=['GET'])
def index():
    '''show canti-list'''
    cantus = request.args.get('cantus')
    if not cantus:
        out = '<span style="color: orange;"><i>Hinweis:</i> Der LcServer ist nur für den Gebrauch durch wenige, vertrauenswürdige Nutzer ausgelegt.</span><br>\n'
        out += '&#8594;<a href="?cantus=__new">neuen Cantus hinzufügen</a><br>\n'
        out += '&#8594;<a href="build">Liederbuch bauen</a><br>\n'
        out += '<ul>\n'
        for folder in sorted(os.listdir('scores/')):
            out += '<li><a href="?cantus='+folder+'">'+folder+'</a></li>\n'
        out += '</ul>\n'
    else:
        score = {'cantus': cantus, 'title': '', 'lyricsBy': '', 'musicBy': '', 'key': '', 'time': '', 'tempo': '2=60', 'music': '', 'chords': '', 'verse': '', 'strophes': ''}
        score['cd']=score['gd']=score['dm']=score['dd']=score['gm']=score['ad']=score['cm']=score['ed']=score['fm']=score['bd']=score['bm']=score['fd']=''
        if cantus != '__new':
            #get the cantus-data from the yaml-file:
            mus = extractScore('scores/'+cantus+'/score.ly')
            score['key'] = mus['key']
            score['time'] = mus['time']
            score['tempo'] = mus['tempo']
            score['music'] = mus['music'].strip()
            score['chords'] = mus['chords'].strip()
            score['verse'] = mus['verse'].strip()
            with open('scores/'+cantus+'/lyrics.yaml') as f:
                lyrics = yaml.safe_load(f)
            score['title'] = lyrics['title']
            if 'lyrics' in lyrics.keys():
                score['lyricsBy'] = lyrics['lyrics']
            if 'music' in lyrics.keys():
                score['musicBy'] = lyrics['music']
            score['strophes'] = lyrics['strophes'].strip()
            if score['key'].startswith(r'g \major'):
                score['gd']=' selected="selected"'
            elif score['key'].startswith(r'd \minor'):
                score['dm']=' selected="selected"'
            elif score['key'].startswith(r'd \major'):
                score['dd']=' selected="selected"'
            elif score['key'].startswith(r'g \minor'):
                score['gm']=' selected="selected"'
            elif score['key'].startswith(r'a \major'):
                score['ad']=' selected="selected"'
            elif score['key'].startswith(r'c \minor'):
                score['cm']=' selected="selected"'
            elif score['key'].startswith(r'e \major'):
                score['ed']=' selected="selected"'
            elif score['key'].startswith(r'f \minor'):
                score['fm']=' selected="selected"'
            elif score['key'].startswith(r'b \major'):
                score['bd']=' selected="selected"'
            elif score['key'].startswith(r'b \minor'):
                score['bm']=' selected="selected"'
            elif score['key'].startswith(r'fis \major'):
                score['fd']=' selected="selected"'
            else:
                score['cd']=' selected="selected"'
        out = '''
            <a href="{cantus}.html">anzeigen</a><br>
            <h1>Bearbeiten</h1>
            <h2>{cantus}</h2>
            <form action="./post" method="post">
            <input type="hidden" id="cantus" name="cantus" value="{cantus}"><br>
            <label for="cantusNew">Cantus:</label><input type="text" id="cantusNew" name="cantusNew" value="{cantus}" pattern="[a-zA-Z0-9_]+">technischer Pfad: <i><b>nur</b> Buchstaben, Ziffern oder Unterstriche!</i><br>
            <label for="title">Titel:</label><input type="text" id="title" name="title" value="{title}"><i>ausgeschriebener Titel</i><br>
            <label for="lyricsBy">Lyrics von:</label><input type="text" id="lyricsBy" name="lyricsBy" value="{lyricsBy}"><i>(optional; ggf. mit Jahr)</i><br>
            <label for="musicBy">Musik von:</label><input type="text" id="musicBy" name="musicBy" value="{musicBy}"><i>(optional; ggf. mit Jahr)</i><br>
            <label for="key">Tonart:</label><select id="key" name="key">
                <option value="c \major"{cd}>C Dur</option>
                <option value="g \major"{gd}>#: G Dur</option>
                <option value="d \minor"{dm}>b: d Moll</option>
                <option value="d \major"{dd}>##: D Dur</option>
                <option value="g \minor"{gm}>bb: g Moll</option>
                <option value="a \major"{ad}>###: A Dur</option>
                <option value="c \minor"{cm}>bbb: c Moll</option>
                <option value="e \major"{ed}>####: E Dur</option>
                <option value="f \minor"{fm}>bbbb: f Moll</option>
                <option value="b \major"{bd}>#####: B Dur ("H Dur")</option>
                <option value="b \minor"{bm}>bbbbb: b Moll</option>
                <option value="fis \major"{fd}>######/bbbbbb: Fis Dur</option>
            </select><br>
            <label for="tempo">Tempo:</label><input type="text" id="tempo" name="tempo" value='{tempo}'><i>Beispiel: </i><code>2=60</code> oder <code>"mäßig" 2=60</code><br>
            <label for="time">Takt:</label><input type="text" id="time" name="time" value="{time}"><i>Beispiel: </i><code>3/4</code><br>
            <h3>Score</h3>
            <details>
                <summary>Noten einblenden:</summary>
                <img class="svg" src="{cantus}.svg" alt="gespeicherte Noten">
            </details>
            <label for="music">Noten:</label>
            <textarea id="music" name="music">{music}</textarea><br>
            <details>
                <summary>Beispiel-Noten</summary>
                <code><pre>
%\\alternative&#123;&#123;e8 e8&#125;&#123;e4&#125;&#125;
\\repeat volta 2 &#123;e\'8 e8 a4 a4 | cis8 a8 e2 | e4 d4 b4 | e4 cis4 a4 &#125;\\break
a'4 gis4 b4. gis8 a4 cis4 a4 gis4 b4. gis8 a4 cis4 \\break
a4 fis4 fis4 a8 fis8 e2 e8 cis'8 cis8 b8 a4 gis4 a2 \\bar "|."
                </pre></code>
            </details>
            <label for="chords">Akkordsymbole:</label><br>
            <textarea id="chords" name="chords" style="height:70px;">{chords}</textarea><br>
            <details>
                <summary>Beispiel-Akkorde</summary>
                <code><pre>
a4 a1. e2.:7 a2. e2. a2. e2.:7 a2 a4:7 d2. a2. a2 e4:7 a2
                </pre></code>
            </details>
            <label for="verse">Vers:</label><br>
            <textarea id="verse" name="verse">{verse}</textarea><br>
            <details>
                <summary>Beispiel-Vers</summary>
                <code><pre>
<<
  &#123;Die Ge -- dan -- ken si -- nd frei, wer kann sie er -- ra -- ten,&#125;
  \\new Lyrics &#123;
    \\set associatedVoice = "melody"
    sie - flie -- hen vor - bei, wie nächt -- lich -- e Schat -- ten.
  &#125;
>>
Kein Mensch kann sie wis -- sen, kein Jä -- ger sie -- schie -- ßen.
Es blei -- bet da - bei: Die Ge -- da -- n -- ken sind frei.
                </pre></code>
            </details>
            <h3>Lyrics</h3>
            <label for="strophes">Strophen:</label>
            <textarea id="strophes" name="strophes" style="height:400px;">{strophes}</textarea><br>
            <details><summary>Löschen:</summary>
                <label for="delete" style="color:red;">löschen</label>
                <input type="text" id="delete" name="delete"><i>eintippen: </i><code>DELETE</code><br>
            </details>
            <input type="submit" value="speichern und bauen" onclick="send()">
            </form>
            <hr>
        '''.format(**score)
    return render_template('template.html', title='LcServer', lyrics=out)

# send static files:
@lcServer.route('/out/', methods=['GET'])
def sendOutIndex():
    '''pass through static index site'''
    return send_from_directory('out', 'index.html')
@lcServer.route('/out/<filename>', methods=['GET'])
def sendOut(filename):
    '''pass through static site'''
    return send_from_directory('out', filename)
@lcServer.route('/<path:filename>.html', methods=['GET'])
def sendHtml(filename):
    return send_from_directory('out', filename.lstrip('_')+'.html')
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
@lcServer.route('/<path:filename>.pdf', methods=['GET'])
def sendPdf(filename):
    return send_from_directory('book', filename+'.pdf')

# handle post:
@lcServer.route('/post', methods=['POST'])
def handle_post():
    cantus = request.form['cantus']
    if request.form['delete'] == 'DELETE':
        shutil.rmtree('scores/'+cantus)
        return redirect('./')
    if cantus == '__new':
        os.mkdir('scores/'+request.form['cantusNew'])
        cantus = request.form['cantusNew']
    elif request.form['cantusNew'] != cantus:
        os.rename('scores/'+cantus, 'scores/'+request.form['cantusNew'])
        cantus = request.form['cantusNew']
    mus = {'key': request.form['key'],
            'time': request.form['time'],
            'tempo': request.form['tempo'],
            'music': request.form['music'].strip(),
            'chords': request.form['chords'].strip(),
            'verse': request.form['verse'].strip()}
    if mus['time'] == '':
        mus['time'] = '4/4'
    if mus['tempo'] == '':
        mus['tempo'] = '2=60'
    score = render_template('score.ly',
            key=mus['key'], time=mus['time'], tempo=mus['tempo'],
            music=mus['music'], chords=mus['chords'], verse=mus['verse'])
    with open('scores/'+cantus+'/score.ly', 'w') as scfile:
        scfile.write(score)
    
    lyrics = {'title': request.form['title'],
            'lyrics': request.form['lyricsBy'],
            'music': request.form['musicBy'],
            'strophes': LiteralScalarString(request.form['strophes'].strip())}
    yaml = YAML()
    with open('scores/'+cantus+'/lyrics.yaml', 'w', encoding='utf-8') as f:
        yaml.dump(lyrics, f)
    
    os.system('python3 buildSite.py -f -c '+cantus)
    return redirect(cantus+'.html')

# build book:
@lcServer.route('/build', methods=['GET'])
def build():
    '''show canti-list'''
    canti = []
    if os.path.isfile('canti.yaml'):
        with open('canti.yaml', 'r') as f:
            canti = yaml.safe_load(f)
    folders = sorted(os.listdir('scores/'))
    out = '<h2>Liederbuch neu bauen</h2>\n'
    out += '<p>Je nach Server und Liederanzahl dauert das eine Weile!</p>\n'
    out += '<form action="./build" method="post">\n'
    out += '<label for="option">Welche Lieder sollen verwendet werden?</label><br style="clear:both;">\n'
    out += '<input type="radio" name="options" id="public" value="public">Alle ohne Private<br>'
    out += '<input type="radio" name="options" id="all "value="all">Alle mit Privaten<br>'
    out += '<input type="radio" name="options" id="list" value="list">Entsprechend der Canti-Liste<br>'
    out += '<label for="canti">Canti-Liste:</label><br>\n'
    out += '<textarea id="canti" name="canti" style="max-width:400px; height:500px;">'
    for cantus in canti:
        out += '- '+cantus+'\n'
    out += '</textarea>\n'
    out += '<textarea id="all" name="all" style="max-width:400px; height:500px; color:#888;" disabled>'
    out += '(Liste aller Canti: Copy-and-Paste!\n'
    for folder in folders:
        out += '- '+folder+'\n'
    out += '</textarea><br style="clear:both;">\n'
    out += '<input type="submit" value="bauen" onclick="send()">'
    out += '<p><i>(Ggf. muss das pdf zweimal gebaut werden bis das Inhaltsverzeichnis stimmt!)</i></p>\n'
    out += '</form>'
    out += '<hr>\n'
    out += '<p>Private Canti beginnen mit einem <code>_</code> und werden nur <i>verlinkt</i> wenn oben ausgewählt.</p>\n'
    out += '<ul>\n'
    for folder in folders:
        out += '<li><a href="?cantus='+folder+'">'+folder+'</a></li>\n'
    out += '</ul>\n'
    return render_template('template.html', title='LcServer', lyrics=out)
@lcServer.route('/build', methods=['POST'])
def build_post():
    opt = request.form.get('options')
    print(opt)
    if opt == 'private':
        os.system('python3 buildSite.py -s private')
    elif opt == 'list':
        canti = request.form.get('canti')
        with open("canti.yaml", "w") as f:
            f.write(canti)
        os.system('python3 buildSite.py -s canti.yaml')
    else:
        os.system('python3 buildSite.py')
    return redirect('index.html')

# run it:

if __name__ == "__main__":
    lcServer.run(host=host, debug=debug, port=port)
