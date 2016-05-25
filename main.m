% clc;
close all;
clear all;

 % color = {'bo--', 'rsquare--', 'kx--','go--', 'yh--','c+--'};


 %% Parameters
nRx=16;

%case 1: LOS, groupSize=nTx=4
nTx=4; groupSize=4; riceFactor=10;
  alpha=0:0.1:1;
[corrRatio_11,capsRatio_11,srRatio_11]=getRatios(nRx,nTx,groupSize,riceFactor,alpha);

%case 2: NLOS, groupSize=nTx=4
riceFactor=0;
[corrRatio_12,capsRatio_12,srRatio_12]=getRatios(nRx,nTx,groupSize,riceFactor,alpha);

%case 3: LOS, groupSize=nTx=8
nTx=8; groupSize=8;riceFactor=10;
[corrRatio_21,capsRatio_21,srRatio_21]=getRatios(nRx,nTx,groupSize,riceFactor,alpha);

%case 2: NLOS, groupSize=nTx=8
riceFactor=0;
[corrRatio_22,capsRatio_22,srRatio_22]=getRatios(nRx,nTx,groupSize,riceFactor,alpha);

 save('vars2');

%% Plots
load('vars2')
figure;
plot(alpha,capsRatio_11,'bo--','MarkerSize',7,'LineWidth',1.3);
hold on;
plot(alpha,capsRatio_12,'bsquare--','MarkerSize',7,'LineWidth',1.3);
plot(alpha,capsRatio_21,'ro-','MarkerSize',7,'LineWidth',1.3);
plot(alpha,capsRatio_22,'rsquare--','MarkerSize',7,'LineWidth',1.3);
axis([0 1 0 1]);

legend('groupSize=Nt=4, LOS','groupSize=Nt=4, NLOS','groupSize=Nt=8, LOS','groupSize=Nt=8, NLOS');
title('RCBA');
xlabel('alpha');
ylabel('C90rcba/C90es');
% prinTx('RCBAplot','-dpng');

figure;
plot(alpha,srRatio_11,'bo-','MarkerSize',7,'LineWidth',1.3);
hold on;
plot(alpha,srRatio_12,'bsquare--','MarkerSize',7,'LineWidth',1.3);
plot(alpha,srRatio_21,'ro--','MarkerSize',7,'LineWidth',1.3);
plot(alpha,srRatio_22,'rsquare--','MarkerSize',7,'LineWidth',1.3);
axis([0 1 0 1]);

legend('groupSize=Nt=4, LOS','groupSize=Nt=4, NLOS','groupSize=Nt=8, LOS','groupSize=Nt=8, NLOS');
title('RCBA-SRA');
xlabel('alpha');
ylabel('C90rcbasra/C90es');
% prinTx('RCBASRAplot','-dpng');

figure
[f,x]=ecdf(corrRatio_11);
plot(x,100*f,'--','MarkerSize',7,'LineWidth',1.3);
hold on;
[f,x]=ecdf(corrRatio_12);
plot(x,100*f,'--','MarkerSize',7,'LineWidth',1.3);
axis([0.99 1.1 50 100]);

xlabel('alpha');
ylabel('CDF');


[f,x]=ecdf(corrRatio_21);
plot(x,100*f,'--','MarkerSize',7,'LineWidth',1.3);
[f,x]=ecdf(corrRatio_22);
plot(x,100*f,'MarkerSize',7,'LineWidth',1.3);


legend('groupSize=Nt=4, LOS','groupSize=Nt=4, NLOS','groupSize=Nt=8, LOS','groupSize=Nt=8, NLOS');
% prinTx('CDFplot','-dpng');




