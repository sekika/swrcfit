# Gnuplot によるグラフの描画

[SWRC Fit](https://github.com/sekika/swrcfit/) ではバージョン2.0から gnuplot によるグラフ描画をサポートしている。そのためには、システムに gnuplot が適切にインストールされている必要がある。

## gnuplot が適切にインストールされていることの確認

Octave を起動して、Octave のプロンプトで
```
plot(sqrt(0:100))
```
と実行して、 y=x^(1/2) のグラフが x=0 から 100 まで描かれることを確認する。描画されれば適切にインストールされているので、swrcfit のグラフ描画機能を利用できる。それができない時には、いくつかの可能性がある。

1. Gnuplot がシステムにインストールされていない
2. Octave が gnuplot を使うようにインストールされていない
3. X サーバーが適切にインストールされていない
4. 環境変数が適切な端末を使うように設定されていない

たとえば、Octave を Mac の Homebrew でインストールすると、環境変数 GNUTERM を設定する必要がある。

画面で直接 Gnuplot のグラフを確認できなくても、画像ファイルを作成できる可能性はある。

使っている OS 上でグラフの描画がうまくいかなかったとしても、[VirtualBox](https://www.virtualbox.org/)や[VMware](http://www.vmware.com/)などの[仮想化](https://ja.wikipedia.org/wiki/%E4%BB%AE%E6%83%B3%E5%8C%96)ソフトを使い、Linux の仮想環境をインストールして、その仮想環境上に swrcfit をインストールすれば、グラフ描画機能を使うことができる。

## グラフのオプション
グラフのオプションは[設定ファイル](setting.md)に書くか、コマンドラインオプションで指定する。このセクションでは、グラフ描画のためのパラメータをデフォルトの値とともに記す。

```
fig=0; # fig=0; no figure. fig=1; output figure on terminal and/or file
```
まずは、パラメータ fig を fig=1 とすることで、グラフを描画するモードに切り替える。

```
showfig=0; # showfig=1; show figure on terminal. showfig=0; otherwise.
```
showfig=1 が設定されている時には、グラフは端末に直接表示される。Gnuplot による描画ができるように端末が適切に設定されている必要がある。このオプションが設定されている時には、グラフを表示してから "Hit return key to finish." のメッセージを表示して停止する。そこで Return キーを押すことで、グラフは消えて swrcfit も終了する。

```
figure="swrc.png"; # Filename of the figure.
figure2="bimodal.png"; # Filename of the figure of bimodal models. (only for version 2.0 and 2.1)
```
図のファイルを保存するファイル名を指定する。バージョン3.0からは、すべてのモデルを figure パラメータに指定したファイルに表示する。バージョン2.0と2.1では、二峰性モデルに別のファイル名を指定する。ファイルへの書き込みを抑制するためには、`figure=""` と `figure2=""` を指定する。画像ファイルの形式はファイル名の拡張子から自動的に判断される。Octave は png, jpg, ps, eps, emf, pdf, svg そしていくつかの他のファイル形式に対応している ([-ddevice option of print function](http://www.gnu.org/software/octave/doc/interpreter/Printing-and-Saving-Plots.html) が、いくつかの形式はシステムのインストール状況によって対応していないかもしれない。

**注意**: コマンドラインからファイル名を指定する時には、**引用符はバックスラッシュ`\` でエスケープ処理をする**必要がある。したがって、コマンドラインから `figure="swrc.eps"` と指定するためには、 `figure=\"swrc.eps\"` という式となる。

```
figsize=3; # Size of figure. figsize=1; 320x240, 2; 480x360, 3; 640x480
```
画像サイズを指定する。
```
smooth=300; # Smoothness of the fitted line
```
smooth=300 が指定されると、回帰曲線で 300 個の点が計算される。値を大きくすればより曲線は滑らかになり、値を小さくすればより計算が速くなる。
```
showgrid=0; # showgrid=1; show grid, showgrid=0; otherwise.
```
図にグリッドを表示することができる。

```
ax=0; # Type of x axis. ax=0; automatic, ax=1; normal, ax=2; log
```
X軸が通常の軸か対数軸かを指定する。デフォルトでは ax=0 が指定されていて、swrcfit は自動的に軸を設定する。
```
minx=0; maxx=0; # Range of X axis. Automatic for 0.
miny=0; maxy=0; # Range of Y axis. Automatic for 0.
```
デフォルトでは、x軸とy軸の範囲は自動的に設定される。範囲を変える時にはこれらの値を設定する。

ここからは、図のテキストに関する設定となる。
```
fontsize=16; # Font size
```
グラフ中の文字の大きさ（フォントサイズ）を指定する。
```
showlabel=0; # showlabel=1; show label. showlabel=0; otherwise.
xlab="Suction"; # X label
ylab="Volumetric water content"; # Y label
showlegend=1; # showlegend=1; show legend. showlegend=0; otherwise.
```
これらはx軸とy軸のラベルと凡例の表示を指定する。デフォルトではラベルは表示されない。
```
Mlab="Measured"; # legend for measured data
BClab="Brooks and Corey (1964)"; # legend for BC model
VGlab="van Genuchten (1980)"; # legend for VG model
LNlab="Kosugi (1996)"; # legend for LN model
FXlab="Fredlund and Xing (1994)"; # legend for FX model
DBlab="Durner (1994)"; # legend for DB model
BLlab="Seki (2007)"; # legend for BL model
```
凡例に表示するテキストを設定する。
```
Mpl="bo"; # Format arguments for measured plot.
msize=5; # Marker size for measured plot
mcol="b"; # Marker face color for measured plot
```
測定値のプロットに対する[フォーマット引数](https://www.gnu.org/software/octave/doc/interpreter/Two_002dDimensional-Plots.html)を指定する。

```
linewidth=1.5; # Line width of fitting curves
```
会期曲線の太さを指定する。

バージョン2では、回帰曲線のフォーマット形式はこのように指定され、

```
BCpl="k-"; VGpl="r-"; LNpl="b-"; # Format arguments for BC, VG, LN models
DBpl="r-"; BLpl="b-"; # Format arguments for DB, BL models
```

バージョン3からはこのように指定される。

```
col = "krbgmc"; # Line color is set in this order
```
すなわち、グラフの線の色が col 変数の順番に設定される。デフォルトでは "krbgmc" となっているので、
黒、赤、青、緑、マゼンダ、シアンの順番に線の色が指定される。

----
[SWRC Fit マニュアル](README.md)
