# 計算の設定

計算の設定はテキストファイルに記述できる。プログラムは、設定を次の順序で読み込む。

1. システムのデフォルト
2. ユーザーのホームディレクトリの .swrcfitrc ファイル
3. カレントディレクトリの setting.txt
4. コマンドラインオプションで指定する設定（式またはファイル）

後に読み込まれたものが、先に読み込まれたものを上書きする。
ユーザーごとの設定を $HOME/.swrcfitrc に記述して、ある特定のデータファイルが
入っているディレクトリに対して、そのデータファイルに対する処理の設定を
そのディレクトリの setting.txt に記述しておけば、コマンドラインで指定しなくても
その設定が有効になる。

サンプルの設定ファイルがパッケージに `setting.txt`
([ダウンロード](https://raw.githubusercontent.com/sekika/swrcfit/master/setting.txt))
として含まれている。このファイルはシステムのデフォルトが記述されている。
設定ファイルが指定されていなければ、このデフォルト値が使われる。

## モデルの選択

```
# Selection of model
```
この行はコメントである。このブロックがモデルの選択を設定することを示している。
Octave では、"#" で始まる行はコメントであるとして無視される。

```
mode = 1; # Unimodal model
# mode = 2; # Bimodal model
# mode = 3; # Unimodal and bimodal model
```
これらは計算のモードを指定する。
デフォルトの mode=1 では、単峰性モデル (BC, VG, LN, FX) が計算される。
mode=2 とすると、二峰性モデル (DB, BL)  が計算され、
mode=3 とすると、すべてのモデルが計算される。
ここで、式の最後には ";" を指定する。そうしないと、プログラムを実効した時に
パラメータの値が端末に表示されてしまう。

バージョン3からは、次のオプションでモデルを個別に選択できる。
mode の指定とモデルごとの個別の指定が両方とも指定されているモデルが計算される。

```
bc=1; vg=1; ln=1; fx=1; # Unimodal models (0=no, 1=yes)
db=1; bl=1; # Bimodal models (0=no, 1=yes)
```

## パラメータの設定

```
## qs and qr handling
qsin = max(y); # initial value of qs
cqs=1; # cqs=1; qs is variable, cqs=0; qs is constant
```
ここでは飽和含水率&theta;<sub>s</sub>の初期値を設定する。
このプログラムでは&theta;<sub>s</sub>は "qs" と表示する。
2つのパラメータ  qsin と cqs が、変数の取り扱い方を指定する。
qsin は&theta;<sub>s</sub>の初期値で、cqsは&theta;<sub>s</sub>
を定数として扱うかどうかを指定する変数である。
cqs が0の時には、&theta;<sub>s</sub>は定数として扱われ、
cqs が1の時には、&theta;<sub>s</sub>は変数として扱われ最適化される。
デフォルトでは、&theta;<sub>s</sub>の初期値は含水率の最大値として、
変数として扱われて最適化されるが、この設定を変えることができる。
たとえば、&theta;<sub>s</sub> = 0.35 を定数として設定するのであれば、
設定ファイルに`qsin=0.35; cqs=0;`と記述する。

```
qrin = min(y); # initial value of qr
cqr=1; # cqr=1; qr is variable, cqr=0; qr is constant
# qrin=0; cqr=0; # For setting qr=0 as a constant
pqr=1; # pqr=1; qr >= 0, pqr=0; qr can be negative
```
ここでは、残留含水率&theta;<sub>r</sub>の設定をする。
このプログラムでは &theta;<sub>r</sub>を "qr" を表示する。
3つのパラメータ qrin, cqr, pqr この変数の取り扱い方を指定する。
qrin は&theta;<sub>r</sub>の初期値を指定する。
cqrは&theta;<sub>r</sub>が変数かどうかを指定する。
cqrが0の時には&theta;<sub>r</sub>は定数で、1の時は
&theta;<sub>r</sub>は変数であるとして最適化される。
pqrは&theta;<sub>r</sub> >= 0の制限を課すかどうかを指定する。
デフォルトでは、&theta;<sub>r</sub>の初期値は含水率の最小値で、
&theta;<sub>r</sub> >= 0の制約条件の下、最適化されるが、
こらの設定を変えることができる。
たとえば、&theta;<sub>r</sub> = 0の定数としたい時には、
`qrin=0; cqr=0;`と設定ファイルに記述する（配布されている
`setting.txt`ファイルの対応する行の # を削除する）。

### FX モデルの修正関数

次の行は、FXモデルの修正関数(CF)を設定する。
バージョン3.0以降で有効である。

```
## Correction function (CF) of FX model (from Version 3.0)
fxc=0; # fxc=1; use CF, fxc=0; no CF (CF=1)
psir=30000; # psi_r of CF
psimax=10000000; # psi_max of CF
```

デフォルトでは fxc=0 であり、 CF=1 すなわち修正関数を使わない。
fxc=1 とすることで、Fredlund and Xing (1994) による次の修正関数を使う。

C(psi) = -[ln(1+psi/psir)] / [ln[1+(psimax/psir)] + 1

ここで、 psi はこのプログラムではサクションヘッド h であり、
psir と psimax は自由に設定できる。Fredlund and Xing (1994) では、
psimax は 10<sup>6</sup> kPa としている。

## 結果の表示に関する設定

```
# Output format of the result
precision = 5; # precision of the output
```
表示桁数、つまり有効数字を指定する。デフォルトは5桁である。
バージョン2.1以前では、`output_precision(5)` のように指定する。

```
adv=0; # adv=1; advanced output; adv=0; normal output;
simple=0; # simple=1; simple output, simple=0; normal output
```
ここでは結果の表示モードを制御している。advは表示方法を決める。
デフォルトの adv=0 では基本的な情報が表示され、
adv=1 では相関行列と標準偏差が表示される。
qsやqrが定数の時は、変数に対しての相関行列と標準偏差が表示される。

simple=1 が設定されると、変数名は表示されずに数字だけが表示される。
したがって、他のプログラムから swrcfit を起動して、結果をパラメータに
入れる時には便利である。

他にも次のようないくつかの表示モードがバージョン 3.0 で追加された。

```
# Added from version 3.0
data=0; # Show original input data (0=no, 1=yes)
K=0; # Show numbers of parameters (0=no, 1=yes)
r2=1; # Show R^2 (coefficient of determination) (0=no, 1=yes)
rmse=0; # Show RMSE (root mean square error) (0=no, 1=yes)
ns=0; # Show sample size (0=no, 1=yes)
aic=0; # Show AIC (Akaike information criterion) (0=no, 1=yes)
bic=0; # Show BIC (Bayesian information criterion) (0=no, 1=yes)
```
- data=1 とすると、入力データを表示する。
- K=1 とすると、パラメータの数を表示する。
- r2=1 とすると（デフォルト）、決定係数 R<sup>2</sup> を表示する。
- rmse=1 とすると、残差平方和(RMSE)を表示する。
- ns=1 とすると、データのサンプルサイズを表示する。
- aic=1 とすると、AICを表示する（下記）。
- bic=1 とすると、BICを表示する（下記）。

AIC ([赤池情報量規準](https://ja.wikipedia.org/wiki/%E8%B5%A4%E6%B1%A0%E6%83%85%E5%A0%B1%E9%87%8F%E8%A6%8F%E6%BA%96))と
BIC ([ベイズ情報量規準](https://ja.wikipedia.org/wiki/%E3%83%99%E3%82%A4%E3%82%BA%E6%83%85%E5%A0%B1%E9%87%8F%E8%A6%8F%E6%BA%96))
は複数のモデルの中から最適なモデルを選択する規準を示す。
最小のAICあるいはBICを持つモデルが好ましい。
パラメータの数が異なる複数のモデルから最適なモデルを選ぶ時には、
R<sup>2</sup>や残差平方和(RMSE)は良い規準とはならない。
なぜならば、パラメータの数を考慮に入れていないため、パラメータを増やしすぎた
モデルを選択してしまう可能性があるためである。
AICとBICは、kの問題を解決するためにモデルのパラメータの数に関する
ペナルティ項を導入した。ペナルティ項は、AICよりもBICの方が大きい。

## グラフの表示に関する設定

```
# Figure options (from version 2.0)
```

この行から先は、グラフを表示するためのパラメータが書かれている。
グラフを端末に表示したりファイルに保存したりする設定や、
グラフの見た目に関する設定ができる。
詳しくは[Gnuplot によるグラフの表示](graph.md)を参照。

----
[SWRC Fit マニュアル](README.md)

