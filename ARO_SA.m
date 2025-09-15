function [BestX,BestF,HisBestF]=ARO_SA(MaxIt,nPop,Low,Up,Dim,Train_Data,Train_Target,Test_Data,Test_Target)
   
PopPos=zeros(nPop,Dim);
PopFit=zeros(nPop,1);

for i=1:nPop
    PopPos(i,:)=rand(1,Dim).*(Up-Low)+Low;
    PopFit(i)=fitness(PopPos(i,:),Train_Data,Train_Target,Test_Data,Test_Target);
end

BestF=inf;
BestX=[];

for i=1:nPop
    if PopFit(i)<=BestF
        BestF=PopFit(i);
        BestX=PopPos(i,:);
    end
end

HisBestF=zeros(MaxIt,1);

for It=1:MaxIt
    mu=10^(200*It/MaxIt);
    Direct1=zeros(nPop,Dim);
    Direct2=zeros(nPop,Dim);
    theta=2*(1-It/MaxIt);
    for i=1:nPop
        L=(exp(1)-exp(((It-1)/MaxIt)^2))*(sin(2*pi*rand)); %Eq.(3)
        rd=ceil(rand*(Dim));
        Direct1(i,randperm(Dim,rd))=1;
        c=Direct1(i,:); %Eq.(4)
        R=L.*c; %Eq.(2)
        
        A=2*log(1/rand)*theta;%Eq.(15)

        if A>1

            K=[1:i-1 i+1:nPop];
            RandInd=K(randi([1 nPop-1]));
            newPopPos=PopPos(RandInd,:)+R.*( PopPos(i,:)-PopPos(RandInd,:))...
                +round(0.5*(0.05+rand))*randn; %Eq.(1)
        else

            Direct2(i,ceil(rand*Dim))=1;
            gr=Direct2(i,:); %Eq.(12)
            H=((MaxIt-It+1)/MaxIt)*randn; %Eq.(8)
            b=PopPos(i,:)+H*gr.*PopPos(i,:); %Eq.(13)
            newPopPos=PopPos(i,:)+ R.*(rand*b-PopPos(i,:)); %Eq.(11)

        end
        newPopPos=SpaceBound(newPopPos,Up,Low);
        newPopFit=fitness(newPopPos,Train_Data,Train_Target,Test_Data,Test_Target);
        if newPopFit<PopFit(i)
            PopFit(i)=newPopFit;
            PopPos(i,:)=newPopPos;
        end

    end

    for i=1:nPop
        if PopFit(i)<BestF
            BestF=PopFit(i);
            BestX=PopPos(i,:);
        end
    end

    for counter= 1: 20
        % Create Neighbourse   SA
        %         i=randi([1 PopSize],1,1);
        Delta = mu_inv(2*rand(1,Dim)-1,mu).*(Up - Low);
        Neighbourse = BestX + Delta;
        
        %==============================================
        % Make sure  each Neighbor is feasible
        
        Neighbourse(1,:) = max(Neighbourse(1,:), Low);
        Neighbourse(1,:) = min(Neighbourse(1,:), Up);
        
        %================================================
        CostNeighb = fitness(Neighbourse,Train_Data,Train_Target,Test_Data,Test_Target);
        if CostNeighb < BestF
            BestX = Neighbourse;
            BestF = CostNeighb;
        end
        
    end
    HisBestF(It)=BestF;
disp(['Itration = ' num2str(It) ]);
end

