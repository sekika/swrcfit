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

```
precision = 5; # precision of the output
```
表示桁数、つまり有効数字をしていする。デフォルトは5桁である。

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

```
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

次の行は、FXモデルの修正関数(CF)を設定する。
バージョン3.0以降で有効である。

```
# Correction function (CF) of FX model (from Version 3.0)
fxc=0; # fxc=1; use CF, fxc=0; no CF (CF=1)
psir=30000; # psi_r of CF
psimax=10000000; # psi_max of CF
```

デフォルトでは fxc=0 であり、 CF=1 すなわち修正関数を使わない。
fxc=1 とすることで、Fredlund and Xing (1994) による次の修正関数を使う。

C(psi) = -[ln(1+psi/psir)] / [ln[1+(psimax/psir)] + 1

ここで、 psi はこのプログラムではサクションヘッド h であり、
psir と psimax は自由に設定できる。Fredlund and Xing (1994) では、
psimax は 10^6 kPa である。

```
# Output format of the result
adv=0; # adv=1; advanced output; adv=0; normal output;
simple=0; # simple=1; simple output, simple=0; normal output
```

These lines control the output mode. the parameter adv defines how
the result is shown. The default value is adv=0, where only basic
information is shown (normal mode), and when it is changed to adv=1,
advanced information (correlation matrix and standard deviation) is
also shown as a result (advanced mode).

When simple=1 is set, the output is only numbers, without showing
variable names. It is therefore easy to call swrcfit from other program
and get the result to parameters.

Some options for output mode were added in version 3.0.

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

These parameters control which result to show as the output.
AIC ([Akaike's information criterion](https://en.wikipedia.org/wiki/Akaike_information_criterion)) and
BIC ([Bayesian information criterion](https://en.wikipedia.org/wiki/Bayesian_information_criterion))
or Schwarz criterion show criteria for selecting among the models.
The model with the lowest AIC or BIC is preferred.
To select a model from different models having different numbers of parameters,
the goodness of fit, such as R^2 or RMSE, is not a good measure because they do not take
the numbers of parameter in account and overfitted model may be selected.
Both AIC and BIC resolve this problem by introducing a penalty term for the number of
parameters in the model; the penalty term is larger in BIC than in AIC.

```
# Figure options (from version 2.0)
```

From these lines, parameters for drawing a graph is written.
You can control if you draw a graph
on terminal or/and file, and how the graph look like, in the section
following from here. Detail is described here: [Drawing graph with gnuplot](graph.md)
 
