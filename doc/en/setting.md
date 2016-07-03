# Calculation options

Calculation option can be written as a text file. The program reads setting
in the order of

1. System default value
2. .swrcfitrc in user's home directory
3. setting.txt in current directory
4. setting (equation or file) specified from commandline option

The latter overwrites formers. You can write your preference in
$HOME/.swrcfitrc, and preference for special set of data files in a
directory in setting.txt, and these setting will be read without
specifying at command line parameters. 

A sample setting file is included in the source package as `setting.txt`
([download](https://raw.githubusercontent.com/sekika/swrcfit/master/setting.txt)).
The file describes the default setting of the program; when setting
file is not specified, these default setting is used.

```
precision = 5; # precision of the output
```
This line sets the precision of the ouput, i.e., the numbers of
[significant figures](http://en.wikipedia.org/wiki/Significant_figures)
to display. Default value is 5.

```
# Selection of model
```
This line is a comment. It indicates that this block is for selection of model.
GNU Octave language ignores the rest of a line following a sharp sign ("#").

```
mode = 1; # Unimodal model
# mode = 2; # Bimodal model
# mode = 3; # Unimodal and bimodal model
```
These lines are for setting of the mode of calculation.
When mode=1 (default), fitting of unimodal (BC, VG, LN, FX) models
are conducted. When mode=2, fitting of bimodal (DB and BL) models
are conducted, and when mode=3, both unimodal and bimodal models
are conducted. Therefore, if you write a setting file of
`mode = 2;`, bimodal models are used for fitting.

From version 3, individual model can be selected by the options of

```
bc=1; vg=1; ln=1; fx=1; # Unimodal models (0=no, 1=yes)
db=1; bl=1; # Bimodal models (0=no, 1=yes)
```

Please note that when ";" is not written at the end, the equation
is shown when you run the program. The ";" suppresses the output.

```
qsin = max(y); # initial value of qs
cqs=1; # cqs=1; qs is variable, cqs=0; qs is constant
```
These lines specify the variable &theta;<sub>s</sub>, the saturated
water content. In this program, &theta;<sub>s</sub> is shown as "qs".
Two parameters, qsin and cqs, controls how the program treats this
variable. qsin is the initial value of &theta;<sub>s</sub> and cqs
is a parameter which decides &theta;<sub>s</sub> is constant or
variable; when cqs is set as 0, &theta;<sub>s</sub> is treated as a
constant, and when cqs is 1, &theta;<sub>s</sub> is treated as a
variable. By default, initial value of &theta;<sub>s</sub>is set as
the maximum value of the soil water content, and it is set as a
variable, but it can be changed by editing this section. For example,
for setting &theta;<sub>s</sub> = 0.35 as a constant, write
`qsin=0.35; cqs=0;` in the setting file.

```
qrin = min(y); # initial value of qr
cqr=1; # cqr=1; qr is variable, cqr=0; qr is constant
# qrin=0; cqr=0; # For setting qr=0 as a constant
pqr=1; # pqr=1; qr >= 0, pqr=0; qr can be negative
```
These lines specify the variable &theta;<sub>r</sub>, the residual
water content. In this program, &theta;<sub>r</sub> is shown as "qr".
Three parameters, qrin, cqr and pqr, controls how the program treats
this variable. qrin is the initial value of &theta;<sub>r</sub>, cqr
is a parameter which decides &theta;<sub>r</sub> is constant or
variable; when cqr is set as 0, &theta;<sub>r</sub> is treated as a
constant, and when cqr is 1, &theta;<sub>r</sub> is treated as a
variable, and pqr is a variable which decides if the restriction of
&theta;<sub>r</sub> >= 0 is imposed. By default, initial value of
&theta;<sub>r</sub> is set as the minimum value of the soil water
content, and it is set as a variable with the restriction of
&theta;<sub>r</sub> >= 0, but it can be changed by writing a setting
file. For example, for seting &theta;<sub>r</sub> = 0 as a constant
value, write a setting file of `qrin=0; cqr=0;` (if you use the
distributed `setting.txt` file, remove # at the corresponding line).
For setting &theta;<sub>r</sub> = 0.05 as a constant value, write
`qrin=0.05;` in the setting file. To disable the restriction of
&theta;<sub>r</sub> >= 0, write `pqr=0;` in setting file.

Following lines controls the correction function (CF) of FX model from version 3.0.

```
# Correction function (CF) of FX model (from Version 3.0)
fxc=0; # fxc=1; use CF, fxc=0; no CF (CF=1)
psir=30000; # psi_r of CF
psimax=10000000; # psi_max of CF
```

By default, fxc=0, meaning that CF=1. By setting fxc=1, correction function is set
according to Fredlund and Xing (1994);

C(psi) = -[ln(1+psi/psir)] / [ln[1+(psimax/psir)] + 1

where psi is the suction head (h) in this program, parameters psir and psimax can
be changed as you like, where psimax is 10^6 kPa in Fredlund and Xing (1994).

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

- By setting data=1, original input data is shown.
- By setting K=1, numbers of parameters is shown.
- By setting r2=1 (default), R^2 (coefficient of determination) is shown.
- By setting rmse=1, root mean square error (RMSE) is shown.
- By setting ns=1, sample size is shown.
- By setting aic=1, AIC is shown (see below).
- By setting bic=1, BIC is shown (see below).

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
 
