clear all;

%dirroot='/workspace/atnguyen/sv-mnt-nansen/MITgcm_latest/MITgcm/verification/1D_ocean_ice_column/'
dirroot='/home/atnguyen/nansen/MITgcm_latest/MITgcm/verification/1D_ocean_ice_column/'

runstr={'run_Ice5mSnow5m_SPoffFloodONSIsal0rhoSnow910albedo',...
        'run_Ice5mSnow5m_SPoffFloodONSIsal0rhoSnow910albedo_master'};

str={'dynstat_theta','seaice_heff','seaice_hsnow'};

for ir=2:2
  dirin=[dirroot runstr{ir} '/'];
  tmp=load([dirin str{1} '_max.txt']);l=length(tmp);
  a=zeros(l,3);for i=1:3;a(:,i)=load([dirin str{i} '_max.txt']);end;
  figure(1);clf;plot(1:l,a(:,1),'r.-',1:l,a(:,2),'b.-',1:l,a(:,3),'g.-',1:l,a(:,2)+a(:,3),'c.-');
   grid;legend('sst','heff','hsnow','heff+snow');title(runstr{ir},'interpreter','none');xlabel('time steps');
  set(gcf,'paperunits','inches','paperposition',[0 0 10 7]);fpr=[dirin 'sst_heff_hsnow.png'];print(fpr,'-dpng');
end;
