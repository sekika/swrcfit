#!/usr/bin/octave -qf
# SWRC Fit - bimodal.m
# URL: http://swrcfit.sourceforge.net/
# Author: Katsutoshi Seki
# License: GNU Public License
# Version: 1.2

# Read data from file
load swrc.txt
[s, i] = sort (swrc (:, 1));
sorted = swrc (i, :);
x=sorted(:,1);
y=sorted(:,2);
if columns(sorted)==2,
  wt=ones(length(y),1);
else
  wt=sorted(:,3);
end

# Setting
output_precision=7; # precision of the output
qsin = max(y); # initial value of qs
cqs=1; # cqs=1; qs is variable, cqs=0; qs is constant
qrin = min(y); # initial value of qr
cqr=1; # cqr=1; qr is variable, cqr=0; qr is constant
# qrin=0; cqr=0; # For setting qr=0 as a constant
pqr=1; # pqr=1; qr >= 0, pqr=0; qr can be negative
adv=0; # adv=1; advanced output; adv=0; normal output;

# Check if there are more than 7 points
if i < 8, disp("Too few points"), exit, end

# Bimodal model of Durner
disp ("=== DB model ===");

i = 3;
while (i < length(x)-1)
xi=x(1:i); yi=y(1:i);
qs=qsin; qr=min(yi);
S=(yi.-qr)./(qs-qr);
function ret=VG(x,p)
  ret = p(2)+(p(1)-p(2)).*((1+(abs(p(3)).*x).^(abs(p(4))+1)).^(1/(abs(p(4))+1)-1));
endfunction
hm = xi(sum (S > 0.5)+1);
alpha=1/hm; nn=1; pin=[1 0 alpha nn];
dp=[0 0 0.001 0.001]; stol=1; R2b=0;
wt2=ones(length(yi),1);
while ( stol >= 0.0001 )
  [f,p,kvg]=leasqr(xi,S,pin,"VG",0.01,20,wt2,dp);
  if kvg ==0, p=pin;, stol=0;, end
  stol=stol/10; pin=p;
endwhile
alpha1(i)=p(3); n1(i)=abs(p(4))+1;
y2=y.-(qs-qr).*(1+(alpha1(i).*x).^n1(i)).^(1./n1(i)-1);
hm = x(sum (S > 0.5)+1);
pin=[qr qrin 1/hm 1]; stol=1; 
dp=[0 0.0001*cqr 0.0001 0.0001]; R2b=0;
while ( stol >= 0.0001 )
  [f,p,kvg,itr,corp,covp,cov,std,Z,R2]=leasqr(x,y2,pin,"VG",stol,20,wt,dp);
  if kvg == 0, p=pin;, R2=R2b;, stol=0;, end
  if imag(R2)^2>0, p=pin; R2=R2b;, stol=0;, end
  stol=stol/10; pin=p; R2b=R2;
endwhile
alpha2(i)=real(p(3)); n2(i)=abs(real(p(4)))+1;
tr(i)=real(p(2)); w1(i)=(qs-qr)/(qs-tr(i));
R(i)=real(R2);
i++;
endwhile

# Set initial condition
[Rmax, i]=max(R);
pin=[qsin tr(i) w1(i) 1/alpha1(i) n1(i) 1/alpha2(i) n2(i)];

# Calculate
function ret=DB(x,p)
  n1=mod(abs(p(5)),49)+1; n2=mod(abs(p(7)),49)+1; w1=mod(p(3),1);
  ret = p(2)+(p(1)-p(2)).*(w1.*(1+(x./abs(p(4))).^n1).^(1/n1-1) + (1-w1).*(1+(x./abs(p(6))).^n2).^(1/n2-1));
endfunction
function ret=DB2(x,p)
  n1=mod(abs(p(5)),49)+1; n2=mod(abs(p(7)),49)+1; w1=mod(p(3),1);
  ret = abs(p(2))+(p(1)-abs(p(2))).*(w1.*(1+(x./abs(p(4))).^n1).^(1/n1-1) + (1-w1).*(1+(x./abs(p(6))).^n2).^(1/n2-1));
endfunction
stol=8; R2b=0;
dp=[0 0.001*cqr 0.001 0 0.01 0 0.01];
while ( stol >= 0.5 )
  [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"DB",stol,20,wt,dp);
  if kvg == 0, p=pin;, R2=R2b;, stol=0;, end
  if imag(R2)^2>0, p=pin; R2=R2b;, stol=0;, end
  stol=stol/4; pin=p; R2b=R2;
