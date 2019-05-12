function [df,DidalamRuang ,wr]=HDF(LI,x,y,z,NoJendela)
df =0;
wr=zeros(3,1);
DidalamRuang =1;
b= TitikDidalamRuang(LI.L,x,y,12);
if not(b)
    DidalamRuang=0;
    return;
end
if nargin<=4
    na=1;
    nb=length(LI.J);
else
    na=NoJendela;
    nb=NoJendela;
end
p1=[x;y;z;1];%koordinat dunia
if LI.Mode ==1
    for i=na:nb
        pa = LI.L(LI.J(i).LineId).ma*p1;% koordinat lokal
        x0= LI.J(i).OffsetX;
        z0= LI.J(i).OffsetZ;
        Lebar = LI.J(i).Lebar;
        Tinggi= LI.J(i).Tinggi;
        nL=fix(Lebar/LI.Step)+1;
        stL=Lebar/nL;    
        for nx = 0:nL-1;
            xx0=x0+nx*stL;
            p2=LI.L(LI.J(i).LineId).m*[xx0;0;0;1];%dalam koordinat dunia
            if GarisTidakTerhalang(LI,LI.J(i).LineId,p1,p2)==1
               df=df+HitungDaylightFaktor(xx0,z0,stL,Tinggi,pa(1),abs(pa(2)),pa(3));
           
            end
        end 
    end
elseif LI.Mode==2
    
    for i=na:nb
        pa = LI.L(LI.J(i).LineId).ma*p1;% koordinat lokal
        x0= LI.J(i).OffsetX;
        z0= LI.J(i).OffsetZ;
        Lebar = LI.J(i).Lebar;
        Tinggi= LI.J(i).Tinggi;
        nL=fix(Lebar/LI.Step)+1;
        stL=Lebar/nL;
        nT=fix(Tinggi/LI.Step)+1;
        stT =Tinggi/nT;
        for nx = 0:nL-1;
            xx0=x0+nx*stL;
            p2=LI.L(LI.J(i).LineId).m*[xx0;0;0;1];%dalam koordinat dunia
            if GarisTidakTerhalang(LI,LI.J(i).LineId,p1,p2)==1
                for  nz = 0:nT-1;
                    zz0=z0+nz*stT;
                    df=df+HitungDaylightFaktor(xx0,zz0,stL,stT,pa(1),abs(pa(2)),pa(3));
                end
            end
        end 
    end
    
    
    
elseif (mode==3) || (mode ==4 )
    for i=na:nb
        [tIm ,wIm]=size(LI.J(i).im);
        pa = LI.L(LI.J(i).LineId).ma*p1;% koordinat lokal
        x0= LI.J(i).OffsetX;
        z0= LI.J(i).OffsetZ;
        Lebar = LI.J(i).Lebar;
        if mode == 3 
          Tinggi= LI.J(i).Tinggi;
        elseif mode==4
          Tinggi = Lebar /wIm*tIm;
        end
        nL=fix(Lebar/LI.Step)+1;
        stL=Lebar/nL;
        nT=fix(Tinggi/LI.Step)+1;
        stT =Tinggi/nT;  
        for nx = 0:nL-1;
            xx0=x0+nx*stL;
            iw =fix(nx/nL*wIm)+1;
            if iw>wIm
                iw=wIm;
            end
            p2=LI.L(LI.J(i).LineId).m*[xx0;0;0;1];%dalam koordinat dunia
            if GarisTidakTerhalang(LI,LI.J(i).LineId,p1,p2)==1
                for  nz = 0:nT-1;
                    it =fix (nz/nT*tIm)+1;
                    if it>tIm
                        it = tIm;
                    end
                    if  LI.J(i).im(it,iw)>0.5
                      zz0=z0+nz*stT;
                      df=df+HitungDaylightFaktor(xx0,zz0,stL,stT,pa(1),abs(pa(2)),pa(3));
                    end
                end
            end
        end 
    end
end
wr=warna(df);
end
function w = warna(df)
ww(1) = 0; %hitam
ww(2) = 2; %biru 
ww(3) = 4;  
ww(4) = 5; 
ww(5) = 10;
wr=[0 0 0;
    0 0 1.0; 
    0 1.0 0;
    1.0 1.0 0;
    1.0 0 0];
n1= length(ww);
n2=n1;
for i =1 : length(ww)-1
    if ww(i) <=df && ww(i+1)>=df
        n1 =i;
        n2=i+1;
    end
