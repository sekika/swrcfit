#!/usr/bin/octave -qf
# SWRC Fit - swrc.m
# URL: http://swrcfit.sourceforge.net/
# Author: Katsutoshi Seki
# Licence: GNU Public License
# Version: 1.2

# Read data from file
load swrc.txt
[s, i] = sort (swrc (:, 1));
sorted = swrc (i, :);
x=sorted(:,1); y=sorted(:,2);
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

# Set initial values
qs=qsin; qr=qrin;
hbi = sum (y > max(y) * 0.95 + min(y) * 0.05)+1;
hb=x(hbi); hby=(y(hbi)-qr)/(qs-qr);
if hb==0, hb=x(2)/10;, end
hli = sum (y > max(y) * 0.15 + min(y) * 0.85);
if hbi==hli; hli=hli+1;, end
hl=x(hli); hly=(y(hli)-qr)/(qs-qr);
lambda=-log(hly/hby)/log(hl/hb);
if lambda < 0.1, lambda=0.1;, end
if lambda > 10, lambda=10;, end

# Brooks and Corey Model
disp ("=== BC model ===");
x2 = x .+ (x == 0) .* 0.001;
function ret=BC(x,p)
  ret = (x > p(3)) .* (p(2)+(p(1)-p(2)).*(x./p(3)).^(-p(4))) + (x <= p(3)) .* p(1);
endfunction
function ret=BC2(x,p)
  ret = (x > p(3)) .* (abs(p(2))+(p(1)-abs(p(2))).*(x./p(3)).^(-p(4))) + (x <= p(3)) .* p(1);
endfunction

pin=[qs, qr, hb, lambda];
stol=1;
dp=[0.00001*cqs 0.001*cqr 0.1 0.01]; R2b=0;
while ( stol >= 0.00001 )
  if pqr==0
    [f,p,kvg,itr,corp,covp,covr,std,z,R2]=leasqr(x2,y,pin,"BC",stol,20,wt,dp);
  else
    [f,p,kvg,itr,corp,covp,covr,std,z,R2]=leasqr(x2,y,pin,"BC2",stol,20,wt,dp);
  end
  if kvg == 0, p=pin;, R2=R2b;, stol=0;, end
  stol=stol/10; pin=p; R2b=R2;
endwhile
if pqr==1, p(2)=abs(p(2));, end
qs=p(1), qr=p(2), hb=p(3), lambda=p(4), R2
if adv==1,
  CorrelationMatrix = corp
  StandardDeviation = sqrt(diag(covp))
end

# van Genuchten Model
disp ("=== VG model ===");
function ret=VG(x,p)
  n=abs(p(4))+1;
  ret = p(2)+(p(1)-p(2)).*(1+(abs(p(3)).*x).^n).^(1/n-1);
endfunction
function ret=VG2(x,p)
  n=abs(p(4))+1;
  ret = abs(p(2))+(p(1)-abs(p(2))).*(1+(abs(p(3)).*x).^n).^(1/n-1);
endfunction
qs=qsin; qr=qrin;
hm = x(sum(y > max(y)/2 + min(y)/2)+1);
alpha=1/hm; n=lambda+1;
if n < 1.1, n=1.1;, end
if n > 10, n=10;, end
pin=[qs, qr, alpha, n-1];
stol=1; dp=[0.00001*cqs 0.001*cqr 0.1 0.001]; R2b=0;
while ( stol >= 0.00001 )
  if pqr==0
    [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"VG",stol,20,wt,dp);
  else
    [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"VG2",stol,20,wt,dp);
  end
  if kvg == 0, p=pin;, R2=R2b;, stol=0;, end
  if imag(R2)^2>0, p=pin; R2=R2b;, stol=0;, end
  stol=stol/10; pin=p; R2b=R2;
endwhile
if pqr==1, p(2)=abs(p(2));, end
qs=p(1), qr=p(2), alpha=abs(p(3)), n=abs(p(4))+1, R2
if adv==1,
  CorrelationMatrix = corp
  StandardDeviation = sqrt(diag(covp))
end

# Lognormal Pore-Size Distribution Model of Kosugi
disp ("=== LN model ===");
function ret=LN(x,p)
  ret = p(2)+(p(1)-p(2)).*(1-normcdf((log(x/abs(p(3))))./abs(p(4))));
endfunction
function ret=LN2(x,p)
  ret = abs(p(2))+(p(1)-abs(p(2))).*(1-normcdf((log(x/abs(p(3))))./abs(p(4))));
endfunction
qs=qsin; qr=qrin; hm=1/alpha;
sigma=1.2*(n-1)^(-0.8);
if sigma < 0.15, sigma=0.15;, end
if sigma > 3, sigma=3;, end
pin=[qs, qr, hm, sigma];
stol=1; dp=[0.00001*cqs 0.0001*cqr 0.01 0.01]; R2b=0;
while ( stol >= 0.00001 )
  if pqr==0
    [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"LN",stol,20,wt,dp);
  else
    [f,p,kvg,itr,corp,covp,covr,std,Z,R2]=leasqr(x,y,pin,"LN2",stol,20,wt,dp);
  end
  if kvg == 0, p=pin;, R2=R2b;, stol=0;, end
  if imag(R2)^2>0, p=pin; R2=R2b;, stol=0;, end
  stol=stol/10; pin=p; R2b=R2;
endwhile
if pqr==1, p(2)=abs(p(2));, end
qs=p(1), qr=p(2), hm=abs(p(3)), sigma=abs(p(4)), R2
if adv==1,
  CorrelationMatrix = corp
  StandardDeviation = sqrt(diag(covp))
end
