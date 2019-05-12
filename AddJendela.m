function LO= AddJendela(LI,LineId,OffsetX,OffsetZ,Lebar,Tinggi,imTexture)
if nargin==0
    LO.L=[];
    LO.J=[];
elseif (nargin==1)
    LO=LI;
    LO.J=[];
else
    LO=LI;
    n=length(LO.J)+1;
    LO.J(n).LineId=LineId;
    LO.J(n).OffsetX=OffsetX;
    LO.J(n).OffsetZ=OffsetZ;
    LO.J(n).Tinggi =Tinggi;
    LO.J(n).Lebar =Lebar;
    LO.J(n).m=[];
    Lo.J(n).Texture=0;
    
    if nargin==7
        if ischar(imTexture)
            im=double(imread(imTexture));
        else
            if ~isdouble(imTexture)
                im=double(imTexture);
            else
                im=imTexture;
            end
        end
       n=ndims(im);
        if n>2
            im=rgb2gray(im);
        end
        im=im/max(max(im));
        LO.J(n).im =flipud(im);
        LO.J(n).Texture=1;
  
    end
end
end