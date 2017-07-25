syms z;

form =(1/1024)*((1024-z^-10)/(1-z^-1/2));

[symNum,symDen] = numden(form);

TFnum = sym2poly(symNum);    %Convert Symbolic num to polynomial
TFden = sym2poly(symDen);    %Convert Symbolic den to polynomial
ans =tf(TFnum,TFden);

[z,p,k] = tf2zp (TFnum,TFden) ;

% figure
% zplane(z,p)

[r,p,k] = residue(TFnum,TFden);
figure
semilogy ((step (ans)));
grid on


intime = iztrans  (form)