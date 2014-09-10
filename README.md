# swrcfit (SWRC Fit) - Fitting soil water retention curve

SWRC Fit is a program which performs nonlinear fitting of soil water retention curve with following 5 models by Levenberg-Marquardt method. This software was used in [more than 50 scientific works](http://scholar.google.com/scholar?oi=bibs&hl=en&cites=7295614925292719046).

|Model|Equation|Reference|
|-----|--------|---------|-
|BC |![equation](http://swrcfit.sourceforge.net/img/BC.png) |Brooks and Corey, 1964|
|VG |![equation](http://swrcfit.sourceforge.net/img/BC.png) (m = 1-1/n) |van Genuchten, 1980|
|LN |![equation](http://swrcfit.sourceforge.net/img/LN.png) |Kosugi, 1996|
|DB |![equation](http://swrcfit.sourceforge.net/img/DB.png) (m<sub>i</sub> = 1-1/n<sub>i</sub>) |Durner, 1994|
|BL |![equation](http://swrcfit.sourceforge.net/img/BL.png) |Seki, 2007|

where h is the suction head, &theta; is volumetric water content, S<sub>e</sub> is the effective water content defined by ![equation](http://swrcfit.sourceforge.net/img/Se.png), i.e., ![equation](http://swrcfit.sourceforge.net/img/Se2.png), and Q(x) is the complementary cumulative normal distribution function, defined by Q(x)=1-&phi;(x), in which &phi;(x) is a normalized form of the cumulative normal distribution function. Please note that Q(x) is different from error function. Other parameters are soil hydraulic parameters to be optimized with swrcfit.

Basic information of this program is summarized:

* Publication: [doi:10.5194/hessd-4-407-2007](http://dx.doi.org/10.5194/hessd-4-407-2007)
* Website: https://github.com/sekika/swrcfit/
* Web interface: http://seki.webmasters.gr.jp/swrc/
* Author: [Katsutoshi Seki](http://researchmap.jp/sekik/)
* License: GNU General Public License
* Version of this distribution: 1.3

This file is written with markdown and can be viewed online here: https://github.com/sekika/swrcfit/blob/master/README.md

## Contents

- [Distributed package](#distributed-package)
- [Installation of GNU Octave and required package](#installation-of-gnu-octave-and-required-package)
- [Installation of this program](#installation-of-this-program)
- [Preparation of data file](#preparation-of-data-file)
- [Preparation of setting file](#preparation-of-setting-file)
- [Running the program](#running-the-program)
- [Checking the result](#checking-the-result)
- [Web interface of the SWRC Fit](#web-interface-of-the-swrc-fit)
- [Citation of this work](#citation-of-this-work)
- [Question](#question)
- [Reference](#reference)

## Distributed package

1. swrcfit ... Main progtam
2. swrc.txt ... Sample data
3. setting.txt ... Sample setting file
4. result.txt ... Sample result obtained from sample data
5. Install.sh ... Install script for Unix-like system
6. swrc.xlsx ... Microsoft Excel worksheets for checking the result.
7. README.md ... This file
8. fig1.png, fig2.png, fig3.png ... Figures used in README.md
9. ChangeLog ... Version history
10. COPYING ... GNU General Public License

## Installation of GNU Octave and required package

   SWRC Fit is written in GNU Octave, and therefore GNU Octave should be installed in the system. GNU Octave is a high-level language, primarily intended for numerical computations, available for downloading from the GNU Octave Website (http://www.gnu.org/software/octave/). The installation instructions are given in the Website. It works on various operating systems including Windows, Mac OS X, Linux and OS/2.

After installing GNU Octave, some necessary packages for running SWRC Fit, `leasqr.m` and `dfdp.m` and several other files which are used from these files should be installed from the octave-forge package (http://octave.sourceforge.net/). From octave shell, these files can be installed with `pkg install -forge struct optim`.

In case the installation of package with this command fails, download these files manually and put them in Octave loadpath. You can check loadpath by running `path` in Octave shell.

* [leasqr.m](http://sourceforge.net/p/octave/optim/ci/default/tree/inst/leasqr.m)
* [dfdp.m](http://sourceforge.net/p/octave/optim/ci/default/tree/inst/dfdp.m)
* [cpiv_bard.m](http://sourceforge.net/p/octave/optim/ci/default/tree/inst/cpiv_bard.m)
* [\__dfdp__.m](http://sourceforge.net/p/octave/optim/ci/default/tree/inst/private/__dfdp__.m)
* [\__lm_svd__.m](http://sourceforge.net/p/octave/optim/ci/default/tree/inst/private/__lm_svd__.m)
* [\__plot_cmds__.m](http://sourceforge.net/p/octave/optim/ci/default/tree/inst/private/__plot_cmds__.m)
* [\__do_user_interaction__.m](http://sourceforge.net/p/octave/optim/ci/default/tree/inst/private/__do_user_interaction__.m)

## Installation of this program

### Windows
Copy `swrcfit` to the same directory where octave is installed, for example, `C:\Software\Octave-3.6.4\bin`.

### Mac, Linux and other Unix-like system
* Edit the first line of swrcfit, `#!/usr/bin/octave -qf`, to the path where octave is installed.
* Copy to wherever the path is set, such as /usr/local/bin or /usr/bin.

`Install.sh` script tries to automatically do the job so far. It first checks if Octave is installed, and install swrcfit to `/usr/local/bin`. If it is invoked with `./Install.sh DIR`, swrcfit is installed to `DIR`. After that, the script runs swrcfit with sample data and checks if it is identical to sample result. If it is not, it tries to install optim package from octave forge. If it is not successful, it tries to get necessary files directly from sourceforge by wget command.

## Preparation of data file

   The input data, i.e., the soil water retention curve, should be prepared as a text file with two columns. Sample data is included in the package as `swrc.txt`. The first column is the suction head and the second column is the volumetric water content, where space is used as a delimiter. For example;

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

   Lines beginning with "#" are regarded as comment and neglected.  Any unit can be used as the input data, and the calculated data depends on the unit used as the input data.

   Optionally, the data file can have the third column. When it has the third column, it is interpreted as a weight for each parameter.

  For example,

```
0 0.2628 1
20 0.237 1
40 0.211 1
70 0.1855 1
100 0.169 1
1050 0.1159 3
```

   This data has weight of 1 for the suction of 0, 20, 40, 70, 100 and 3 for the suction of 1050.

## Preparation of setting file

When setting file is specified, it is read before calculation starts. A sample setting file is included in the package as `setting.txt`. The file is as follows and it is the default setting of the program; when setting file is not specified, these default setting is used. Therefore, if you specify a file with only "mode = 2" written as a setting file, other parameters are set as default values.

```
# Setting
mode = 1; # Unimodal model
# mode = 2; # Bimodal model
# mode = 3; # Unimodal and bimodal model
output_precision(5); # precision of the output
qsin = max(y); # initial value of qs
cqs=1; # cqs=1; qs is variable, cqs=0; qs is constant
qrin = min(y); # initial value of qr
cqr=1; # cqr=1; qr is variable, cqr=0; qr is constant
# qrin=0; cqr=0; # For setting qr=0 as a constant
pqr=1; # pqr=1; qr >= 0, pqr=0; qr can be negative
adv=0; # adv=1; advanced output; adv=0; normal output;
```

The first line, "# Setting",  is a comment. It indicates that this is a setting file. GNU Octave language ignores the rest of a line following a sharp sign ("#").

The 2nd to 4th lines are for setting of the mode of calculation. When mode=1 (default), fitting of unimodal (BC, VG, and LN) models are conducted. When mode=2, fittin of bimodal (DB and BL) models are conducted, and when mode=3, both unimodal and bimodal models are conducted.

The 5th line sets the precision of the ouput. In GNU Octave, the variable output_precision specifies the minimum number of significant figures to display for numeric output. Default value is 7.

The lines 6-7 specify the variable q[s], the saturated water content. In this program, q[s] is shown as "qs". Two parameters, qsin and cqs, controls how the program treats this variable. qsin is the initial value of q[s] and cqs is a parameter which decides q[s] is constant or variable; when cqs is set as 0, q[s] is treated as a constant, and when cqs is 1, q[s] is treated as a variable. By default, initial value of q[s]is set as the maximum value of the soil water content, and it is set as a variable, but it can be changed by editing this section. For example, for setting q[s] = 0.35 as a constant, following line can be added after the third line;

```
qsin=0.35; cqr=0;
```

The lines 8-11 specify the variable q[r], the residual water content. In this program, q[r] is shown as "qr". Three parameters, qrin, cqr and pqr, controls how the program treats this variable. qrin is the initial value of q[r], cqr is a parameter which decides q[r] is constant or variable; when cqr is set as 0, q[r] is treated as a constant, and when cqr is 1, q[r] is treated as a variable, and pqr is a variable which decides if the restriction of q[r] >= 0 is imposed. By default, initial value of q[r] is set as the minimum value of the soil water content, and it is set as a variable with the restriction of q[r] >= 0, but it can be changed by editing this section. For example, for seting q[r] = 0 as a constant value, the 7th line is to be commented out,, i.e., the first "#" mark is to be deleted. For setting q[r] = 0.05 as a constant value, following line can be added after the 7th line;

```
qrin=0.05; cqr=0;
```

   To disable the restriction of q[r] >= 0,  the 8th line, pqr=1, is to be changed to pqr=0.

   The line 9 controls the output mode; the parameter adv defines how the result is shown. The default value is adv=0, where only basic information is shown (normal mode), and when it is changed to adv=1, advanced information (correlation matrix and standard deviation) is also shown as a result (advanced mode).

## Running the program

In Unix-like system, the program is executed as

```
swrcfit DataFilename [SettingFilename]
```

where DataFilename is a filename of the data file, and SettingFilename is a filename of the setting file. When SettingFilename is not specified, default setting is used. The calculation result is shown in Octave terminal or standard output. The blanket [ ] indicates that it is not required.

In Windows, the program is executed from command prompt as

```
octave swrcfit DataFileName [SettingFileName]
```

where full path name of octave, DataFileName and SettingFileName should be specified. If Octave is installed in, for example, C:\Software\Octave-3.6.4\bin, you can put all the files, swrcfit, data file, and setting file, in the same directory, and run in the command prompt `C:; cd C:\Software\Octave-3.6.4\bin` to get in the directory, and then you can just type `octave swrcfit DataFileName [SettingFileName]`. Another way is to set path to the directory where octave and swrcfit are installed. Then you can set data file and setting file to separate directory and run swrcfit in the data directory.

If you execute the sample data, `swrc.txt`, by `swrcfit swrc.txt`, sample result which is included as `result.txt` in the package is shown as follows.

```
=== BC model ===
qs =  0.38316
qr =  0.047638
hb =  41.704
lambda =  7.0104
R2 =  0.99279
=== VG model ===
qs =  0.38656
qr =  0.055190
alpha =  0.021547
n =  15.923
R2 =  0.99246
=== LN model ===
qs =  0.38625
qr =  0.056345
hm =  46.631
sigma =  0.10818
R2 =  0.99167
```

   If advanced mode is selected (see the previous section), correlation matrix and standard deviation are also shown as follows.

```
=== BC model ===
qs =  0.38316
qr =  0.047638
hb =  41.704
lambda =  7.0104
R2 =  0.99279
CorrelationMatrix =

   1.000000  -0.071401  -0.345313  -0.164434
  -0.071401   1.000000   0.376894   0.663845
  -0.345313   0.376894   1.000000   0.807590
  -0.164434   0.663845   0.807590   1.000000

StandardDeviation =

   0.0035511
   0.0040837
   0.4535012
   0.6777662

=== VG model ===
qs =  0.38656
qr =  0.055190
alpha =  0.021547
(continued)
```

   The order of the element is the same as the result display; in the order of qs, qr, hb and lambda. The above example is the case where q[s] and q[r] are set as variables (cqs=1 and cqr=1), and if either or both of the parameters are set as constant, correlation matrix and standard deviation are shown only for the parameters set as a variable.

## Checking the result

   Using the Microsoft Excel worksheet, `swrc.xls`, the fitted curves can be checked (**Fig. 1**). By copying and pasting the result of the program output onto the yellow part and the measured data onto the blue part of the spreadsheet, The fitted curves are drawn in the graph of the same spreadsheet.  

![Fig. 1](./fig1.png)

Fig. 1 Spreadsheet for checking the result

## Web interface of the SWRC Fit

   The Web interface of the SWRC Fit (http://purl.org/net/swrc/) is written in the program language perl and works as a cgi program. The perl program invokes GNU octave and executes the calculation engine of swrcfit.

   The screenshot of the user interface is shown in **Fig. 2**. Soil water retention data, prepared as [explained above](#preparation-of-data-file), is to be copied and pasted in the textbox. It can also be selected from the sample soil water retention data in the UNSODA database (Nemes et al., 2001).  In other textboxes, the description of the soil sample, soil texture, and name can be written. The description written here appears in the results screen. The calculation options of q[r]=0 can be set by checking appropriate boxes. By default, only unimodal (BC, VG and LN) models are used, and when the users select the "Bimodal models" checkbox, bimodal (DB and BL) models will also be used. After that, the calculation starts by pressing the "Calculate" button.

![Fig. 2](./fig2.png)

Fig. 2 Screenshot of the input display of the web interface (http://purl.org/net/swrc/)

   In the result screen, the result of the nonlinear fit is shown as **Fig. 3**. The models, equations, parameters, and R<sup>2</sup> values are shown in tabular form, and the fitting curves with measured data points are also shown in a graph. If the bimodal model is selected, the results of the bimodal models are shown separately. By looking at the results, the accuracy of the fit with different models can be compared in both R<sup>2</sup> values and fitting curves. The description of the soil sample and the original data is also displayed in the results screen so that the users can print out and store all the necessary information.

![Fig. 3](./fig3.png)

Fig. 3 Screenshot of the results display of web interface (http://purl.org/net/swrc/)

For those who might be interested, you can read [source code of the web interface](https://github.com/sekika/swrcfit-cgi).

## Citation of this work

Please cite this paper when you publish your work using SWRC Fit.

* Seki, K. (2007) SWRC fit - a nonlinear fitting program with a water retention curve for soils having unimodal and bimodal pore structure. Hydrol. Earth Syst. Sci. Discuss., 4: 407-437. [doi:10.5194/hessd-4-407-2007](http://dx.doi.org/10.5194/hessd-4-407-2007)

[BibTeX](http://www.hydrol-earth-syst-sci-discuss.net/4/407/2007/hessd-4-407-2007.bib) and [EndNote](http://www.hydrol-earth-syst-sci-discuss.net/4/407/2007/hessd-4-407-2007.ris) files are also available.

## Question
[Here](https://github.com/sekika/swrcfit/issues?q=is%3Aissue+label%3Aquestion) you can find a list of questions and answers about swrcfit. You can submit your own question by getting the accout of GitHub and pressing the green "New Issue" button. Please select the label of "question". It is preferable to send your question publicly this way, because other people having the same question can find answer on the web. However, if your question is confidential, please contact me by email. Tou can find my email address in [this paper](http://file.scirp.org/Html/2-1660128_33490.htm).

## Reference

1. Brooks, R. H., and Corey, A.T.: Hydraulic properties of porous media. Hydrol. Paper 3. Colorado State Univ., Fort Collins, CO, USA, 1964.
2. Durner, W.: Hydraulic conductivity estimation for soils with heterogeneous pore structure. Water Resour. Res., 30(2): 211--223, 1994.
3. Kosugi, K.: Lognormal distribution model for unsaturated soil hydraulic properties. Water Resour. Res. 32(9), 2697--2703, 1996.
Nemes, A., M.G. Shaap, F.J. Leij, and J.H.M. Wosten: Description of the unsaturated soil hydraulic database UNSODA version 2.0. J. Hydrol. (Amsterdam) 251:151--162, 2001.
4. Seki, K. (2007) SWRC fit - a nonlinear fitting program with a water retention curve for soils having unimodal and bimodal pore structure. Hydrol. Earth Syst. Sci. Discuss., 4: 407-437.
5. van Genuchten, M.T.: A closed-form equation for predicting the hydraulic conductivity of unsaturated soils. Soil Sci. Soc. Am.  J. 44, 892--898, 1980.
