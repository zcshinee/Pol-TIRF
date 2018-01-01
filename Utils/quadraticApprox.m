function qa=quadraticApprox(xg,xb,ykg,ykb,gradg,gradb,L)
deltag=xg-ykg;
deltab=xb-ykb;
tempg=gradg.*deltag+L/2*deltag.^2;
tempb=gradb.*deltab+L/2*deltab.^2;
qa=sum(sum(sum(tempg)))+sum(sum(tempb));