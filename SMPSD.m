function Result=SMPSD(I,De,Idn,changePoint)

Maxit=2000;
it=1;
while it<=Maxit
    t=1;flag=true;tic;
    while flag
        Error{t}=zeros(250,250);
        Error{t}=Simulator(I,changePoint,De,t); 
        TR=Seperator(Error{t});
        TR(:,2501)=normrnd(0,2.55,[25,1]);
        [p,tbl,stats]=anova1(TR,[],'off');
        
        if p>.005
            flag=true;
            t=t+1;
        elseif p<.005 && t<=changePoint
            t=t;
            flag=true;
        elseif p<.005 && t>changePoint
            RL(it)=t;
            
            %Fault Location detection
            p_Dunnet = dunnett(stats,[],2501);
            Regin=find(p_Dunnet(1:2500)<.005);
            
            if  isempty(Regin)
                [~,Regin]=min(p_Dunnet(1:2500));
            end
            Est250=Jointer(Regin);
            
            %Change Point Estimation
            for tt=1:RL(it)
                FF=find(Est250==1);
                Xbar(tt)=mean(Error{tt}(FF));
            end
            
            
            TTT=0;
            f=[];
            for tow=1:RL(it)
                XBarBar(tow)=(sum(Xbar(TTT+1:end)))/(RL(it)-TTT);
                f(tow)=(RL(it)-TTT)*((XBarBar(tow)-0)^2);
                TTT=TTT+1;
            end
            [~,Ch(it)]=max(f);
            Ch(it)=Ch(it)-(changePoint+1);
             T(it)=toc/(RL(it));
             %Sørensen?Dice coefficient caclulation
             dice(it) = 2*nnz(Idn&Est250)/(nnz(Est250) + nnz(Idn));
            clc;
            fprintf('After %d simulations:\n- Average Run Lenght= %6.4f \n- Mean of SDCS=%6.4f \n- Mean of difference in estimated and real Change Ponit= %6.4f \n- Mean of computational time=%6.4f',...
                it,mean(RL)-changePoint,mean(dice),mean(Ch),mean(T));
            it=it+1;
            break
        end
    end
    
end

Result=[mean(RL)-changePoint std(RL) median(Ch) mean(Ch) std(Ch) ...
        numel(find(Ch==0))/Maxit (numel(find(Ch<=2 &Ch>0 ))+numel(find(Ch>=-2 & Ch<0 )))/Maxit ...
        numel(find(Ch>2))/Maxit mean(dice) std(dice) mean(T)];
