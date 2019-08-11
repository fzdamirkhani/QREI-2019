function Error=Simulator(I,changePoint,De,t)
[m,n]=size(I);
WN=normrnd(0,2.55,[m,n]);%generation of White Noise based on Normal Distribution
    if t<=changePoint
        Sim=I+WN;
    else
        Sim=De+WN;
    end
Error=Sim-I;
end
