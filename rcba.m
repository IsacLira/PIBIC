function [subOptCap,minCorr,minCorrCont]=rcba(H,R, alpha, groupSize)

%% Output variables 
subOptCap=zeros(length(alpha),1);
minCorr=zeros(length(alpha),1);
nRx=size(R,1);

%% Generate the 
N=zeros(1,nRx);
for i = 1:nRx
    N(i)=1./norm(H(i,:),2);
end
N=diag(N);
for i= 1:length(alpha)
    R1=R*(1-alpha(i))/norm(R,'fro');
    f=alpha(i)*N/norm(N);
    [group, minCorrAux]=quadprog(R1,f,[],[],ones(1,nRx),groupSize,zeros(nRx,1),ones(nRx,1));
    [~, idx] = sort(group, 'descend');
    group(idx(1:groupSize)) = 1;
    group(idx(groupSize+1:nRx))= 0;
    if i==1
        minCorr=group'*R*group/2;
        minCorrCont = minCorrAux;
    end
      
    subOptCap(i,1)=getCapacity(group,H);
    
end

end