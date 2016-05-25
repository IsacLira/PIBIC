function [R]=getCorrelationMatrix(H)
% Calculate spatial correlation matrix
R=H*H';
R=abs(diag(1./sqrt(diag(R)))*R*diag(1./sqrt(diag(R))));
% Regularizes spatial correlation matrix
R = R - min(0, min(eig(R)))*eye(size(R));

end