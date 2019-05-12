a = 1:0.0605:7      
ypalmer = (-0.033333*(a'.^5))+(-0.068182*(a'.^4))+(8.2576*(a'.^3))+ (-64.417*(a'.^2)) + (162.29*(a'.^1))+  (-86*(a'.^0))
xt = 1:100
 %Normalisasi Palmer
normPalmer = ypalmer %- min(ypalmer(:))
normPalmer = normPalmer ./ max(normPalmer(:)) 

plot (normPalmer)
 
 
 