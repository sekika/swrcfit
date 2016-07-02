# swrcfit (SWRC Fit) - 土壌水分特性曲線の回帰

SWRC Fit は、土壌水分特性曲線（水分保持曲線）をレーベンバーグ・マルカート法によって、
[6 つの土壌水分特性モデル](model.md)
によって非線形回帰をするプログラムである。このソフトは、
[50以上の科学論文](http://scholar.google.com/scholar?oi=bibs&hl=en&cites=7295614925292719046)
で研究のために使われた。

* 文献: [doi:10.5194/hessd-4-407-2007](http://dx.doi.org/10.5194/hessd-4-407-2007)
* ホームページ: http://swrcfit.sourceforge.net/jp/
* ウェブインターフェース: http://purl.org/net/swrc/index-ja.html
* 作者: [関 勝寿](http://researchmap.jp/sekik/)
* ライセンス: GNU General Public License

バージョン 2.0 からは、インスールされているバージョンを `swrcfit -v` によって確認できる。
バージョン 3.0 では、Fredlund and Xing (1994) モデルを追加。

このユーザーマニュアルは、ウェブで読むと読みやすい。
それぞれのバージョンのユーザーマニュアルは、ここから読むことができる。
https://github.com/sekika/swrcfit/wiki/User%27s-manual

## 目次

- [インストールの方法](#インストールの方法)
- [プログラムの実行](#プログラムの実行)
- [データファイルの準備](#データファイルの準備)
- [設定](#設定)
- [ウェブインターフェース](#ウェブインターフェース)
- [引用](#引用)
- [質問](#質問)

## インストールの方法

[SWRC Fit のインストール](https://github.com/sekika/swrcfit/wiki/SWRC-Fit-%E3%81%AE%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB)
に、インストールの方法が書かれている。

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
```

詳細表示モードが選択が選択されると ([設定](#設定)参照)
相関行列と標準偏差が表示される。
qsやqrが定数の時は、変数に対しての相関行列と標準偏差が表示される。

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
|mode=2            |二峰性モデル解析|
|qsin=0.35 cqs=0   |&theta;<sub>s</sub>=0.35 が定数|
|qrin=0.03 cqr=0   |&theta;<sub>r</sub>=0.03 が定数|
|adv=1             |相関行列と標準偏差を表示する詳細表示モード|
|fig=1             |グラフをファイルに保存 |

たとえば、このようなコマンドが実行されると、
```
swrcfit swrc.txt mode=2 fig=1
```
`swrc.txt` のデータから二峰性モデルによる回帰がされて、
そのグラフが `bimodal.png` というファイル（二峰性モデルのデフォルトファイル名）に保存される。

[設定の詳細な説明](https://github.com/sekika/swrcfit/wiki/Setting-file)を参照。

## ウェブインターフェース

SWRC Fit のウェブインターフェース (http://purl.org/net/swrc/index-ja.html)
は、perl 言語で書かれ、cgi プログラムとして動作する。
[詳しい説明を読む](https://github.com/sekika/swrcfit/wiki/SWRC-Fit-%E3%82%A6%E3%82%A7%E3%83%96%E7%89%88)。


## 引用

このソフトを使った研究を公表する時には、この文献を引用して下さい。

* Seki, K. (2007) SWRC fit - a nonlinear fitting program with a water
  retention curve for soils having unimodal and bimodal pore structure.
  Hydrol. Earth Syst. Sci. Discuss., 4: 407-437.
  [doi:10.5194/hessd-4-407-2007](http://dx.doi.org/10.5194/hessd-4-407-2007)

[BibTeX](http://www.hydrol-earth-syst-sci-discuss.net/4/407/2007/hessd-4-407-2007.bib)
と [EndNote](http://www.hydrol-earth-syst-sci-discuss.net/4/407/2007/hessd-4-407-2007.ris)
のファイルをダウンロードできます。

## 質問
SWRC Fit に関する質問の一覧は
[こちら](https://github.com/sekika/swrcfit/issues?q=is%3Aissue+label%3Aquestion)で見ることができます。
あなたの質問を投稿するためには、GitHub のアカウントを取得して緑色の「New Issue」ボタンを押して下さい。
Label は「question」を選んで下さい。日本語での質問も可能です。 質問を公開出来ない場合には、[作者](http://www2.toyo.ac.jp/~seki_k/)にメールを送って下さい。
