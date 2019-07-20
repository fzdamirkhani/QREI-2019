clc;clear;
I=double(rgb2gray(imread('Tile_250.jpg')));
[m,n]=size(I);
De=I;
changePoint=5;
Delta=5;

R=10;
CX=50;CY=50;
Idn=zeros(m,n);
for i=1:250
    for j=1:250
        if ((i-CX)^2+(j-CY)^2<=(R^2))
            De(i,j)=De(i,j)+Delta;
            Idn(i,j)=1;
        end
    end
end

Result=SMPSD(I,De,Idn,changePoint)
