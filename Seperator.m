function TR=Seperator(Error)
    [m,n]=size(Error);
    k=0;
        for ii=1:(m/5)
            for jj=1:(n/5)
                k=k+1;
                Roi{ii,jj}=Error(5*ii-4:5*ii,5*jj-4:5*jj);
                TR(:,k)=Roi{ii,jj}(:);
            end
        end
end