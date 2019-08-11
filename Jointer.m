function Est250=Jointer(Regin)
Est50=zeros(50,50);
Est50(Regin)=1;
Est250=zeros(250,250);
    for ii=1:50
        for jj=1:50
            Est250(5*ii-4:5*ii,5*jj-4:5*jj)=Est50(ii,jj);
        end
    end
end