clc;clear;
I=double(rgb2gray(imread('Tile_250.jpg')));
[m,n]=size(I);
De=I;
changePoint=5;
Delta=5;

X11=1;X12=5;
Y11=1;Y12=5;

X21=30;X22=35;
Y21=30;Y22=35;
De(X11:X12,Y11:Y12)=De(X11:X12,Y11:Y12)+Delta;
De(X21:X22,Y21:Y22)=De(X21:X22,Y21:Y22)+Delta;

Idn=zeros(m,n);
Idn(X11:X12,Y11:Y12)=1;
Idn(X21:X22,Y21:Y22)=1;

Result=SMPSD(I,De,Idn,changePoint)

