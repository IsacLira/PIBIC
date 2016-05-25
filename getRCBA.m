function [group]=getRCBA(alpha,R,groupSize,H0)

%% Build a diagonal matrix N with the norms of channels
nRx=size(R,1);
for i = 1:nRx
    aux(i)=1./norm(H0(i,:),2);
end

N = diag(aux);
normN=norm(N,'fro');
normR=norm(R,'fro');

%% Aplies the convex quadratic algorithm

Ralpha=R*(1-alpha)/normR;
f=alpha*diag(N)/normN;
group=quadprog(Ralpha,f,[],[],ones(1,nRx),groupSize,zeros(nRx,1),ones(nRx,1));
[~, idx] = sort(group, 'descend');
% Transforms the real solution 'group' in an integer vector
group(idx(1:groupSize)) = 1;
group(idx(groupSize+1:nRx)) = 0;

end