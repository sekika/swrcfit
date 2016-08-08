# 水分特性モデル

SWRC Fit には、以下のモデルが組み込まれている。

|Model|Equation|Reference|
|-----|--------|---------|
|BC |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/BC.png) |Brooks and Corey, 1964|
|VG |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/VG.png) (m = 1-1/n) |van Genuchten, 1980|
|LN |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/LN.png) |Kosugi, 1996|
|FX |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/FX.png) |Fredlund and Xing, 1994|
|DB |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/DB.png) (m<sub>i</sub> = 1-1/n<sub>i</sub>) |Durner, 1994|
|BL |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/BL.png) |Seki, 2007|

h はサクション、 &theta; は体積含水率、
S<sub>e</sub> は
![equation](http://swrcfit.sourceforge.net/img/Se.png) で定義される水分、すなわち
![equation](http://swrcfit.sourceforge.net/img/Se2.png)、Q(x)は[標準正規分布関数](http://mathworld.wolfram.com/NormalDistributionFunction.html) &phi;(x)(誤差関数とは異なる)の余関数
Q(x)=1-&phi;(x) である。
FX モデルにおいて、e はネイピア数である。FXモデルは SWRC Fit のバージョン 3.0 以上で計算できる。修正関数はデフォルトではC(h)=1とされているが、変えることもできる。詳細は[計算の設定](setting.md)を参照。
他のパラメータは推定するパラメータである。

## 単峰性モデル (BC, VG, LN, FX)

* 土壌試料: Grenoble, France (UNSODA 4440)
* 土性: Sand
* 出典: Haverkamp and Parlange, 1986

![Figure](https://raw.githubusercontent.com/sekika/swrcfit-cgi/master/img/sample1.png)

## 二峰性モデル (DB, BL)

* 土壌試料: Lyss, Switzerland (UNSODA 2760)
* 土性: Silty loam
* 出典: Richard et al., 1983

![Figure](https://github.com/sekika/swrcfit-cgi/blob/master/img/sample2.png)

## 文献

1. Brooks, R. H., and Corey, A.T.: Hydraulic properties of porous media.
   Hydrol. Paper 3. Colorado State Univ., Fort Collins, CO, USA, 1964.
2. Durner, W.: Hydraulic conductivity estimation for soils with
   heterogeneous pore structure. Water Resour. Res., 30(2): 211--223, 1994.
3. Fredlund, D.G. and Xing, A.: Equations for the soil-water characteristic curve.
   Can. Geotech. J. 31: 521-532, 1994.
4. Kosugi, K.: Lognormal distribution model for unsaturated soil hydraulic
   properties. Water Resour. Res. 32(9), 2697--2703, 1996.
5. Seki, K. (2007) SWRC fit - a nonlinear fitting program with a water
   retention curve for soils having unimodal and bimodal pore structure.
   Hydrol. Earth Syst. Sci. Discuss., 4: 407-437.
6. van Genuchten, M.T.: A closed-form equation for predicting the hydraulic
   conductivity of unsaturated soils. Soil Sci. Soc. Am.  J. 44, 892--898,
   1980.

----
[SWRC Fit マニュアル](README.md)
