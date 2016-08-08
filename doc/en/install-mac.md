# Install SWRC Fit on Mac OS X

1. Read [requirement for homebrew](https://github.com/Homebrew/homebrew/blob/master/share/doc/homebrew/Installation.md#requirements) and install [Xcode](https://itunes.apple.com/us/app/xcode/id497799835).
2. Install [Homebrew](http://brew.sh/).
3. Check if Java is installed on your system by running this command in [terminal](https://en.wikipedia.org/wiki/Terminal_(OS_X)): `java -version`. If you get the message `java: command not found`, [download the latest version of Java](https://www.java.com/download/) and install it, because Octave requires Java.
4. Run this command in terminal:
 - `brew tap homebrew/science; brew install swrcfit`
 - For installing the developing version `brew tap homebrew/science; brew install --HEAD swrcfit`

When running swrcfit, if you get error message as `warning: 'leasqr' undefined near line ... column ...`, please run the following command from Terminal.

```
octave -q --eval "pkg install -forge struct optim"
```

After installation of swrcfit with homebrew, you can always upgrade to the latest version by `brew update; brew upgrade`.

For [drawing graph with gnuplot](graph.md), you must set the environment variable GNUTERM. You can choose from x11, qt and aqua. Set `GNUTERM=qt` for example.

----
[SWRC Fit user's manual](README.md)
