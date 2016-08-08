# SWRC Fit の Windows へのインストール

Bash on Ubuntu on Windows を使う方法（推奨）と、Cygwin を使う方法について説明する。他にも、[Octave for Windows](http://wiki.octave.org/Octave_for_Microsoft_Windows#Octave-4.0.3) を使う方法がある。

## Bash on Ubuntu on Windows を使う方法

2016年8月3日に配信が始まった Windows 10 の Anniversary Update から、Bash on Ubuntu on Windows のベータ版が利用できるようになった。これを使うと、簡単に SWRC Fit を利用できる。

1. [「Anniversary Update」で標準になった「Bash on Ubuntu on Windows」の使い道](http://itpro.nikkeibp.co.jp/atcl/watcher/14/334361/080400637/?rt=nocnt)
を参考に、Bash on Ubuntu on Windows を起動可能にする。
2. Bash on Ubuntu on Windows を起動する。この端末で、これからのインストール作業及び SWRC Fit の実行をする。
3. `sudo apt-get install make octave-optim epstool transfig` とする。設定した UNIX パスワードを入力する。
4. [SWRC Fit の最新リリース](https://github.com/sekika/swrcfit/releases)を、端末で `wget (tar.gz ファイルのURL)` としてダウンロードする。そして、 `tar xfvz (ダウンロードしたファイル)`、 `cd (展開したパッケージのディレクトリ)`、 `./configure; make install` でインストールができる。この4番目の手順を、一括して次のコマンドで実行出来る。
```
wget http://seki.webmasters.gr.jp/swrc/install.txt; sh install.txt
```
Enter your password で、設定した UNIX パスワードを入れる。

ダウンロードしたディレクトリで `swrcfit swrc.txt` とすることで、インストールが成功したかどうかをチェック出来る。

`swrcfit swrc.txt fig=1` とすると、グラフの画像ファイルが `C:¥ユーザー¥<WindowsUserName>¥AppData¥Local¥lxss¥home¥<UbuntuUserName>` フォルダに保存される。このフォルダはエクスプローラーでは見えないので、エクスプローラーでフォルダを開いて次の設定をする。

1. メニューの「表示」を選んで「隠しファイル」を表示
2. 「オプション」を選んで「表示」「保護されたオペレーティング・システムファイルを表示しない」をオフ

`swrcfit swrc.txt fig=1 showfig=1 ` とすると、画像ファイルがテキストに変換して端末に表示される。画像ファイルとして直接表示するためには、たとえば [Xming X Server for Windows](http://www.straightrunning.com/XmingNotes/) のような X Server をインストールする必要がある。

## Cygwin を使う方法

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
