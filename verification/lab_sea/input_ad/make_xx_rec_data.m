clear all;
nx=20;ny=16;

dirin='./input_ad/';

%make time-dependent sst data:
a=readbin([dirin 'labsea_SST_fields'],[nx ny 14],1,'real*8');
ap=-9999.*ones(nx,ny,10);ap(:,:,end)=a(:,:,1);
writebin([dirin 'labsea_SST_fields_t10'],ap,1,'real*8');

ap=-9999.*ones(nx,ny,5);ap(:,:,end)=a(:,:,1);
writebin([dirin 'labsea_SST_fields_t4'],ap,1,'real*8');

%now fake non-zero xx to verify reproduction of the fw run
xxp=0.1:0.05:1.1;	%21 records, just make a long record
xx=zeros(nx,ny,length(xxp));
for i=1:length(xxp);
  xx(:,:,i)=xxp(i).*ones(nx,ny);
end;

%write out the controls (not the effective, but i'm going to use
%noscaling in data.ctrl to make sure this is the same as effective.)
writebin([dirin 'xx_atemp.0000000001.data'],xx,1,'real*8');
