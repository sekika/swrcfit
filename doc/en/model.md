# SWRC models

SWRC (soil water retention curve) models which is implemented in SWRC Fit is as follows.

|Model|Equation|Reference|
|-----|--------|---------|
|BC |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/BC.png) |Brooks and Corey, 1964|
|VG |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/VG.png) (m = 1-1/n) |van Genuchten, 1980|
|LN |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/LN.png) |Kosugi, 1996|
|FX |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/FX.png) |Fredlund and Xing, 1994|
|DB |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/DB.png) (m<sub>i</sub> = 1-1/n<sub>i</sub>) |Durner, 1994|
|BL |![equation](https://raw.githubusercontent.com/sekika/swrcfit-web/master/img/BL.png) |Seki, 2007|

where h is the suction head, &theta; is volumetric water content,
S<sub>e</sub> is the effective water content defined by
![equation](http://swrcfit.sourceforge.net/img/Se.png), i.e.,
![equation](http://swrcfit.sourceforge.net/img/Se2.png), and Q(x) is
the complementary cumulative normal distribution function, defined by
Q(x)=1-&phi;(x), in which &phi;(x) is a normalized form of the
cumulative normal distribution function. Please note that Q(x) is
different from error function. Other parameters are soil hydraulic
parameters to be optimized with swrcfit.

FX model is supported from version 3.0. Correction function of the FX model, C(h), is by default 1.
It can be changed by parameter setting. See [[Setting-file]] for detail.

## Unimodal models (BC, VG, LN and FX)

* Soil sample: Grenoble, France (UNSODA 4440)
* Texture: Sand
* Source: Haverkamp and Parlange, 1986

![Figure](https://raw.githubusercontent.com/sekika/swrcfit-cgi/master/img/sample1.png)

## Bimodal models (DB and BL)

* Soil sample: Lyss, Switzerland (UNSODA 2760)
* Texture: Silty loam
* Source: Richard et al., 1983

![Figure](https://github.com/sekika/swrcfit-cgi/blob/master/img/sample2.png)

## Reference

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
