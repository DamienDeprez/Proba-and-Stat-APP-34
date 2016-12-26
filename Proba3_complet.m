function part3(alpha0,beta0,choice)
% Main function for part 3 of our APP
% For the report, we use alpha0=2 and beta0=4
% Choose choice = 1,2,3,... to get the plots for questions a,b,c,.. respectively

    n=[20 40 60 80 100 150 200 300 400 500];   N=100;   % Paramters
    Mtot=zeros(3,length(n));        Btot=zeros(3,length(n));
    Vtot=zeros(3,length(n));        MSEtot=zeros(3,length(n));
    theta = (1-0.05^(1/beta0))^(1/alpha0); % q_0.95
    option = optimoptions('fsolve','Display','none');
    count = 0;

    for k = 1:length(n)
        for j=1:N

            U=zeros(1,n(k));    % Creation of a sample
            for i=1:n(k)
                U(i)=unifrnd(0,1);
            end
            tt=sqrt(1-(1-U).^(1/4)) ;
            
            xM = fsolve(@(xM) myFunaMBM(xM,n(k),tt),[alpha0,beta0],option);   % Finding alphas, betas
            xL = fsolve(@(xL) myFunaLBL(xL,n(k),tt),[alpha0,beta0],option);
            aM = xM(1);  BM = xM(2);    aL = xL(1); BL = xL(2);

            qs=quantile(tt,0.95);   % Finding the 3 different estimators
            qm=(1-0.05^(1/BM))^(1/aM);
            qL=(1-0.05^(1/BL))^(1/aL);
            M=[qs qm qL];
            Mtot(:,j)=M;
        end
        
            if (k==1 && choice==1)	% Displays values for question a)
                fprintf('qs = %d ; qm = %d ; qL = %d \n',Mtot(1,1),Mtot(2,1),Mtot(3,1)); 
            end
            
            if (k==1 && choice==2) % Make some plots for question b)
                figure
                subplot(1,3,1)
                hist(Mtot(1,:));
                title('Matlab')
                subplot(1,3,2)
                hist(Mtot(2,:));
                title('Method of moment')
                subplot(1,3,3)
                hist(Mtot(3,:));
                title('MLE')
                figure
                boxplot([Mtot(1,:)',Mtot(2,:)',Mtot(3,:)'],{'Matlab','Method of moments','MLE'})
            end
            
            
            if choice == 5 && (k==1 || k==5 || k==8) % Make some plots for question e)
                Y = sqrt(n(k))*(Mtot(3,:)-theta);
                count = count + 1;
                str = sprintf('n = %d',n(k));
                subplot(1,3,count);
                hist(Y);
                title(str);
            end
            
            B=[mean(Mtot(1,:))-theta;	% Finding the biases for each k
                mean(Mtot(2,:))-theta;
                mean(Mtot(3,:))-theta];

            V=[var(Mtot(1,:));	% Finding the variances for each k
                var(Mtot(2,:));
                var(Mtot(3,:))];

            MSE=[B(1)^2+V(1);B(2)^2+V(2);B(3)^2+V(3)];  % Finding the resulting MSE
            
            if (k==1 && choice==3)  % Displays values for question c)
                fprintf('qs :   Bias = %d ; Var = %d ; MSE = %d \n',B(1),V(1),MSE(1));
                fprintf('qm :   Bias = %d ; Var = %d ; MSE = %d \n',B(2),V(2),MSE(2));
                fprintf('qL :   Bias = %d ; Var = %d ; MSE = %d \n',B(3),V(3),MSE(3));
            end

            Btot(:,k)=B; % Adding the results to our final table
            Vtot(:,k)=V;
            MSEtot(:,k)=MSE;
    end
    
    if (choice==4)  % Make some plots for question d)
        subplot(1,3,1)  
        plot(n,Btot(1,:),'b',n,Btot(2,:),'r',n,Btot(3,:),'g');
        title('Bias')
        subplot(1,3,2)
        plot(n,Vtot(1,:),'b',n,Vtot(2,:),'r',n,Vtot(3,:),'g');
        title('Variance')
        subplot(1,3,3)
        plot(n,MSEtot(1,:),'b',n,MSEtot(2,:),'r',n,MSEtot(3,:),'g');
        title('MSE')
    end
end

function F = myFunaMBM(x,n,tt)
% Equations of question 2b
    sum1=0; sum2=0;
    for i=1:n
        sum1 = sum1 + tt(i)^(2*x(1));
        sum2 = sum2 + tt(i)^x(1);
    end
    F(1) = sum1 * (n+sum2) * sum2^(-2) - 2;
    F(2) = x(2) - (n / sum2) +1;
end

function F = myFunaLBL(x,n,tt)
% Equations of question 2c
    sum1=0; sum2=0; sum3=0;
    for i=1:n
        sum1 = sum1 + log(1-tt(i)^x(1));
        sum2 = sum2 + tt(i)^x(1)*log(tt(i))/(1-tt(i)^x(1));
        sum3 = sum3 + log(tt(i));
    end
    F(1) = 1/x(1) + (1/sum1+1/n) * sum2 + (1/n)*sum3;
    F(2) = x(2)* sum1 + n;
end