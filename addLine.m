function LO=addLine(LI,x1,y1,x2,y2)
if nargin==0
    LO.J=[];
    LO.L=[];
    LO.Mode = 1;
elseif nargin==1
    LO=LI;
    LO.L=[];
else
    LO=LI;
    n=length(LO.L)+1;
    LO.L(n).x1=x1;
    LO.L(n).y1=y1;
    LO.L(n).x2=x2;
    LO.L(n).y2=y2;
    vx=[x2-x1 y2-y1 0];
    vx=vx/norm(vx);
    vz =[0 0 1];
    vy=cross(vz,vx);
    LO.L(n).m=[vx(1) vy(1) vz(1) x1;vx(2) vy(2) vz(2) y1;vx(3) vy(3) vz(3) 0; 0 0 0 1];
    LO.L(n).ma = inv(LO.L(n).m);
end
end



