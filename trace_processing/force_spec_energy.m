Gprobe1 = [-1.2836   -1.4258   -1.4861   -1.5609   -1.6719   -2.1715   -2.3371];
Gprobe2 = [-0.5651   -0.5003   -0.4484   -0.5639   -0.6636   -0.6839   -0.7216];
G_bp = -3.9748;
%%
plot(Gprobe1-Gprobe2,'ko','MarkerSize',10,'LineWidth',2); hold on;
plot([0 8],[G_bp G_bp],'k','LineWidth',2)
xlim([0 8])
ylim([-5 1])
xticks([1 2 3 4 5 6 7])
xticklabels({'no circle','252','210','158','126','84','74'});
xlabel('Molecule Length (bp)');
ylabel('\DeltaG (kT units)')
axis square;
set(gca,'FontSize',14)
set(gca,'YGrid','on')
set(gca,'LineWidth',1.5);
title('Unbinding Energy');
legend('$\Delta G = -\ln(\frac{\tau_{u,p1}}{\tau_{b,p1}}) + \ln(\frac{\tau_{u,p2}}{\tau_{b,p2}})$','Interpreter','latex','FontSize',36)
set(gca, 'Units', 'normalized', 'Position', [0.1, 0.1,0.8,0.8]);
set(gcf,'Units','normalized','Position',[0.1,0.1,0.7,0.7])
set(gca,'FontSize',20);