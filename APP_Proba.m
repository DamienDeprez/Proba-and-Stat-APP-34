%% -------------------------APP:PROBA-------------------------------------
a=2;       b=4; %Parameters

%% -----------------------(f)----------------------------

n=20;
U=zeros(1,20*j);
for i=1:20*j
    U(i)=unifrnd(0,1);
end
tt=sqrt(1-(1-U).^(1/4)) ;

u=sum(tt)/20*j;
Med=median(tt);
V=var(tt);
IQR=iqr(tt);
cv=sqrt(V)/u;

%% ------------------------(g)---------------------------
N=500;
A=zeros(5,N);
for j=1:N
    U=zeros(1,20*j);

    for i=1:20*j
        U(i)=unifrnd(0,1);
    end
    tt=sqrt(1-(1-U).^(1/4)) ;
    
    u=mean(tt);
    Med=median(tt);
    V=var(tt);
    IQR=iqr(tt);
    cv=sqrt(V)/u;
    Aa=[u Med V IQR cv];
    A(:,j)=Aa;
end
xx=(20:20:10000);
figure
subplot(2,3,1)
plot(xx,A(1,:));
title('Mean')
subplot(2,3,2)
plot(xx,A(2,:));
title('Median')
subplot(2,3,3)
plot(xx,A(3,:));
title('Variance')
subplot(2,3,4);
plot(xx,A(4,:));
title('IQR')
subplot(2,3,5);
plot(xx,A(5,:));
title('cv')