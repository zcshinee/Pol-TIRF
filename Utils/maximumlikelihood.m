function mlh=maximumlikelihood(forward,img)
temp=forward-img.*log(forward);
mlh=sum(sum(sum(temp)));
