# Install SWRC Fit on Linux and other POSIX systems

## Linux
Install octave, octave-forge or octave-optim and gnuplot with
[package manager](http://en.wikipedia.org/wiki/Package_management_system)
that you are using.

|Distribution |Install|
|-------------|-------|
|[Debian](https://www.debian.org/), [Ubuntu](http://www.ubuntu.com/), [Mint](http://linuxmint.com/)| sudo apt-get install octave-optim epstool transfig　make|
|[Fedora](https://getfedora.org/)  | sudo dnf install octave-optim|

Download the [latest release of swrcfit](https://github.com/sekika/swrcfit/releases),
unpack the archive, and in the directory of the downloaded archive, run
```
./configure; sudo make install
```

Check if swrcfit is properly installed by `swrcfit swrc.txt` in the directory of the downloaded archive.

## POSIX systems

- Install [gnuplot](http://www.gnuplot.info/) and [octave](https://www.gnu.org/software/octave/).
- Invoke octave and run `pkg install -forge struct optim`.
- Download the [latest release of swrcfit](https://github.com/sekika/swrcfit/releases),
unpack the archive, and in the directory of the downloaded archive, run
 - `./configure; sudo make install`

Check if swrcfit is properly installed by `swrcfit swrc.txt` in the directory of the downloaded archive.

----
[SWRC Fit user's manual](README.md)
