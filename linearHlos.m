

function [Hlos]=linearHlos(nRx,nTx)

    % Generate the angles of the users in [-pi/3, pi/3]
    angs=(rand(1,nRx)-0.5)*2*pi/3;
    % Generate the LOS component of the channel
    Hlos=meshgrid(-1i*pi*sin(angs))';
    Hlos=exp(Hlos*diag(0:nRx-1));
    Hlos=Hlos(:,1:nTx)./sqrt(nTx);

end