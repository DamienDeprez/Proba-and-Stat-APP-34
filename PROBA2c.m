%% -----------------------1(f)----------------------------
a=2;       b=4; %Parameters
n=20;
U=zeros(1,n);
for i=1:n
    U(i)=unifrnd(0,1);
end
tt=sqrt(1-(1-U).^(1/4)) ;

u=mean(tt);
Med=median(tt);
V=var(tt);
IQR=iqr(tt);
cv=sqrt(V)/u;
%% ----(c) Estimate the bias, the variance and the mean squared-----------
theta = 0.726;          %exact value of the estimator
B=[mean(Mtot(1,:))-theta;     %Calcul of the Bias of 3 estimators
    mean(Mtot(2,:))-theta;    
    mean(Mtot(3,:))-theta]

V=[var(Mtot(1,:));          %Calcul of the variance of the 3 estimators
    var(Mtot(2,:));
    var(Mtot(3,:))]

MSE=[B(1)^2+V(1);B(2)^2+V(2);B(3)^2+V(3)]