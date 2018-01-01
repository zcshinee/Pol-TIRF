function [gradg, gradb]=gradientt(forward,img,psf,modulation)
angles=size(img,3);
temp=1-img./forward;
gradb=zeros(size(img,1),size(img,2));
for i=1:angles
   gradg(:,:,i)=modulation(i)*conv2(temp(:,:,i),psf,'full');
   gradb=gradb+modulation(i)*dct(dct(temp(:,:,i)')');
end

function result=fftconv(a,b)
s=abs(size(a,1)-size(b,1));
bfix=padarray(b,[s/2 s/2]);
fa=ft(a);
fb=ft(bfix);
fresult=fa.*fb;
result=ift(fresult);

function f=ft(a)
f = fftshift(fft2(fftshift(a)));

function f=ift(a)
f = ifftshift(ifft2(ifftshift(a)));