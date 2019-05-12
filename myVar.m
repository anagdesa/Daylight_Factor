function v = myVar(d)
m=mean(d(:));
v=1/(length(d(:))-1)* sum((d(:)-m ).^2);