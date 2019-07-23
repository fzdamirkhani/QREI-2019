# A Novel Framework for Spatiotemporal Monitoring and Post-Signal Diagnosis of Processes with Image Data
Farzad Amirkhani, Amirhossein Amiri

## Introduction 
The spread of emerging technologies and advances in measuring devices has led to an increase in the amount of data obtained from manufacturing systems in recent years . For instance, the use of sensors and machine vision systems in the manufacturing companies has led to a massive amount of data, which extracting information from this data and exploiting them effectively is one of the most fundamental challenges of data science and statistical process control.  
The codes in this repository are presented to monitor image data based on control charts and to estimate the change point in case of receiving an out-of-control alarm. 

## Codes
After pre-processing steps such as removing the background and transforming to a greyscale image, the `Tile_250.jpg` in repository is resized from 3264×2448 pixels to 250×250 pixels, and it is considered as the nominal image. To simulate captured images, white noise based on a normal distribution with a mean of *μ*=0 and *σ*=2.55 is added to the nominal image. In the case of having real images from the production line, *μ* and *σ* should be estimated based on Phase I studies.
In simulation study single, multiple and circular defects are imposed at a specific part of image and the performance of proposed method is evaluated as well. This repository includes three .m files for this aim, namely **SingleFault.m**, **MultiFault.m**, and **CircularFault.m**. The first six line of these files are same as below: 
~~~
clc;clear;
I=double(rgb2gray(imread('Tile_250.jpg')));
[m,n]=size(I);
De=I;
changePoint=5;
Delta=5;
~~~
In above mentioned codes, after initialization, which include `clc` and `clear` commands, the image entitiled **Tile_250.jpg** is read and converted from RGB to grayscale form and saved as `I`, then its sizes are saved as `m` and `n`. 

`De` matrix is created based on the `I` matrix, and in the next steps the shift in intensity values at given coordinates are imposed to it as defective image. The change point and the shift in intensity values are set equal to 5. (which can be changed based on simulation purpose.)

### The SingleFault.m file 
This .m file is used to generate a defect with specific dimension at the specific part of image. The location of defect is  determined in the image with its coordinates, that is X1, X2, Y1 and Y2 (Here, `X1=1`, `X2=5`, `Y1=1`, `Y2=5` is considered as an instance), and shift in intensity value `Delta` is imposed to specified part of image.
`Idn`  is a matrix in which the pixels with defective parts takes 1, and at the other locations it takes 0. this variable is used to calculate similarity dice index in next parts of code.
~~~
X1=1;X2=5;
Y1=1;Y2=5;
De(X1:X2,Y1:Y2)=De(X1:X2,Y1:Y2)+Delta;
Idn=zeros(m,n);
Idn(X1:X2,Y1:Y2)=1;
~~~
### The MultipleFault.m file 
This code is simillar to **SingleFault.m** , the only difference is that in this code, instead of creating single defect, two defects are imposed to image in different parts of the it.

~~~
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
~~~
### The CircularFault.m file 
In this .m file, a circular defect with center cooardinate of (CX,CY) and radius of R is imposed to image.
~~~
R=10;
CX=125;CY=125;
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
~~~

### The SMPSD file 
This function gets the `I`,`De`,`Idn`, and `changePoint` values and return `Result` value as below:
~~~
function Result=SMPSD(I,De,Idn,changePoint)
~~~
Two loops are needed to calculate average run lenght(**ARL**), the inner loop calculates the run lenght based on simulaton for one iteration, and  the outer loop repeat inner loop based on the value of `Maxit` to calculate the mean of performance measures in defferent iterations. At each outer loop  the value of `t` set equal to 1, and `flag` is set equal to true.
~~~~
Maxit=2000;
it=1;
while it<=Maxit
    t=1;flag=true;
    while flag
~~~~
At the next lines of code, the `Error` matrix is generated based on **Simulator** function. The `Error` matrix with dimnention of 250 * 250 is seperated to 5 * 5 square regins and then converted to 1 * 25 vectors in **Seperator** function to be used in ANOVA.
The control level is also created to be compared with regins in the image based on dunnett's test.
~~~
        Error{t}=zeros(250,250);
        Error{t}=Simulator(I,changePoint,De,t);
        TR=Seperator(Error{t});
        TR(:,2501)=normrnd(0,2.55,[25,1]);
