function forward_proj=forward(img,noise,psf,modulation)
angles=size(img,3);
a=size(psf,1)/2;
b=size(noise,1);
forward_proj=zeros(size(noise,1),size(noise,2),angles);
for i=1:angles
%     temp1=fftconv(img(:,:,i),psf);
    temp1=conv2(img(:,:,i),psf,'same');
    temp2=modulation(i)*(temp1(a:a+b-1,a:a+b-1)+idct(idct(noise')'));
    forward_proj(:,:,i)=max(temp2,10^-6);
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