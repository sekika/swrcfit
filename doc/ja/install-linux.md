# SWRC Fit の Linux と POSIX システムへのインストール

## Linux
使用している[パッケージ管理システム](http://ja.wikipedia.org/wiki/%E3%83%91%E3%83%83%E3%82%B1%E3%83%BC%E3%82%B8%E7%AE%A1%E7%90%86%E3%82%B7%E3%82%B9%E3%83%86%E3%83%A0)で、octave, octave-forge または octave-optim と gnuplot をインストールする。

|ディストリビューション |インストール方法|
|-------------|-------|
|Debian, Ubuntu その他 Debian から派生したもの| sudo aptitude install octave-optim epstool transfig|
|Fedora       | sudo dnf install octave-optim|
|Gentoo       | emerge --sync; emerge gnuplot; emerge octave; emerge octave-forge|

[swrcfit の最新バージョン](https://github.com/sekika/swrcfit/releases)をダウンロードし、アーカイブを展開して、次のコマンドを実行する。
```
./configure; sudo make install
```

SWRC Fit がインストールされたことを確認するためには、 `swrcfit swrc.txt` と実行する。

## POSIX システム
- [gnuplot](http://www.gnuplot.info/)と[octave](https://www.gnu.org/software/octave/)をインストールする。
- Octave を起動して `pkg install -forge struct optim` を実行する。
- [swrcfit の最新バージョン](https://github.com/sekika/swrcfit/releases)をダウンロードし、アーカイブを展開して、次のコマンドを実行する。
```
./configure; sudo make install
```

SWRC Fit がインストールされたことを確認するためには、 `swrcfit swrc.txt` と実行する。

----
[SWRC Fit マニュアル](README.md)
