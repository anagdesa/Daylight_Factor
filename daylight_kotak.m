% Coefficients:
  p1 = -2.8427e-11;
  p2 = 1.0344e-09;
  p3 = 2.7025e-08;
  p4 = -2.2873e-06;
  p5 = 5.7981e-05;
  p6 = -0.0007829;
  p7 = 0.0062284;
  p8 = -0.02933;
  p9 = 0.073446;
  p10 = -0.034915;
  p11 = 2.3669;
  
x = 1:0.265:17;  
ydf = p1*(x'.^10) + p2*(x'.^9) + p3*(x'.^8) + p4*x'.^7 + p5*x'.^6 + p6*x'.^5 + p7*x'.^4 + p8*x'.^3 + p9*x'.^2 + p10*x'.^1 + p11*x'.^0; 
kalibrasi = 1:1/0.61:100
% xdf = 
normdf = ydf - min(ydf(:));
normdf = normdf ./ max(normdf(:)); 

plot(kalibrasi,normdf)

total=normPalmer + normdf 
normtotal = total - min(total(:))
normtotal = normtotal ./ max(normtotal(:)) 
% 
% Norm of residuals = 
%      0.006554