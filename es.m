function [maxCap,maxGCap,minCorr]=es(H,R,groupSize)

%% Get the number of transmit and receive antennas
nTx = size(H, 2);
nRx = size(R, 1);

	
if ~exist('groups', 'var')
    persistent groups;
    persistent numGroups;
    groups=dec2bin(1:2^nRx-1);
    groups=reshape(bin2dec(groups(:)),2^nRx-1,nRx)';
    groups(:, sum(groups) > nTx) = [];
    numGroups=size(groups,2);
end
capValues=zeros(groupSize,numGroups);


%% Find the group of size groupSize that has minimum correlation
% Filters only the groups of size groupSize from groups
y = groups(:, sum(groups) == groupSize);
% Calculate the total correlation for these groups and gets the index of the one
% with minimum correlation
minCorr = min(diag(y'*(R)*y))/2;
%minCorr=y'*triu( R-diag(diag(R)) )*y;

for j=1:groupSize
    auxGroups=groups(:, sum(groups) == j);
    cont=size(auxGroups,2);
    for i=1:cont
         Hg=H(auxGroups(:,i)==1, :);
         capValues(j,i)=getCapacity(Hg);
        
    end
end

maxCap=max(capValues(:));
maxGCap=max(capValues(groupSize,:));

end