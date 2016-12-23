%% ----------------------------PART (2)---------------------------------
a=2;       b=4; %Parameters
N=100;          Mtot=zeros(3,N);
for j=1:N
    n=20;
    U=zeros(1,n);
    for i=1:n
        U(i)=unifrnd(0,1);
    end
    tt=sqrt(1-(1-U).^(1/4)) ;
    BM=n/sum(tt.^a)-1;   %Estimator for method of moments
    W=zeros(1,20);
    for i=1:n
        W(i)=log(1-tt(i)^a);
    end
    BL=-n/sum(W);       %Estimator for MLE
    %Calcul of the mediane and the 3 estimators

    E1=quantile(tt,0.95);
    E2=(1-0.05^(1/BM))^(1/a);
    E3=(1-0.05^(1/BL))^(1/a);
    M=[E1 E2 E3];
    Mtot(:,j)=M ; 
end

% Boxplot et Histogram

figure
subplot(2,2,1)
hist(Mtot(1,:));
title('Matlab')
subplot(2,2,2)
hist(Mtot(2,:));
title('Method of moment')
subplot(2,2,3)
hist(Mtot(3,:));
title('MLE')

figure
boxplot([Mtot(1,:)',Mtot(2,:)',Mtot(3,:)'],{'Matlab','Method of moments','MLE'})