end
if n1== n2
    w(1)=wr(n1,1);
    w(2)=wr(n1,2);
    w(3) = wr(n1,3);
    
else
    bg=(df-ww(n1))/(ww(n2)-ww(n1));
    r=bg*(wr(n2,1)-wr(n1,1))+wr(n1,1);
    g=bg*(wr(n2,2)-wr(n1,2))+wr(n1,2);
    b=bg*(wr(n2,3)-wr(n1,3))+wr(n1,3);
    w(1)=r;
    w(2)=g;
    w(3) = b;
    
end
end
function DL=HitungDaylightFaktor(x0,z0,lebar,tinggi,x,y,z)
DL=0;
x1=x0+lebar;
z1=z0+tinggi;
if z<=z0
    if x<=x0
        A=DF(z1-z,x1-x,y);
        B=DF(z1-z,x0-x,y);
        C=DF(z0-z,x1-x,y);
        D=DF(z0-z,x0-x,y);
        DL=A-B-C+D;
    elseif (x>=x1)
        A=DF(z1-z,x-x0,y);
        B=DF(z1-z,x-x1,y);
        C=DF(z0-z,x-x0,y);
        D=DF(z0-z,x-x1,y);
        DL=A-B-C+D;
    else
        A1=DF(z1-z,x-x0,y);
        B1=DF(z0-z,x-x0,y);
        A2=DF(z1-z,x1-x,y);
        B2=DF(z0-z,x1-x,y);
        DL=A1-B1+A2-B2;
    end
    
elseif z>z1
    if x<=x0
        A=DF(z-z0,x1-x,y);
        B=DF(z-z0,x0-x,y);
        C=DF(z- z1,x1-x,y);
        D=DF(z- z1,x0-x,y);
        DL=A-B-C+D;
    elseif (x>=x1)
        A=DF(z-z0,x-x0,y);
        B=DF(z-z0,x-x1,y);
        C=DF(z-z1,x-x0,y);
        D=DF(z-z1,x-x1,y);
        DL=A-B-C+D;
    else
        A1=DF(z-z0,x-x0,y);
        B1=DF(z-z1,x-x0,y);
        A2=DF(z-z0,x1-x,y);
        B2=DF(z-z1,x1-x,y);
        DL=A1-B1+A2-B2;
    end
else
    
end
if DL<0
    DL=0;
end
end
function df=DF(h,w,d)
r=sqrt(h^2+d^2);
df=1/(2*pi)*(atan2(w,d)-d/r*atan2(w,d))*100; %perkalian 100 buat apa?

%df=1/(2*pi)*((atan2(w,d)- 1/r*atan2(w,d)/r 
end
function b= TitikDidalamRuang(Li,x,y,nn)
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
            if TitikPadaGaris(p1 ,p2,xp,yp)
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
function TH=GarisTidakTerhalang(LI,LineID,pa,pb)
TH=1;
for i=1:length(LI.L)
    
    if (i~=LineID)
        pa1 =[LI.L(i).x1 ;LI.L(i).y1 ];
        pb1 =[LI.L(i).x2 ;LI.L(i).y2 ];
        [x ,y, d]=TitikPotongDuaGaris(pa,pb,pa1,pb1);
        if (d==1)
            b1 = TitikPadaGaris(pa,pb,x,y);
            b2=  TitikPadaGaris(pa1,pb1,x,y);
            if (b1==1)&&(b2==1)
                TH=0;
                return;
            end
            
        end
    end
end
end
function m = RotasiZ(sd,x,y)
m=[cos(sd) -sin(sd) x;sin(sd) cos(sd) y;0 0 1];
end
function [x,y,d]=TitikPotongDuaGaris(pA1,pA2,pB1,pB2)
[a1, b1 ,c1]=PersamaanGaris(pA1(1),pA1(2),pA2(1),pA2(2));
[a2, b2, c2]=PersamaanGaris(pB1(1),pB1(2),pB2(1),pB2(2));
d=a1*b2-a2*b1;
if abs(d)>0
    x=(b1*c2-b2*c1)/d;
    y=-(a1*c2-a2*c1)/d;
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
function b=TitikPadaGaris(p1,p2,x,y)
x1 = p1(1); y1 = p1(2);
x2 = p2(1); y2 = p2(2);
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

