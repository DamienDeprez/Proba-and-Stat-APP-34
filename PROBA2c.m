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
%% ----(c) Estimate the bias, the variance and the mean squared-----------
theta = 0.726;          %exact value of the estimator
B=[mean(Mtot(1,:))-theta;     %Calcul of the Bias of 3 estimators
    mean(Mtot(2,:))-theta;    
    mean(Mtot(3,:))-theta]

V=[var(Mtot(1,:));          %Calcul of the variance of the 3 estimators
    var(Mtot(2,:));
    var(Mtot(3,:))]

MSE=[B(1)^2+V(1);B(2)^2+V(2);B(3)^2+V(3)]
