function [corrRatio,capsRatioRCBA,capRatioSRA]=getRatios(nRx,nTx,groupSize,riceFactor,alpha)

% Number of samples
numSamples=1000;

%% Output variables
subOptCapVectorRCBA=zeros(length(alpha),numSamples);
capsRatioRCBA=zeros(1,length(alpha));
subOptCapVecSRA=zeros(length(alpha),numSamples);
capRatioSRA=zeros(1,length(alpha));
maxCap=zeros(1,numSamples);
maxGCap=zeros(1,numSamples);
subOptCorrVectorRCBA=zeros(1,numSamples); % Vector of suboptimal correlations
optCorr=zeros(length(alpha),numSamples);  % Vector of optimal correlations
corrRatio=zeros(1,numSamples);            % Vector of correlation ratios

%% For each sample
for n=1:numSamples
    
    [Hlos]=linearHlos(nRx,nTx);
    %[Hlos]=planarHlos(nRx,nTx);
    [Hnlos]=hnlos(nRx,nTx);
    % Generate the channel matrix H
    H=(riceFactor/(1+riceFactor))*Hlos + (1/(1+riceFactor))*Hnlos;
    R=getCorrelationMatrix(H);
    % Perfoms an exhaustive search for the group with 
    [maxCap(n),maxGCap(n),optCorr]=es(H,R,groupSize);    
    [subOptCapVectorRCBA(:,n),subOptCorrVectorRCBA(n),subOptCapVecSRA(:,n),~]= sra(H,R,groupSize,alpha);
    corrRatio(n)=subOptCorrVectorRCBA(n)/optCorr;
    
end
%% Compare the capacities obtained by SAR, RCBA and ES algorithms
capRatioSRA=prctile(subOptCapVecSRA' ,90)/prctile(maxCap,90);
capsRatioRCBA=prctile(subOptCapVectorRCBA',90)/prctile(maxGCap,90);
end
