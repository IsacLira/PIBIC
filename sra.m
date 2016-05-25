function [subOptCapRCBA,minCorr,subOptCapSRA,Gop]= sra(H0,R,initialGroupSize,alpha)

%% Output and auxiliar variables
alphaSize=length(alpha);
subOptCapRCBA=zeros(alphaSize,1);
subOptCapSRA=zeros(alphaSize,1);
initialnRx=size(R,1);




%% For each alpha value
for k=1:alphaSize
    
    % Updates the variables with initial values
    groupSize=initialGroupSize; 
    capVector=zeros(1,groupSize);
   
    % Selects the suboptimal channels and calculate its capacities 
    [group]=getRCBA(alpha(k),R,initialGroupSize,H0);
    
    Hg=H0(group==1,:);
    subOptCapRCBA(k,1)=getCapacity(Hg);
    capVector(1)= subOptCapRCBA(k,1); 
   
    % Calculate the minimal correlation for alpha=0;
    if k==1
        minCorr=group'*R*group/2;        
    end
    
    % Decreases the group size and select the one with maximum capacity
    while(groupSize>1)
        % nRx=groupSize;   
        Rg=Hg*Hg';
        [~,indice]=max(sum(Rg));
        groupSize=groupSize-1;
        Hg(indice,:)=[];
        capVector(groupSize)=getCapacity(Hg);               
    end
    [subOptCapSRA(k,1),Gop]=max(capVector);
end

end