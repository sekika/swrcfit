## Install SWRC Fit on Windows

(Note) There are also [other methods](http://wiki.octave.org/Octave_for_Microsoft_Windows) to install Octave for Windows. We might expect that SWRC Fit will work easier when bash on Windows is released. After the release, I will check and write here.

1. Install [cygwin](https://www.cygwin.com/)
2. While installing cygwin, [choose cygwin packages](https://cygwin.com/cygwin-ug-net/setup-net.html#setup-packages) in this table.

  |Category|Package|
  |--------|-------|
  |Devel   |make   |
  |Graphics|epstool, gnuplot, pstoedit, transfig|
  |Math    |octave, octave-optim|
  |Web     |wget   |
3. Run cygwin. [Terminal emulator](http://en.wikipedia.org/wiki/Terminal_emulator) of [mintty](https://code.google.com/p/mintty/) starts. This is where you proceed rest of the installation and running process.
4. In the terminal, download the [latest release of swrcfit](https://github.com/sekika/swrcfit/releases) by `wget (URL of the latest source code of tar.gz)`. Then `tar xfvz (downloaded file)`, `cd (directory of the unpacked package)`, and `./configure; make install`. You can run this entire 4th steps by
 - `wget http://seki.webmasters.gr.jp/swrc/install.txt; sh install.txt`

Check if swrcfit is properly installed with `swrcfit swrc.txt` in the
directory of the downloaded archive.

For [drawing graph with gnuplot](graph.md), you have to
[set up Cygwin/X](http://x.cygwin.com/docs/ug/setup.html) and run `startx` or
`startxwin`.
