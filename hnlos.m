function [Hnlos]=hnlos(nRx,nTx)
% Generate the NLOS component of the channel
    Hnlos = complex(randn(nRx,nTx),randn(nRx,nTx))*sqrt(0.5);
end    