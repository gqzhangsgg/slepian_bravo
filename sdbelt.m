function sdbelt
% SDBELT
%
% Simons & Dahlen (2006), Figure 2
% Plots spatial functions for double spherical polar cap
% for various angular orders with eigenvalue grey shading. 
%
% Last modified by fjsimons-at-alum.mit.edu, 28.09.2005

TH=30;
nth=128;
L=18; SN=6;
M=4;

clf
[ah,ha]=krijetem(subnum(M+1,SN));

for m=0:M
%  [E1,V1{m+1},th1,C1,ngl1,ngl2]=sdwcap2(TH,L,m,nth);
% Not this, since the last eigenfunctions are not to be trusted
  [E1,Vg{m+1},th1,C1,T1,V1{m+1}]=grunbaum2(TH,L,m,nth);
  % Switch eigenvalue
  V1{m+1}=1-V1{m+1};
  % Switch middle sign
  if E1(round(end/2),end)<0
    E1(:,end)=-E1(:,end);
  end
  E1m(m+1)=max(abs(E1(:)));
  for ondex=1:SN
    axes(ah(m*SN+ondex))
    pm(m+1,ondex)=plot(th1,E1(:,end-ondex+1),'-','Color',grey(6));
    hold on
    % Put on the black lines
    belt=[th1>TH]&[th1<180-TH];
    E1(belt,ondex)=NaN;
    pg(m+1,ondex)=plot(th1,E1(:,end-ondex+1),'-','Color','k');
    drawnow
  end
end

set(ah,'xlim',[0 180],'xtick',[ TH 90 180-TH],...
       'xgrid','on','ygrid','on','ylim',[-0.8 0.8]*max([E1m]))
nolabels(ah(1:end-SN),1)
nolabels(ha(M+2:end),2)
%nolabels(ha(1:M+1),2)
longticks(ah,1/2)

% Eigenvalue labels
nf=9;
for m=0:M
  for ondex=1:SN
    axes(ah(m*SN+ondex))
        t{m+1,ondex}=sprintf('%s = %9.6f','\lambda',V1{m+1}(end-ondex+1));
	if V1{m+1}(end-ondex+1)<0.975
	  lox='um';
	else
	  lox='um';
	end
	[bh(m+1,ondex),th(m+1,ondex)]=...
	    boxtex(lox,ah(m*SN+ondex),t{m+1,ondex},nf-1,[],0.85,1);
  end  
end
set(th,'FontS',nf-1)

for index=SN*M+1:SN*(M+1)
  axes(ah(index))
  deggies(ah(index),1)
  xl1(index)=xlabel(sprintf('colatitude %s','\theta'));
  % Remove the one but last label
%  xlab=get(ah(index),'xtickl'); xlab(end-1,:)=['    '];
%  set(ah(index),'xtickl',xlab);
end

for index=1:M+1
  serre(ah([1:SN]+(index-1)*SN),1/3)
  axes(ha(index))
  ylb(index)=ylabel(sprintf('m = %i',index-1));
end
% This only for landscape
for index=1:SN
  serre(ha([1:M+1]+(index-1)*(M+1)),1,'down')
end
%%%%%%%%%%%%%%%%%%%%%%

for index=1:SN
  axes(ah(index))
  tlb(index)=title(sprintf('%s = %i','\alpha',index));
end

set([pm(:) ; pg(:)],'LineW',1)

set([ah],'Fonts',nf)

fig2print(gcf,'landscape')

% set(gcf,'Color','w','Inv','off')
% shrink(ah,1,1/1.1)
shrink(ah,1,1.2)

figdisp 



