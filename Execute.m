function LO=Execute(L,Xr,Yr)
[x, y] =meshgrid(Xr,Yr);
dL=zeros(size(x));
inRoom=dL;
[br,cl]=size(x);
wr=zeros(br,cl,3);
[b, c]=size(x);
for i=1:b
    [i b]
    for j=1:c
        [dL(i,j) ,inRoom(i,j) ,w]=HDF(L,x(i,j),y(i,j),0);
        wr(i,j,1)= w(1);
        wr(i,j,2)= w(2);
        wr(i,j,3)= w(3);
        
    end
end
L.dL=dL;
L.inRoom=inRoom;
L.x=x;
L.y=y;
L.wr=wr;
LO=L;
end