~~~
ANOVA is applied on `TR` values, Three conditions are possible to happen based on the result:
1. if p-value>.005, the process is in control, so flag set equal to true and run lenght is added by 1.
2. if p<.005 and t<changePoint, we have false alarm rate and the last iteration in inner loop must be repeated.
3. if p<.005 and t>changePoint, the process is out of control. In such a case, run length of iteration is saved as `RL(it)` and Post-Signal Diagnosis of Process is applied on data.At the end, the it value is added by 1 and the inner loop is terminated by `break`.
~~~
        [p,tbl,stats]=anova1(TR,[],'off');
        
        if p>.005
            flag=true;
            t=t+1;
        elseif p<.005 && t<=changePoint
            t=t;
            flag=true;
        elseif p<.005 && t>changePoint
            RL(it)
~~~
In order to detect the location of fault in the image Dunnet's test is utulized.For this aim, the **Dunnett** M file written by **Navin Pokala** is used which is available [here](https://www.mathworks.com/matlabcentral/fileexchange/38157-dunnett-m/). Then the regins which are detected as defective part are stored as `Regin`. In the case that the `Regin` variable was empty, the regin with minimum p-value is considered as defective part in the image.

~~~
            p_Dunnet = dunnett(stats,[],2501);
            Regin=find(p_Dunnet(1:2500)<.005);
            if  isempty(Regin)
                [~,Regin]=min(p_Dunnet(1:2500));
            end
~~~~

The Jointer function reshape the `Regin` variable to a 250*250 matrix,that is `Est250`.            
~~~~           
            Est250=Jointer(Regin);
~~~~

the change point of process is estimated based on MLE method, as below:       
~~~
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
            Ch(it)=Ch(it)-6;
~~~~~
At the last part of code the performance measures such as ARL, estimated change point and Sørensen–Dice coefficient is calculated and saved in the `Result` variable.
~~~~            
            dice(it) = 2*nnz(Idn&Est250)/(nnz(Est250) + nnz(Idn));
            clc;
            fprintf('The Current ARL = %6.4f,changepoint=%6.4f,SDCS=%6.4f, after %d simulations when delta =%6.4f',mean(RL)-5,mean(Ch),mean(dice),it,Delta);
            
            it=it+1;
        end
    end 
end

Result=[mean(RL)-changePoint
    std(RL) median(Ch) mean(Ch) std(Ch) numel(find(Ch==0))/Maxit (numel(find(Ch<=2 &Ch>0 ))+numel(find(Ch>=-2 & Ch<0 )))/Maxit  ...
    numel(find(Ch>2))/Maxit mean(dice) std(dice)];
 ~~~~~
### The Simulator.mat file 
This function gives intensity values of Nominal image (`I`), intensity values of image with fault (`De`), `change point` and `t` and generates the `Error` matrix as a result.
~~~~ 
function Error=Simulator(I,changePoint,De,t)
[m,n]=size(I);
%generation of White Noise based on Normal Distribution
WN=normrnd(0,2.55,[m,n]);
    if t<=changePoint
        Sim=I+WN;
            else
        Sim=De+WN;
    end
Error=Sim-I;
end 
~~~~
 
### The Seperator.mat file 
The purpose of using this m file is to separate the image into 5 * 5 squares and then convert them into vectors. It gets `Error` matrix as input and gives `TR` matrix as a result.
~~~~
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
~~~~
### The Jointer.mat file 
This code gets `Regin` matrix as input and gives `Est250` matrix as a result.
~~~
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
~~~

## Simulation study
The simulation study is conducted for 120 testing conditions (2 fault locations as the best- and the worst-case scenarios, 3 fault dimensions, and 20 intensity shifts) in the case of having one fault in the image, and the results are compared to those reported by Koosha et al.13 in Tables 2 to 7. The results in which the proposed approach is superior are highlighted in these tables to facilitate comparison by readers. 

| **SingleFault.m**  |          5 * 5         |          10 * 10         |         15 * 15          |
|--------------------|----------------------|------------------------|------------------------|
| Best case senario  | X1=1, X2=5, Y1=1, Y2=5 | X1=1, X2=10, Y1=1, Y2=10 | X1=1, X2=15, Y1=1, Y2=15 |
| worst case senario | X1=3, X2=7, Y1=3, Y2=7 | X1=3, X2=12, Y1=3, Y2=12 | X1=3, X2=17, Y1=3, Y2=17 |
