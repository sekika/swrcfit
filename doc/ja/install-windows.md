## SWRC FIt の Windows へのインストール

1. [Cygwin](https://www.cygwin.com/) をインスールする。
2. Cygwin をインストール中に、[パッケージ選択](http://so-zou.jp/software/tech/tool/compatibility-layer/cygwin/introduction/install.htm#package-selection) の画面で、この表のパッケージをインストールする。

  |カテゴリー|パッケージ|
  |--------|-------|
  |Devel   |make   |
  |Graphics|epstool, gnuplot, pstoedit, transfig|
  |Math    |octave, octave-optim|
  |Web     |wget   |
3. Cygwin を起動する。[端末エミュレータ](http://ja.wikipedia.org/wiki/%E7%AB%AF%E6%9C%AB%E3%82%A8%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%BF)の [mintty](https://code.google.com/p/mintty/) が立ち上がる。この端末で、これからのインストール作業及び SWRC Fit の実行をする。
4. [SWRC Fit の最新リリース](https://github.com/sekika/swrcfit/releases)を、端末で `wget (tar.gz ファイルのURL)` としてダウンロードする。そして、 `tar xfvz (ダウンロードしたファイル)`、 `cd (展開したパッケージのディレクトリ)`、 `./configure; make install` でインストールができる。この4番目の手順を、一括して次のコマンドで実行出来る。
```
wget http://seki.webmasters.gr.jp/swrc/install.txt; sh install.txt
```

ダウンロードしたディレクトリで `swrcfit swrc.txt` とすることで、インストールが成功したかどうかをチェック出来る。

```
octave: X11 DISPLAY environment variable not set
octave: disabling GUI features
```

というメッセージが表示されるのは、グラフを表示できる環境にないということであり、グラフを表示する必要がないのであれば、気にしないで構わない。この状態ではグラフが表示されないが、[グラフを描く](graph.md)ためには、
[Cygwin/X をインストール](http://x.cygwin.com/docs/ug/setup.html)して、 `startx` あるいは `startxwin` を実行する。
