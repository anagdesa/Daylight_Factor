function LO = SetMode(LI ,mode,v)
if nargin==1
    mode = 1;
    v = 1;
elseif nargin==2
    v = 1;
end
LO =LI;
LO.Mode = mode;
LO.Step =v;
end