# Gnuplot によるグラフの描画

[SWRC Fit](https://github.com/sekika/swrcfit/) ではバージョン2.0から gnuplot によるグラフ描画をサポートしている。そのためには、システムに gnuplot が適切にインストールされている必要がある。

## gnuplot が適切にインストールされていることの確認

Octave のシェルで、
```
plot(sqrt(0:100))
```
と実行して、 y=x^(1/2) のグラフが x=0 から 100 まで描かれることを確認する。描画されれば適切にインストールされているので、swrcfit のグラフ描画機能を利用できる。それができない時には、いくつかの可能性がある。

1. Gnuplot がシステムにインストールされていない
2. Octave が gnuplot を使うようにインストールされていない
3. X サーバーが適切にインストールされていない
4. 環境変数が適切な端末を使うように設定されていない

For example, when you install octave on Mac with homebrew, environmental variable GNUTERM should be set (confirm by typing `brew cat octave | grep GNUTERM`).

If you cannot directly view the gnuplot figure on the screen, you might be able to create figure files.

If you have trouble showing graphs with your OS, you might be able to use a [virtualization](https://en.wikipedia.org/wiki/Hardware_virtualization) software such as [VirtualBox](https://www.virtualbox.org/) and [VMware](http://www.vmware.com/) products and install a virtual machine of one of Linux distributions, and then install swrcfit on the virtual machine.

## Figure options
Figure options can be written in the setting file. In this section, parameters for plot is shown with default setting.

```
fig=0; # fig=0; no figure. fig=1; output figure on terminal and/or file
```
At first, the parameter fig should be set to fig=1 to show figure.

```
showfig=0; # showfig=1; show figure on terminal. showfig=0; otherwise.
```
When showfig=1 is set, figure is shown at your terminal. This is valid only when terminal is correctly set as described in the previous section. When this option is set, swrcfit stops when it shows a figure, swrcfit pauses with a message "Hit return key to finish." When you hit return key, the figure disappears and the swrcfit proceeds.

```
figure="swrc.png"; # Filename of the figure of unimodal models.
figure2="bimodal.png"; # Filename of the figure of bimodal models. (Not available from version 3.0)
```
These are filenames of the output figure. Different name of unimodal and bimodel models can be specified. If same names are specified and both models are calculated, the latter overwrites the former. To supress the output to file, set `figure=""` and `figure2=""`. The format of the file is automatically selected from the extention of the filename. Octave can produce png, jpg, ps, eps, emf, pdf, svg, and several other file formats, as shown in [-ddevice option of print function](http://www.gnu.org/software/octave/doc/interpreter/Printing-and-Saving-Plots.html), but depending on your installation, some file formats might not be available.

**Note**: When you specify file name from command line, the **quotation marks should be escaped**
**with backslashes** `\`. Therefore, specifing `figure="swrc.eps"` from command line, the equation
is `figure=\"swrc.eps\"`.

```
figsize=3; # Size of figure. figsize=1; 320x240, 2; 480x360, 3; 640x480
```
It specifies the size of the figure.
```
smooth=300; # Smoothness of the fitted line
```
When smooth=300 is specified, 300 points are calculated for fitting curve. The larger value makes smoothier figure and smaller value makes faster calculation.
```
showgrid=0; # showgrid=1; show grid, showgrid=0; otherwise.
```
You can show grid on the figure.
```
ax=0; # Type of x axis. ax=0; automatic, ax=1; normal, ax=2; log
minx=0; maxx=0; # Range of X axis. Automatic for 0.
miny=0; maxy=0; # Range of Y axis. Automatic for 0.
```

It selects the type of x axis, whether it is normal axis or logarithm axis. With the default setting of ax=0, swrcfit automatically decides the type. It also decides the range of axes.

From here, setting of the text in the figure are shown.
```
fontsize=16; # Font size
```
It specifies the font size of all the text in the figure.
```
showlabel=0; # showlabel=1; show label. showlabel=0; otherwise.
xlab="Suction"; # X label
ylab="Volumetric water content"; # Y label
showlegend=1; # showlegend=1; show legend. showlegend=0; otherwise.
```
These variables controls the output of labels at x and y axes and legend. Labels are now shown by default.
```
Mlab="Measured"; # legend for measured data
BClab="Brooks and Corey (1964)"; # legend for BC model
VGlab="van Genuchten (1980)"; # legend for VG model
LNlab="Kosugi (1996)"; # legend for LN model
FXlab="Fredlund and Xing (1994)"; # legend for FX model
DBlab="Durner (1994)"; # legend for DB model
BLlab="Seki (2007)"; # legend for BL model
```
These are for the text of the legend.
```
Mpl="bo"; # Format arguments for measured plot.
msize=5; # Marker size for measured plot
mcol="b"; # Marker face color for measured plot
```
These are setting of [format arguments](https://www.gnu.org/software/octave/doc/interpreter/Two_002dDimensional-Plots.html).

```
linewidth=1.5; # Line width of fitting curves
```
It specifies the line width of fitting curves.

Format arguments for each model is set in version 2,

```
BCpl="k-"; VGpl="r-"; LNpl="b-"; # Format arguments for BC, VG, LN models
DBpl="r-"; BLpl="b-"; # Format arguments for DB, BL models
```

and from version 3,

```
col = "krbgmc"; # Line color is set in this order
```
