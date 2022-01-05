# swrcfit (SWRC Fit) - Fitting soil water retention curve

SWRC Fit is a program which performs nonlinear fitting of soil water
retention curve with
[6 SWRC models](model.md)
by Levenberg-Marquardt method. This software was used in
[more than 200 scientific works](http://scholar.google.com/scholar?oi=bibs&hl=en&cites=7295614925292719046).
Basic information of this program is summarized:

* Publication: [doi:10.5194/hessd-4-407-2007](http://dx.doi.org/10.5194/hessd-4-407-2007)
* Author: [Katsutoshi Seki](http://researchmap.jp/sekik/)
* License: GNU General Public License

## Migration to unsatfit
From January 4, 2022, development of the GNU Octave version of SWRC Fit was migrated to a Python library [unsatfit](https://sekika.github.io/unsatfit/). Unsatfit also performs fitting of unsaturated hydraulic conductivity function. The [web version of SWRC Fit](http://purl.org/net/swrc/) uses unsatfit as a library and performs fitting of water retention function only, and is still called SWRC Fit. The source code of the new SWRC Fit is [published with unsatfit](https://github.com/sekika/unsatfit/tree/main/swrcfit).

The source code of the GNU Octave version is available at this GitHub repository, but It is no longer used, developed or maintained by the author.

## Contents

- [How to install](#how-to-install)
- [Running the program](#running-the-program)
- [Preparation of data file](#preparation-of-data-file)
- [Calculation options](#calculation-options)
- [Drawing graph](#drawing-graph)
- [Web interface](#web-interface)
- [Citation of this work](#citation-of-this-work)
- [Question](#question)

## How to install

Choose your OS to install.

- [Windows](install-windows.md)
- [Mac OS X](install-mac.md)
- [Linux and other POSIX systems](install-linux.md)

## Running the program

In your [terminal](http://en.wikipedia.org/wiki/Terminal_emulator), run the program with

```
swrcfit DataFile [setting]...
```

where DataFile is a filename of the [data file](#preparation-of-data-file),
and setting is the [calculation options](#calculation-options).
The blanket [ ] indicates that it is not required, and ... indicates that
multiple settings can be specified.

If you use the sample data in the source package, `swrc.txt`
([download](https://raw.githubusercontent.com/sekika/swrcfit/master/swrc.txt)),
by `swrcfit swrc.txt`, sample result which is included as `result.txt`
in the package is shown as follows. See equations and parameters
[here](https://github.com/sekika/swrcfit/wiki/SWRC-models). Please note
that q represents &theta;.

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

## Preparation of data file

The input data, i.e., the soil water retention curve, should be prepared
as a text file with two columns. Sample data is included in the source
package as `swrc.txt`
([download](https://raw.githubusercontent.com/sekika/swrcfit/master/swrc.txt)). 
The first column is the suction head and the second column is the
volumetric water content, where space is used as a delimiter. For example;

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

Lines beginning with "#" are regarded as comment and neglected.
Any unit can be used as the input data, and the calculated data depends
on the unit used as the input data.

Optionally, the data file can have the third column. When it has the
third column, it is interpreted as a weight for each data point.

For example,

```
0 0.2628 1
20 0.237 1
40 0.211 1
70 0.1855 1
100 0.169 1
1050 0.1159 3
```

This data has weight of 1 for the suction of 0, 20, 40, 70, 100 and 3
for the suction of 1050.

## Calculation options

Calculation options can be specified from command line option in the
form of `parameter=value`. Calculation option can also be specified
with a file where calculation options are written. If the option
involves a character `=`, swrcfit evaluates the given equation.
If the option does not have `=` character, swrcfit understands that
it is a filename and reads setting from the specified file.

Here, some examples of calculation options are shown.

|Calculation option|Meaning|
|------------------|----------------|
|bc=0 ln=0         |Not calculate BC or LN models (therefore showing VG and FX models)|
|mode=2            |Bimodal models (DB and BL models)|
|mode=3 bc=0 vg=0 ln=1 fx=0 db=0 bl=1 |LN and BL models|
|qsin=0.35 cqs=0   |&theta;<sub>s</sub>=0.35 is constant|
|qrin=0.03 cqr=0   |&theta;<sub>r</sub>=0.03 is constant|
|aic=1             |Show AIC (Akaike's information criteria)|

For example, when this command is executed,
```
swrcfit swrc.txt mode=3 bc=0 vg=0 ln=1 fx=0 db=0 bl=1 aic=1
```
Fitting of LN and BL models are conducted with the input parameters in
`swrc.txt`, show also AIC.

Please read [detailed description of calculation options](setting.md).

## Drawing graph

SWRC curve can be drawn when properly installed and proper figure options are given.
Please see detailed instruction for [drawing graph with gnuplot](graph.md).

Sample output of figure.

![Figure](https://raw.githubusercontent.com/sekika/swrcfit-cgi/master/img/sample1.png)

## Web interface

The Web interface of the SWRC Fit (http://purl.org/net/swrc/) is written
in the program language perl and works as a cgi program. The perl program
invokes GNU octave and executes the calculation engine of swrcfit.

![Web interface](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/fig2.png)

[More information about the web interface](http://seki.webmasters.gr.jp/swrc/help.html).

## Citation of this work

Please cite this paper when you publish your work using SWRC Fit.

* Seki, K. (2007) SWRC fit - a nonlinear fitting program with a water
  retention curve for soils having unimodal and bimodal pore structure.
  Hydrol. Earth Syst. Sci. Discuss., 4: 407-437.
  [doi:10.5194/hessd-4-407-2007](http://dx.doi.org/10.5194/hessd-4-407-2007)

[BibTeX](http://www.hydrol-earth-syst-sci-discuss.net/4/407/2007/hessd-4-407-2007.bib)
and [EndNote](http://www.hydrol-earth-syst-sci-discuss.net/4/407/2007/hessd-4-407-2007.ris)
files are also available.

----
Other language: [日本語](../ja/README.md)
