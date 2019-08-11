clc;
clear;
I=double(rgb2gray(imread('Tile_250.jpg')));
[m,n]=size(I);
changePoint=5;
Delta=[-10:-1,1:10];
%% Circular fault with a radius of 5 (Table 14)
R=5;
CX=50;CY=50;
for i=1:numel(Delta)
    De=I;
    Idn=zeros(m,n);
    for ii=1:m
        for jj=1:n
            if ((ii-CX)^2+(jj-CY)^2<=(R^2))
                De(ii,jj)=De(ii,jj)+Delta(i);
                Idn(ii,jj)=1;
            end
        end
    end
    
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Circular','(',num2str(Delta(i)),')_',num2str(CX),'_',num2str(CY),...
        '_',num2str(R),'.mat']
    save(filename,'Result')
end
%% Circular fault with a radius of 10 (Table 15)
R=10;
CX=50;CY=50;
for i=1:numel(Delta)
    De=I;
    Idn=zeros(m,n);
    for ii=1:m
        for jj=1:n
            if ((ii-CX)^2+(jj-CY)^2<=(R^2))
                De(ii,jj)=De(ii,jj)+Delta(i);
                Idn(ii,jj)=1;
            end
        end
    end
    
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Circular','(',num2str(Delta(i)),')_',num2str(CX),'_',num2str(CY),...
        '_',num2str(R),'.mat']
    save(filename,'Result')
end
%% Circular fault with a radius of 15 (Table 16)
R=15;
CX=50;CY=50;
for i=1:numel(Delta)
    De=I;
    Idn=zeros(m,n);
    for ii=1:m
        for jj=1:n
            if ((ii-CX)^2+(jj-CY)^2<=(R^2))
                De(ii,jj)=De(ii,jj)+Delta(i);
                Idn(ii,jj)=1;
            end
        end
    end
    
    Result=SMPSD(I,De,Idn,changePoint)
    filename=['Result-Circular','(',num2str(Delta(i)),')_',num2str(CX),'_',num2str(CY),...
        '_',num2str(R),'.mat']
    save(filename,'Result')
end