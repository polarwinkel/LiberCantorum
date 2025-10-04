#!/bin/python3

import yaml, jinja2, os, sys
from shutil import copyfile
import subprocess

rebuildLilypond = False # speed up, has been build manually likely; TODO: command-line option?
cleanupLilySvg = True # remove leaking garbage (homedir) in svg-file


def getCantus(folder):
    '''get the cantus-data from the yaml-file'''
    with open('scores/'+folder+'/lyrics.yaml') as f:
        lyrics = yaml.safe_load(f)
    return {'title': lyrics['title'], 'strophes': lyrics['strophes'], 'folder': folder}

def lilyCantus(cantus):
    '''create svg- and midi-file for the score.ly-file in a folder'''
    if not os.path.isfile('scores/'+cantus['folder']+'/score.svg') or rebuildLilypond:
        p = subprocess.Popen(['lilypond', '--svg', '-s', 'score.ly'], cwd='scores/'+cantus['folder'])
        p.wait()
    if cleanupLilySvg:
        # get rid of leaking garbage (homedir) in the Lilypond-created svg-file:
        p  = subprocess.Popen(['sed', '-E', '-i', 's/xlink:href="textedit:[^"]*"//g', 'score.svg'], 
                cwd='scores/'+cantus['folder'])
        p.wait()
    # crop:
    p  = subprocess.Popen(['inkscape', '-D', '-l', '-o', 'out/'+cantus['file']+'.svg',
            'scores/'+cantus['folder']+'/score.svg'], stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL) 
    p.wait()
    copyfile('scores/'+cantus['folder']+'/score.midi', 'out/'+cantus['file']+'.midi')

def renderCantus(cantus):
    '''renders a page to html'''
    with open('template/template.html', 'r') as f:
        tpl = f.read()
    template = jinja2.Template(tpl)
    lyr = str(cantus['strophes']).replace('\n', '<br>\n')
    lyr.replace('<br>\n<br>\n', '</p>\n<p class="lyrics">')
    out = template.render(title=cantus['title'],score=cantus['file']+'.svg',
            lyrics=lyr, file=cantus['file'])
    with open('out/'+cantus['file']+'.html', 'w') as f:
        f.write(out)

def renderIndex(canti):
    '''render the indes-page listing all canti'''
    out = '<ul>\n'
    for c in canti:
        out += '<li>'
        out += '<a href="'+c['file']+'.html">'+c['title']+'</a>'
        out += '</li>\n'
    out += '</ul>\n'
    out += '<br>\n'
    out += '<a href="LiberCantorum.pdf">Download pdf</a>\n'
    with open('template/template.html', 'r') as f:
        tpl = f.read()
    template = jinja2.Template(tpl)
    out = template.render(title='LiberCantorum', lyrics=out)
    with open('out/index.html', 'w') as f:
        f.write(out)

def renderBook(canti):
    '''render a LaTeX-Book and compile it to pdf in out-folder'''
    if not os.path.exists('book'):
        os.makedirs('book')
    out = ''
    for c in canti:
        #out += '\\newpage\n'
        out += '\\section{'+c['title']+'}\n'
        p  = subprocess.Popen(['rsvg-convert', '-f', 'pdf', '-o',
                'book/'+c['file']+'.pdf', 'out/'+c['file']+'.svg']) 
        p.wait()
        out += '\\includegraphics[width=10.5cm]{'+c['file']+'.pdf}\\\\\n'
        out += c['strophes'].replace('\n', '\\\\ \n')
    with open('template/template.tex', 'r') as f:
        tpl = f.read()
    template = jinja2.Template(tpl)
    texout = template.render(contents=out)
    with open('book/LiberCantorum.tex', 'w') as f:
        f.write(texout)
    p = subprocess.Popen(['pdflatex', '-interaction', 'batchmode', 'LiberCantorum.tex'],
            cwd='book/', stderr=subprocess.DEVNULL, stdout=subprocess.DEVNULL)
    p.wait()

def getCantiList() -> list:
    '''read canti from canti.yaml or, if not exists, from scores-folder'''
    canti = []
    if os.path.isfile('canti.yaml'):
        with open('canti.yaml', 'r') as f:
            folders = yaml.safe_load(f)
            for f in folders:
                file = f.removeprefix('_')
                canti.append({'folder': f, 'file': file})
    else:
        for folder in os.listdir('scores/'):
            # first get private canti with _-prefix (prio 1, ignored in git):
            if folder.startswith('_'):
                canti.append({'folder': folder, 'file': folder.removeprefix('_')})
        for folder in os.listdir('scores/'):
            # add canti not found in private ones:
            if not folder.startswith('_'):
                for c in canti:
                    if folder == c['file']:
                        continue
                canti.append({'folder': folder, 'file': folder})
    return canti

def run():
    '''render the entire website'''
    # copy the template files:
    if not os.path.exists('out'):
        os.makedirs('out')
    for fi in os.listdir('template/'):
        if fi != 'template.html' and fi != 'template.tex':
            copyfile('template/'+fi, 'out/'+fi)
    canti = getCantiList()
    # create pages and copy stuff:
    for c in canti:
        cant = getCantus(c['folder']) # TODO: error-handling
        c['title'] = cant['title']
        c['strophes'] = cant['strophes']
        # uncomment to speed up for testing:
        sys.stdout.write('building: '+c['folder']+'...\n')
        lilyCantus(c)
        renderCantus(c)
    sys.stdout.write('done with canti, creating index and book...\n')
    renderIndex(canti)
    renderBook(canti)
    copyfile('book/LiberCantorum.pdf', 'out/LiberCantorum.pdf')
    sys.stdout.write('all done!\n')

run()
