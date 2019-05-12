function b= PointInPoligon(Li,x,y,nn)
if nargin<=3
nn=36;
end

nn=nn+mod(nn-1,2);
g=zeros(nn,2);
n=0;
for teta = 0:2*pi/nn:2*pi-pi/8
    m = RotasiZ(teta,x,y);
    Jumlah=0;
    for i=1:length(Li)
        p1 =m\[ Li(i).x1;Li(i).y1;1];
        p2 =m\[ Li(i).x2;Li(i).y2;1];
        [xp,yp,dp]=TitikPotongDuaGaris(p1,p2,[ 0 0],[1 0]);
        if (dp>0) &&(xp>0)
            if TitikPadaGaris(p1(1) ,p1(2),p2(1),p2(2),xp,yp)
                Jumlah=Jumlah+1;
            end
        end
    end;
        n=n+1;

    g(n,mod(Jumlah,2)+1) =g(n,mod(Jumlah,2)+1) +1; 
    
end
ngn=sum(sum(g(:,1)>g(:,2)));
ngj=sum(sum(g(:,1)<g(:,2)));

b = ngn<=ngj;
end
function m = RotasiZ(sd,x,y)
m=[cos(sd) -sin(sd) x;sin(sd) cos(sd) y;0 0 1];
end
function [x, y,d]=TitikPotongDuaGaris(pA1 ,pA2,pB1,pB2)
[a1, b1 ,c1]=PersamaanGaris(pA1(1),pA1(2),pA2(1),pA2(2));
[a2, b2, c2]=PersamaanGaris(pB1(1),pB1(2),pB2(1),pB2(2));
d=a1*b2-a2*b1;
if abs(d)>0
    x=(b1*c2-b2*c1)/d;
    y=(a1*c2-a2*c1)/d;
    d=1;
else
    x=0;
    y=0;
    d=0;
end
end
function [a,b,c]=PersamaanGaris(x1,y1,x2,y2)
%(x-x1)/(x2-x1)=(y-y1)/(y2-y1);
%(x-x1)(y2-y1)=(y-y1)(x2-x1);
%(x-x1)(y2-y1)+(y-y1)(x1-x2)=0;
a=y2-y1;
b=x1-x2;
c=-x1*a-y1*b;
end
function b=TitikPadaGaris(x1,y1,x2,y2,x,y)
v1=[x2-x1 y2-y1 0];
v2 =[x-x1 y-y1 0];
b=1;
r1 =norm(v1);
r2 =norm(v2);
if r2>r1
    b=0;
else
    if dot(v1,v2)<0
        b=0;
    end
end
end