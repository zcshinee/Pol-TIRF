clear;
tic
load p_data;
%% parameter initialization
lambda1 = 0.05; lambda2= 20;iteration=201;% constant value adjusted with sample
L=0.13;% initial step 
xsize=size(img,1);ysize=size(img,2);angles=size(img,3);
avg=sum(sum(img,1),2)/xsize/ysize;
modulation=squeeze(avg/avg(1));
psizex=size(psf,1);psizey=size(psf,2);
exsize=xsize+psizex-1;eysize=ysize+psizex-1;
xkg=zeros(exsize,eysize,angles);xkb=zeros(xsize,ysize);%xkg: sample; xkb: noise
average=sum(sum(sum(img)))/xsize/ysize/angles;
xkb(1,1)=average*xsize;
ykp1g=xkg;ykp1b=xkb;
tkp1=1;
%% Fista iteration
for i=1:iteration
   disp(i);
   xkm1g=xkg;xkm1b=xkb;
   ykg=ykp1g;ykb=ykp1b;
   tk=tkp1;
   Forward_proj=forward(ykg,ykb,psf,modulation);%calculate miu
   mlh=maximumlikelihood(Forward_proj,img);%calculate likelihood
   [gradg,gradb]=gradientt(Forward_proj,img,psf,modulation);%calculate gradient
   for j=1:1000
       Ltest=L*1.05^(j-1);
       [xgtest,xbtest]=stepp(Ltest,ykg,ykb,gradg,gradb,lambda1,lambda2);
       newForward=forward(xgtest,xbtest,psf,modulation);
       newmlh=maximumlikelihood(newForward,img);
       quadratic=mlh+quadraticApprox(xgtest,xbtest,ykg,ykb,gradg,gradb,Ltest);%calculate quadratic approximation
       if newmlh<quadratic||newmlh==quadratic
           xkg=xgtest;xkb=xbtest;
           L=Ltest;
           mlh=newmlh;
           break;
       end
   end
   tkp1=(1+(1+4*tk^2)^0.5)/2;%update after one iteration
   temp=(tk-1)/tkp1;
   ykp1g=xkg+temp*(xkg-xkm1g);
   ykp1b=xkb+temp*(xkb-xkm1b);
end
imgRecon=xkg(psizex/2:psizex/2+xsize-1,psizey/2:psizey/2+ysize-1,:);
image=sum(imgRecon,3);
imgSave = uint16(image/max(image(:))*65535) ;
figure
imshow(sum(img,3),[]);
figure
imshow(imgSave, []);
toc