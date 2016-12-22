%% ----------------------(e) Create an histogram--------------------------
a=2;       b=4; %Parameters
theta = 0.726;          %exact value of the estimator
N=100;        n=[20 100 300];       Mtot=zeros(3,N);
for j=1:3
    
    for k=1:N
        U=zeros(1,n(j));
        for i=1:n(j)
            U(i)=unifrnd(0,1);
        end
        tt=sqrt(1-(1-U).^(1/4)) ;
        W=zeros(1,n(j));
        for i=1:n(j)
            W(i)=log(1-U(i)^a);
        end
        BL=-n(j)/sum(W);       %Estimator for MLE
        E3=(1-0.05^(1/BL))^(1/a);
        Mtot(:,k)=sqrt(n(j))*(E3-theta);
    end
end
figure
subplot(1,3,1)
hist(Mtot(1,:))
title('n=20')
subplot(1,3,2)
hist(Mtot(2,:))
title('n=100')
subplot(1,3,3)
hist(Mtot(3,:))
title('n=300')


