clc;
clear;
I=double(rgb2gray(imread('Tile_250.jpg')));
[m,n]=size(I);
changePoint=5;
Delta=[-10:-1,1:10];
%% The best-case scenario with two 5×5 fault size (Table 8)
X11=1; X12=5;
Y11=1; Y12=5;
X21=246; X22=250;
Y21=246; Y22=250;
for i=1:numel(Delta)
    De=I;
    De(X11:X12,Y11:Y12)=De(X11:X12,Y11:Y12)+Delta(i);
    De(X21:X22,Y21:Y22)=De(X21:X22,Y21:Y22)+Delta(i);
    Idn=zeros(m,n);
    Idn(X11:X12,Y11:Y12)=1;
    Idn(X21:X22,Y21:Y22)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Multi','(',num2str(Delta(i)),')_',num2str(X11),'_',num2str(X12),...
        '_',num2str(Y11),'_',num2str(Y12)','_',num2str(X21),'_',num2str(X22),...
        '_',num2str(Y21),'_',num2str(Y22),'.mat']
    save(filename,'Result')
end
%% The best-case scenario with two 10×10 fault size (Table 9)
X11=1; X12=10;
Y11=1; Y12=10;
X21=241; X22=250;
Y21=241; Y22=250;
for i=1:numel(Delta)
    De=I;
    De(X11:X12,Y11:Y12)=De(X11:X12,Y11:Y12)+Delta(i);
    De(X21:X22,Y21:Y22)=De(X21:X22,Y21:Y22)+Delta(i);
    Idn=zeros(m,n);
    Idn(X11:X12,Y11:Y12)=1;
    Idn(X21:X22,Y21:Y22)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Multi','(',num2str(Delta(i)),')_',num2str(X11),'_',num2str(X12),...
        '_',num2str(Y11),'_',num2str(Y12)','_',num2str(X21),'_',num2str(X22),...
        '_',num2str(Y21),'_',num2str(Y22),'.mat']
    save(filename,'Result')
end
%% The best-case scenario with two 15×15 fault size (Table 10)
X11=1; X12=15;
Y11=1; Y12=15;
X21=236; X22=250;
Y21=236; Y22=250;
for i=1:numel(Delta)
    De=I;
    De(X11:X12,Y11:Y12)=De(X11:X12,Y11:Y12)+Delta(i);
    De(X21:X22,Y21:Y22)=De(X21:X22,Y21:Y22)+Delta(i);
    Idn=zeros(m,n);
    Idn(X11:X12,Y11:Y12)=1;
    Idn(X21:X22,Y21:Y22)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Multi','(',num2str(Delta(i)),')_',num2str(X11),'_',num2str(X12),...
        '_',num2str(Y11),'_',num2str(Y12)','_',num2str(X21),'_',num2str(X22),...
        '_',num2str(Y21),'_',num2str(Y22),'.mat']
    save(filename,'Result')
end
%% The worst-case scenario with two 5×5 fault size (Table 11)
X11=3; X12=7;
Y11=3; Y12=7;
X21=243; X22=247;
Y21=243; Y22=247;
for i=1:numel(Delta)
    De=I;
    De(X11:X12,Y11:Y12)=De(X11:X12,Y11:Y12)+Delta(i);
    De(X21:X22,Y21:Y22)=De(X21:X22,Y21:Y22)+Delta(i);
    Idn=zeros(m,n);
    Idn(X11:X12,Y11:Y12)=1;
    Idn(X21:X22,Y21:Y22)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Multi','(',num2str(Delta(i)),')_',num2str(X11),'_',num2str(X12),...
        '_',num2str(Y11),'_',num2str(Y12)','_',num2str(X21),'_',num2str(X22),...
        '_',num2str(Y21),'_',num2str(Y22),'.mat']
    save(filename,'Result')
end
%% The worst-case scenario with two 10×10 fault size (Table 12)
X11=3; X12=12;
Y11=3; Y12=12;
X21=238; X22=247;
Y21=238; Y22=247;
for i=1:numel(Delta)
    De=I;
    De(X11:X12,Y11:Y12)=De(X11:X12,Y11:Y12)+Delta(i);
    De(X21:X22,Y21:Y22)=De(X21:X22,Y21:Y22)+Delta(i);
    Idn=zeros(m,n);
    Idn(X11:X12,Y11:Y12)=1;
    Idn(X21:X22,Y21:Y22)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Multi','(',num2str(Delta(i)),')_',num2str(X11),'_',num2str(X12),...
        '_',num2str(Y11),'_',num2str(Y12)','_',num2str(X21),'_',num2str(X22),...
        '_',num2str(Y21),'_',num2str(Y22),'.mat']
    save(filename,'Result')
end
%% The worst-case scenario with two 15×15 fault size (Table 13)
X11=3; X12=17;
Y11=3; Y12=17;
X21=233; X22=247;
Y21=233; Y22=247;
for i=1:numel(Delta)
    De=I;
    De(X11:X12,Y11:Y12)=De(X11:X12,Y11:Y12)+Delta(i);
    De(X21:X22,Y21:Y22)=De(X21:X22,Y21:Y22)+Delta(i);
    Idn=zeros(m,n);
    Idn(X11:X12,Y11:Y12)=1;
    Idn(X21:X22,Y21:Y22)=1;
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Multi','(',num2str(Delta(i)),')_',num2str(X11),'_',num2str(X12),...
        '_',num2str(Y11),'_',num2str(Y12)','_',num2str(X21),'_',num2str(X22),...
        '_',num2str(Y21),'_',num2str(Y22),'.mat']
    save(filename,'Result')
end


