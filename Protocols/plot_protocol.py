#!/usr/bin/env python
import pandas as pd
import random
import matplotlib as mpl
import matplotlib.pyplot as plt
mpl.style.use( 'fivethirtyeight' )
mpl.rcParams['axes.linewidth'] = 0.2
mpl.rcParams['lines.linewidth'] = 1.0
mpl.rcParams['text.latex.preamble'] = [ r'\usepackage{siunitx}' ]
mpl.rcParams['text.usetex'] = True

def plot_protocols( df ):
    plt.figure(figsize=(6, 5)) #0.5*len(df)) )
    for ri, row in df.iterrows():
        b = 0
        print(row.keys())
        ax = plt.subplot( 5, 1, ri+1 )
        # pre
        preStimA = int(row['PreStimDuration-LOW'])
        preStimB = int(row['PreStimDuration-HIGH'])
        ax.set_title( row['CODE'], fontsize=8 )
        # PRE
        a, b = 0, random.uniform(preStimA, preStimB)
        ax.plot([a, b], [1,1], lw=1)
        a, b = b, b+int(row['CSDuration'])
        # TRACE
        ax.plot([a, b], [1,1], lw=7)
        a, b = b, b+int(row['TraceDuration'])
        ax.plot([a, b], [1,1], lw=1)
        # US
        a, b = b, b+int(row['USDuration'])
        ax.plot([a, b], [1,1], lw=5)
        ax.text(a, b, s=row['USValue'])
        # POST
        a, b = b, b+int(row['PostStimDuration'])
        ax.plot([a, b], [1,1], lw=1)
        ax.text(a, b, s=row['USValue'])
        ax.axis('off')
        if ri == 3:
            break

def main():
    df = pd.read_excel( './BehaviourProtocols.xlsx' )
    plt.figure()
    plot_protocols( df )
    plt.tight_layout()
    plt.savefig( 'protocols.png' )

if __name__ == '__main__':
    main()
