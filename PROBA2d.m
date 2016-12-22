%% ---------------(d)Repeat the calculations in (c)-----------------------
a=2;       b=4; %Parameters
n=[40 60 80 100 150 200 300 400 500];
N=9;          Mtot=zeros(3,N);          Btot=zeros(3,N);
Vtot=zeros(3,N);        MSEtot=zeros(3,N);

for j=1:N
    U=zeros(1,n(j));
    for i=1:n(j)
        U(i)=unifrnd(0,1);
    end
    tt=sqrt(1-(1-U).^(1/4)) ;
    BM=n(j)/sum(tt.^a)-1;   %Estimator for method of moments
    W=zeros(1,n(j));
    for i=1:n(j)
        W(i)=log(1-U(i)^a);
    end
    tt=sqrt(1-(1-U).^(1/4)) ;
    BL=-n(j)/sum(W);       %Estimator for MLE
    %Calcul of the mediane and the 3 estimators
    
    E1=quantile(tt,0.95);
    E2=(1-0.05^(1/BM))^(1/a);
    E3=(1-0.05^(1/BL))^(1/a);
    M=[E1 E2 E3];
    Mtot(:,j)=M ;
    
    B=[mean(Mtot(1,:))-theta;     %Calcul of the Bias of 3 estimators
        mean(Mtot(2,:))-theta;
        mean(Mtot(3,:))-theta];
    
    V=[var(Mtot(1,:));          %Calcul of the variance of the 3 estimators
        var(Mtot(2,:));
        var(Mtot(3,:))];
    
    MSE=[B(1)^2+V(1);B(2)^2+V(2);B(3)^2+V(3)];
       
    Btot(:,j)=B;
    Vtot(:,j)=V;
    MSEtot(:,j)=MSE;
end
Btot(1,:)
    figure
    subplot(1,3,1)
    plot(n,Btot(1,:),'b',n,Btot(2,:),'r',n,Btot(3,:),'g');
    title('Bias')
    subplot(1,3,2)
    plot(n,Vtot(1,:),'b',n,Vtot(2,:),'r',n,Vtot(3,:),'g');
    title('Variance')
    subplot(1,3,3)
    plot(n,MSEtot(1,:),'b',n,MSEtot(2,:),'r',n,MSEtot(3,:),'g');
    title('MSE')
 