# swrcfit (SWRC Fit) - 土壌水分特性曲線の回帰

SWRC Fit は、土壌水分特性曲線（水分保持曲線）をレーベンバーグ・マルカート法によって、
[6つの土壌水分特性モデル](model.md)
によって非線形回帰をするプログラムである。このソフトは、
[200以上の科学論文](http://scholar.google.com/scholar?oi=bibs&hl=en&cites=7295614925292719046)
で研究のために使われた。

* 文献: [doi:10.5194/hessd-4-407-2007](http://dx.doi.org/10.5194/hessd-4-407-2007)
* 作者: [関 勝寿](http://researchmap.jp/sekik/)
* ライセンス: GNU General Public License

## unsatfit への移行
GNU Octave バージョンの SWRC Fit の開発は終了し、 2022年1月4日に Python ライブラリの [unsatfit](https://sekika.github.io/unsatfit/) へと移行しました。unsatfit では水分特性関数だけではなく不飽和透水係数関数のフィッティングもします。[SWRC Fit のウェブインターフェイス](http://purl.org/net/swrc/)は unsatfit のライブラリを利用して水分特性関数のみをフィッティングするプログラムで、名前は SWRC Fit のままです。新しい SWRC Fit のソースコードは unsatfit とともに[公開されています](https://github.com/sekika/unsatfit/tree/main/swrcfit)。

GNU Octave バージョンの SWRC Fit のソースコードはこの GitHub で公開されていますが、開発とサポートは終了しています。

## 目次

- [インストールの方法](#インストールの方法)
- [プログラムの実行](#プログラムの実行)
- [データファイルの準備](#データファイルの準備)
- [設定](#設定)
- [グラフ](#グラフ)
- [ウェブインターフェース](#ウェブインターフェース)
- [引用](#引用)

## インストールの方法

- [Windows へのインストール](install-windows.md)
- [Mac OS X へのインストール](install-mac.md)
- [Linux と POSIX システムへのインストール](install-linux.md)

## プログラムの実行

[端末エミュレータ](http://ja.wikipedia.org/wiki/%E7%AB%AF%E6%9C%AB%E3%82%A8%E3%83%9F%E3%83%A5%E3%83%AC%E3%83%BC%E3%82%BF)から、次のコマンドを実行する。

```
swrcfit DataFile [setting]...
```

DataFile は[データファイル](#データファイルの準備)のファイル名で、
setting は[設定](#設定)である。
鉤括弧 [ ] は省略可能であることを示し、 ... は複数の設定を書けることを示している。

ソースパッケージに含まれている`swrc.txt` というファイル
([ダウンロード](https://raw.githubusercontent.com/sekika/swrcfit/master/swrc.txt))
のディレクトリで
`swrcfit swrc.txt` と実行することで、サンプルに含まれている
`result.txt` と同じ、以下のような結果が表示される。
式とパラメータについては
[ここ](https://github.com/sekika/swrcfit/wiki/SWRC-models)を参照のこと。
ここで、 q は &theta; のことである。

```
=== BC model ===
qs =  0.38316
qr =  0.047638
hb =  41.704
lambda =  7.0104
R2 =  0.99279
=== VG model ===
qs =  0.38671
qr =  0.055302
alpha =  0.021563
n =  15.913
R2 =  0.99247
=== LN model ===
qs =  0.38625
qr =  0.056346
hm =  46.631
sigma =  0.10818
R2 =  0.99167
=== FX model ===
qs =  0.38442
qr =  0.034417
a =  44.142
m =  1.1128
n =  24.028
R2 =  0.99414
```

## データファイルの準備

入力データ、すなわち土壌水分特性曲線は、1行目にサクション（負圧）の水頭、2行目に体積含水率の形式のテキストファイルとして準備する。
区切り記号にはスペースを使う。
サンプルのデータは、ソースパッケージの `swrc.txt` というファイル
([ダウンロード](https://raw.githubusercontent.com/sekika/swrcfit/master/swrc.txt))
に含まれている。たとえば、以下のようなデータである。

```
0 0.2628
20 0.237
30 0.223
40 0.211
50 0.2035
70 0.1855
100 0.169
200 0.151
430 0.1399
640 0.131
1050 0.1159
```

"#" で始まる行は無視されるので、コメントを記入することができる。
入力データの単位は自由で、計算結果の単位は入力データの単位に依存する。

3行目のデータが存在すると、それぞれの測定点に対する重みであると解釈される。
例えば、

```
0 0.2628 1
20 0.237 1
40 0.211 1
70 0.1855 1
100 0.169 1
1050 0.1159 3
```

このような入力データがあると、 0, 20, 40, 70, 100 のサクションに対しては 1、
1050 に対しては 3 の重み付けで、回帰をする。

## 設定

設定は、コマンドラインオプションから `パラメータ=値` の式で指定できる。
設定ファイルを用意して指定することも可能である。
コマンドラインオプションが `=` を含む時は式であると解釈され、
含まない時はファイル名であると解釈される。

いくつかの設定例を示す。

|設定              |意味|
|------------------|----------------|
|bc=0 ln=0         |BC と LN モデルを計算しない (VG と FX モデルを表示)|
|mode=2            |二峰性モデル (DB と BL モデル)|
|mode=3 bc=0 vg=0 ln=1 fx=0 db=0 bl=1 |LN と BL モデルを表示する|
|qsin=0.35 cqs=0   |&theta;<sub>s</sub>=0.35 を定数とする|
|qrin=0.03 cqr=0   |&theta;<sub>r</sub>=0.03 を定数とする|
|aic=1             |AIC (赤池情報量規準)を表示|

たとえば、このようなコマンドが実行されると、
```
swrcfit swrc.txt mode=3 bc=0 vg=0 ln=1 fx=0 db=0 bl=1 aic=1
```
`swrc.txt` のデータからLNとBLモデルの回帰がされ、AICを表示する。

[設定の詳細な説明](setting.md)を参照。

## グラフ

グラフ描画のためのインストールができれば、水分特性曲線を描くことができる。
オプションを指定する必要がある。
詳しくは[Gnuplot によるグラフの描画](graph.md)を参照。

グラフのサンプルを示す。

![Figure](https://raw.githubusercontent.com/sekika/swrcfit-cgi/master/img/sample1.png)

## ウェブインターフェース

SWRC Fit のウェブインターフェース (http://purl.org/net/swrc/index-ja.html)
は、perl 言語で書かれ、cgi プログラムとして動作する。

![Web interface](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/fig2.png)

[詳しい説明を読む](http://seki.webmasters.gr.jp/swrc/help-ja.html)。


## 引用

このソフトを使った研究を公表する時には、この文献を引用して下さい。

* Seki, K. (2007) SWRC fit - a nonlinear fitting program with a water
  retention curve for soils having unimodal and bimodal pore structure.
  Hydrol. Earth Syst. Sci. Discuss., 4: 407-437.
  [doi:10.5194/hessd-4-407-2007](http://dx.doi.org/10.5194/hessd-4-407-2007)

[BibTeX](http://www.hydrol-earth-syst-sci-discuss.net/4/407/2007/hessd-4-407-2007.bib)
と [EndNote](http://www.hydrol-earth-syst-sci-discuss.net/4/407/2007/hessd-4-407-2007.ris)
のファイルをダウンロードできます。

----
他の言語: [English](../en/README.md)
