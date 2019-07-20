clc;clear;
I=double(rgb2gray(imread('Tile_250.jpg')));
[m,n]=size(I);
De=I;
changePoint=5;
Delta=5;

X1=1;X2=5;
Y1=1;Y2=5;
De(X1:X2,Y1:Y2)=De(X1:X2,Y1:Y2)+Delta;
Idn=zeros(m,n);
Idn(X1:X2,Y1:Y2)=1;

Result=SMPSD(I,De,Idn,changePoint)

