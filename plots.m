function plots(alpha,capsRatio_11,capsRatio_12,capsRatio_21,capsRatio_22,)

figure;
plot(alpha,capsRatio_11,'bo-','MarkerSize',7,'LineWidth',1.3);
hold on;
plot(alpha,capsRatio_12,'ro-','MarkerSize',7,'LineWidth',1.3);
plot(alpha,capsRatio_21,'bsquare--','MarkerSize',7,'LineWidth',1.3);
plot(alpha,capsRatio_22,'rsquare--','MarkerSize',7,'LineWidth',1.3);
axis([0 1 0 1]);

legend('G=Nt=4, LOS','G=Nt=4, NLOS','G=Nt=8, LOS','G=Nt=8, NLOS');
title('RCBA');
xlabel('alpha');
ylabel('C90rcba/C90es');
% print('RCBAplot','-dpng');

figure;
plot(alpha,srRatio_11,'bo--','MarkerSize',7,'LineWidth',1.3);
hold on;
plot(alpha,srRatio_12,'ro--','MarkerSize',7,'LineWidth',1.3);
plot(alpha,srRatio_21,'bsquare--','MarkerSize',7,'LineWidth',1.3);
plot(alpha,srRatio_22,'rsquare--','MarkerSize',7,'LineWidth',1.3);
axis([0 1 0 1]);

legend('G=Nt=4, LOS','G=Nt=4, NLOS','G=Nt=8, LOS','G=Nt=8, NLOS');
title('RCBA-SRA');
xlabel('alpha');
ylabel('C90rcbasra/C90es');
% print('RCBASRAplot','-dpng');

figure
[f,x]=ecdf(corrRatio_11);
plot(x,100*f,'MarkerSize',7,'LineWidth',1.3);
hold on;
[f,x]=ecdf(corrRatio_12);
plot(x,100*f,'MarkerSize',7,'LineWidth',1.3);
axis([0.99 1.1 50 100]);

xlabel('alpha');
ylabel('CDF');


[f,x]=ecdf(corrRatio_21);
plot(x,100*f,'MarkerSize',7,'LineWidth',1.3);
[f,x]=ecdf(corrRatio_22);
plot(x,100*f,'MarkerSize',7,'LineWidth',1.3);
legend('G=Nt=4, LOS','G=Nt=4, NLOS','G=Nt=8, LOS','G=Nt=8, NLOS');
% print('CDFplot','-dpng');
end