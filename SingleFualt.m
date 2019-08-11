clc;
clear;
I=double(rgb2gray(imread('Tile_250.jpg')));
[m,n]=size(I);
changePoint=5;
Delta=[-10:-1,1:10];
%% The best-case scenario with a 5×5 fault size (Table 2)
X1=1;X2=5;
Y1=1;Y2=5;
for i=1:numel(Delta)
    De=I;
    De(X1:X2,Y1:Y2)=De(X1:X2,Y1:Y2)+Delta(i);
    Idn=zeros(m,n);
    Idn(X1:X2,Y1:Y2)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Single','(',num2str(Delta(i)),')_',num2str(X1),'_',num2str(X2),...
        '_',num2str(Y1),'_',num2str(Y2),'.mat']
    save(filename,'Result')
end
%% The best-case scenario with a 10×10 fault size (Table 3)
X1=1;X2=10;
Y1=1;Y2=10;
for i=1:numel(Delta)
    De=I;
    De(X1:X2,Y1:Y2)=De(X1:X2,Y1:Y2)+Delta(i);
    Idn=zeros(m,n);
    Idn(X1:X2,Y1:Y2)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Single','(',num2str(Delta(i)),')_',num2str(X1),'_',num2str(X2),...
        '_',num2str(Y1),'_',num2str(Y2),'.mat']
    save(filename,'Result')
end
%% The best-case scenario with a 15×15 fault size (Table 4)
X1=1;X2=15;
Y1=1;Y2=15;
for i=1:numel(Delta)
    De=I;
    De(X1:X2,Y1:Y2)=De(X1:X2,Y1:Y2)+Delta(i);
    Idn=zeros(m,n);
    Idn(X1:X2,Y1:Y2)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Single','(',num2str(Delta(i)),')_',num2str(X1),'_',num2str(X2),...
        '_',num2str(Y1),'_',num2str(Y2),'.mat']
    save(filename,'Result')
end
%% The worst-case scenario with a 5×5 fault size (Table 5)
X1=3;X2=7;
Y1=3;Y2=7;
for i=1:numel(Delta)
    De=I;
    De(X1:X2,Y1:Y2)=De(X1:X2,Y1:Y2)+Delta(i);
    Idn=zeros(m,n);
    Idn(X1:X2,Y1:Y2)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Single','(',num2str(Delta(i)),')_',num2str(X1),'_',num2str(X2),...
        '_',num2str(Y1),'_',num2str(Y2),'.mat']
    save(filename,'Result')
end
%% The worst-case scenario with a 10×10 fault size (Table 6)
X1=3;X2=12;
Y1=3;Y2=12;
for i=1:numel(Delta)
    De=I;
    De(X1:X2,Y1:Y2)=De(X1:X2,Y1:Y2)+Delta(i);
    Idn=zeros(m,n);
    Idn(X1:X2,Y1:Y2)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Single','(',num2str(Delta(i)),')_',num2str(X1),'_',num2str(X2),...
        '_',num2str(Y1),'_',num2str(Y2),'.mat']
    save(filename,'Result')
end
%% The worst-case scenario with a 15×15 fault size (Table 7)
X1=3;X2=17;
Y1=3;Y2=17;
for i=1:numel(Delta)
    De=I;
    De(X1:X2,Y1:Y2)=De(X1:X2,Y1:Y2)+Delta(i);
    Idn=zeros(m,n);
    Idn(X1:X2,Y1:Y2)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Single','(',num2str(Delta(i)),')_',num2str(X1),'_',num2str(X2),...
        '_',num2str(Y1),'_',num2str(Y2),'.mat']
    save(filename,'Result')
end
