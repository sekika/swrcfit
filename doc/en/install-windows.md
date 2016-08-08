# Install SWRC Fit on Windows

2 methods for installing SWRC Fit is explained here (1) using Bash on Windows 10 and (2) using Cygwin. You can also install Octave with [Windows installer](http://wiki.octave.org/http://wiki.octave.org/Octave_for_Microsoft_Windows#Installers_for_Microsoft_Windows).

## Bash on Windows 10

You need a 64-bit PC running a 64-bit version of Windows 10, updated to [Windows 10 anniversary update](https://blogs.windows.com/windowsexperience/2016/08/02/how-to-get-the-windows-10-anniversary-update/) released on August 2, 2016.

1. Enable Bash on Windows 10, by following this article: [How To Enable Bash on Windows 10 (In 5 Simple Steps)](http://www.omgubuntu.co.uk/2016/08/enable-bash-windows-10-anniversary-update)
2. Run Bash on Ubuntu on Windows. This terminal is where you proceed rest of the installation and running process.
3. Run `sudo apt-get install make octave-optim epstool transfig` in the terminal. Enter UNIX password that you set when prompted.
4. In the terminal, download the [latest release of swrcfit](https://github.com/sekika/swrcfit/releases) by `wget (URL of the latest source code of tar.gz)`. Then `tar xfvz (downloaded file)`, `cd (directory of the unpacked package)`, and `./configure; make install`. You can run this entire 4th steps by
 - `wget http://seki.webmasters.gr.jp/swrc/install.txt; sh install.txt`
 - When prompted "Enter you password", enter the UNIX password.

Check if swrcfit is properly installed with `swrcfit swrc.txt` in the
directory of the downloaded archive.

By running `swrcfit swrc.txt fig=1`, figure file of the graph is saved in the folder `C:\Users\<WindowsUserName>\AppData\Local\lxss\home\<UbuntuUserName>`.
This folder is invisible in the explorer. To make it visible,

1. Use the Ribbon’s View tab to get to the Options button, and select "Show hidden files and folders" in the list.
2. Also remove the checkbox from "Hide protected operating system files".

By running `swrcfit swrc.txt fig=1 showfig=1`, the graph is converted to ASCII characters and shown in the terminal.
To show the graph as a figure in a separate window, X server such as [Xming X Server for Windows](http://www.straightrunning.com/XmingNotes/) needs to be installed.

## Cygwin

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

----
[SWRC Fit user's manual](README.md)