endwhile
stol=1; R2b=0;
dp=[0.000001*cqs 0.001*cqr 0.001 0.01 0.001 0.1 0.001];
while ( stol >= 0.00001 )
  if pqr==0
    [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"DB",stol,20,wt,dp);
  else
    [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"DB2",stol,20,wt,dp);
  end
  if kvg == 0, p=pin;, R2=R2b;, stol=0;, end
  if imag(R2)^2>0, p=pin; R2=R2b;, stol=0;, end
  stol=stol/8; pin=p; R2b=R2;
endwhile
if abs(p(4)) > abs(p(6))
  p=[p(1) p(2) 1-p(3) p(6) p(7) p(4) p(5)];
end
w1 = mod(p(3),1);
if pqr==1, p(2)=abs(p(2));, end
if (w1 > 0.01) * (w1 < 0.99)
  qs = p(1)
  qr = p(2)
  w1
  alpha(1) = 1/abs(p(4));
  alpha1=alpha(1)
  n(1) = mod(abs(p(5)),49)+1;
  n1=n(1)
 alpha(2) = 1/abs(p(6));
 alpha2=alpha(2)
 n(2) = mod(abs(p(7)),49)+1;
 n2=n(2)
  R2
  if adv==1,
    CorrelationMatrix = corp
    StandardDeviation = sqrt(diag(covp))
  end
else
  disp ("Not bimodal");
end

# Bimodal Lognormal model
disp ("=== BL model ===");

# Initial condition
qs=p(1); qr=p(2);
i=1;
while (i<3)
v=[-1:0.2:4]'; xx=10.^v; m=1-1/n(i); yy=(1.+(alpha(i).*xx).^n(i)).^(-m);
sigma=(n(i)-1)^(-2/3);
pin=[1 0 1/alpha(i) sigma];
wt3=ones(length(xx),1);
dp=[0 0 0.1 0.01];
function ret=LN(x,p)
  ret = p(2)+(p(1)-p(2)).*(1-normcdf((log(x/abs(p(3))))./abs(p(4))));
endfunction
function ret=LN2(x,p)
  ret = abs(p(2))+(p(1)-abs(p(2))).*(1-normcdf((log(x/abs(p(3))))./abs(p(4))));
endfunction
[f,p]=leasqr(xx,yy,pin,"LN",1,20,wt3,dp);
hm(i)=abs(p(3)); sigma(i)=abs(p(4));
i++;
endwhile
pin=[qs, qr, w1, hm(1), sigma(1), hm(2), sigma(2)];

# Calculate
function ret=BL(x,p)
  sigma1=mod(abs(p(5)),50)+0.05; sigma2=mod(abs(p(7)),50)+0.05; w1=mod(p(3),1);
  ret = p(2)+(p(1)-p(2)).*(w1.*(1-normcdf((log(x./abs(p(4)))./sigma1))) + (1-w1).*(1-normcdf((log(x./abs(p(6)))./sigma2))));
endfunction
function ret=BL2(x,p)
  sigma1=mod(abs(p(5)),50)+0.05; sigma2=mod(abs(p(7)),50)+0.05; w1=mod(p(3),1);
  ret = abs(p(2))+(p(1)-abs(p(2))).*(w1.*(1-normcdf((log(x./abs(p(4)))./sigma1))) + (1-w1).*(1-normcdf((log(x./abs(p(6)))./sigma2))));
endfunction
stol=8; R2b=0;
dp=[0.000001*cqs 0.05*cqr 0.0001 0.001 0.001 0.001 0.001];
while ( stol >= 0.00001 )
  if pqr==0
    [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"BL",stol,20,wt,dp);
  else
    [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"BL2",stol,20,wt,dp);
  end
  if kvg == 0, p=pin;, R2=R2b;, stol=0;, end
  if imag(R2)^2>0, p=pin; R2=R2b;, stol=0;, end
  stol=stol/8; pin=p; R2b=R2;
endwhile
if abs(p(4)) > abs(p(6))
  p=[p(1) p(2) 1-p(3) p(6) p(7) p(4) p(5)];
end

w1 = mod(p(3),1);
if pqr==1, p(2)=abs(p(2));, end
if (w1 > 0.01) * (w1 < 0.99) +1
  qs = p(1)
  qr = p(2)
  w1
  hm1 = abs(p(4))
  sigma1 = mod(abs(p(5)),50)+0.05
  hm2 = abs(p(6))
  sigma2 = mod(abs(p(7)),50)+0.05
  R2
  if adv==1,
    CorrelationMatrix = corp
    StandardDeviation = sqrt(diag(covp))
  end
else
  disp ("Not bimodal");
end

