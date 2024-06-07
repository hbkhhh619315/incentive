%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sevices=10;%service
price=[];
ht=[];
i =1;
u=[0.25;0.5;0.75;1];%price range
while i <= sevices
    price = [price;u(randi(4))];
    i=i+1;
end

i =1;
v=[0.25;0.5;0.75;1];%ht range
while i <= sevices
    ht = [ht;v(randi(4))];
    i=i+1;
end

x = [];
y11= [];
y12= [];
y21= [];
y22= [];
y31= [];
y32= [];
y41= [];
y42= [];


a=0;
while a<=1.00 %α

    opt_aoi =[];
    i =1;
    while i <= sevices
        opt_aoi = [opt_aoi;0];
        i=i+1;
    end

    i_aoi =[];
    i =1;
    while i <= sevices
        i_aoi = [i_aoi;0];
        i=i+1;
    end

    p_aoi =[];
    i =1;
    while i <= sevices
        p_aoi = [p_aoi;0];
        i=i+1;
    end

    ph_aoi =[];
    i =1;
    while i <= sevices
        ph_aoi = [ph_aoi;0];
        i=i+1;
    end

    r_aoi =[];
    i =1;
    while i <= sevices
        r_aoi = [r_aoi;0];
        i=i+1;
    end


    if abs(a-0.01) < 0.001 %draw data
        account1 =[];
        i =1;
        while i <= sevices
            account1 = [account1;0];
            i=i+1;
        end
    end
    if abs(a-0.10) < 0.001 %draw data
        account2 =[];
        i =1;
        while i <= sevices
            account2 = [account2;0];
            i=i+1;
        end
    end
    if abs(a-0.50) < 0.001 %draw data
        account3 =[];
        i =1;
        while i <= sevices
            account3 = [account3;0];
            i=i+1;
        end
    end

    opt_maxaoi=0;
    i_maxaoi=0;
    p_maxaoi=0;
    ph_maxaoi=0;
    r_maxaoi=0;

    opt_totalaoi=0;
    i_totalaoi=0;
    p_totalaoi=0;
    ph_totalaoi=0;
    r_totalaoi=0;

    t=1;
    T=10000;%num of time t


    while t<=T %num of time t

        if mod(t,100)==0
            randIndex = randperm(size(price,1));

            price=price(randIndex,:);%The price of each node is reset every rounds

            randIndex = randperm(size(ht,1));
            ht=ht(randIndex,:);%The ht of each node is reset every round
        end

        [M,I] = max(opt_aoi);
        B=[I;M];
        opt_maxaoi = opt_maxaoi+B(2);%Cumulative opt maximum aoi

        k =1;
        while k <= sevices
            opt_totalaoi = opt_totalaoi+opt_aoi(k);%Cumulative opt overall aoi
            k=k+1;
        end

        j =1;
        while j <= sevices
            opt_aoi(j) = opt_aoi(j)+1;%Opt's Aoi overall +1
            j=j+1;
        end

        opt_aoi(B(1))=0;%After opt selects the service node, aoi is set to zero.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [M,I] = max(i_aoi);
        B=[I;M];
        i_maxaoi = i_maxaoi+B(2);% cumulative incentive maximum aoi

        compare=[];
        l =1;
        while l <= sevices
            compare=[compare;a*i_aoi(l)-price(l)-ht(l)];%Incentive Bidding
            l=l+1;
        end
        [M,I] = max(compare);
        B=[I;M];

        k =1;
        while k <= sevices
            i_totalaoi = i_totalaoi+i_aoi(k);% cumulative incentive overall aoi
            k=k+1;
        end

        j =1;
        while j <= sevices
            i_aoi(j) = i_aoi(j)+1;% Incentive aoi overall +1
            j=j+1;
        end

        i_aoi(B(1))=0;% Incentive to set aoi to zero after selecting service node

        if abs(a-0.01) < 0.001
            account1(B(1))=account1(B(1))+1;%Incentive statistics of the number of calls of each node
        end
        if abs(a-0.10) < 0.001
            account2(B(1))=account2(B(1))+1;%Incentive statistics of the number of calls of each node
        end
        if abs(a-0.50) < 0.001
            account3(B(1))=account3(B(1))+1;%Incentive statistics of the number of calls of each node
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [M,I] = max(p_aoi);
        B=[I;M];
        p_maxaoi = p_maxaoi+B(2);%Cumulative maximum aoi

        [M,I] = min(price);
        B=[I;M];

        k =1;
        while k <= sevices
            p_totalaoi = p_totalaoi+p_aoi(k);%Cumulative overall aoi
            k=k+1;
        end

        j =1;
        while j <= sevices
            p_aoi(j) = p_aoi(j)+1;%Aoi overall +1
            j=j+1;
        end

        p_aoi(I)=0;%After without selects the service node, aoi is set to zero.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [M,I] = max(ph_aoi);
        B=[I;M];
        ph_maxaoi = ph_maxaoi+B(2);% cumulative maximum aoi

        compare=[];
        l =1;
        while l <= sevices
            compare=[compare;price(l)+ht(l)];%Incentive Bidding
            l=l+1;
        end
        [M,I] = min(compare);
        B=[I;M];

        k =1;
        while k <= sevices
            ph_totalaoi = ph_totalaoi+ph_aoi(k);% cumulative overall aoi
            k=k+1;
        end

        j =1;
        while j <= sevices
            ph_aoi(j) = ph_aoi(j)+1;% aoi overall +1
            j=j+1;
        end

        ph_aoi(B(1))=0;% Incentive to set aoi to zero after selecting service node
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [M,I] = max(r_aoi);
        B=[I;M];
        r_maxaoi = r_maxaoi+B(2);% cumulative maximum aoi

        I=randi(10);

        k =1;
        while k <= sevices
            r_totalaoi = r_totalaoi+r_aoi(k);% cumulative overall aoi
            k=k+1;
        end

        j =1;
        while j <= sevices
            r_aoi(j) = r_aoi(j)+1;% aoi overall +1
            j=j+1;
        end

        r_aoi(I)=0;% Incentive to set aoi to zero after selecting service node
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        t=t+1;
    end

    x = [x;a] ;
    y11= [y11;1-opt_maxaoi/i_maxaoi];
    y12= [y12;1-opt_totalaoi/i_totalaoi];
    y21= [y21;1-opt_maxaoi/p_maxaoi];
    y22= [y22;1-opt_totalaoi/p_totalaoi];
    y31= [y31;1-opt_maxaoi/ph_maxaoi];
    y32= [y32;1-opt_totalaoi/ph_totalaoi];
    y41= [y41;1-opt_maxaoi/r_maxaoi];
    y42= [y42;1-opt_totalaoi/r_totalaoi];

    a=a+0.01;

end

figure(1)
account1=account1';
account2=account2';
account3=account3';
data = [account3;account2;account1];
b = bar3(data,0.7); %0.7Represents the width of a single column
colorbar %Z-axis numerical color bar
caxis([1,1500]); %Color bar value range
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
set(gca,'xticklabel',{'1','2','3','4','5','6','7','8','9','10'},'FontSize',30) %x coordinate axis scale value
set(gca,'yticklabel',{'\alpha=0.5','\alpha=0.1','\alpha=0.01'},'FontSize',30) %y coordinate axis scale value
zlim([0,1500]); %z coordinate axis scale value
hXLabel = xlabel('Relay Node n','Rotation',20,'Position',[3 6 4],'FontSize',50);
%hYLabel = ylabel('γ','Rotation',-40,'Position',[-1 2 0]);
hZLabel = zlabel('Times','Rotation',0,'Position',[-1.65 0 1000],'FontSize',50);
set(gca,'XGrid', 'off', 'YGrid', 'off','ZGrid', 'on')
%hTitle = title('Service Frequency of PoIs \{\beta=10\}');
%set(hTitle, 'FontSize', 50, 'FontWeight' , 'bold')

figure(2)
axis([0 1 0 1]);
set(gca,'XTick',[0:0.2:1],'FontSize',25) %x axis range 0-1, interval 0.2
set(gca,'YTick',[0:0.1:1],'FontSize',25) %y axis range 0-1, interval 0.1
axis square;
hold on;
% Add title and tags
%title('PoA');
xlabel('Reward Rate \alpha','FontSize',35);
ylabel('Price of Anarchy (PoA)','FontSize',35);

plot(x,y11,'-db',x,y21,'-sc',x,y31,'-hg',x,y41,'-om','linewidth',2,'MarkerSize',10); % linear, color, marker
legend('AMA of Incentive Strategy','AMA of Price Greedy','AMA of without Incentive','AMA of Random Strategy','FontSize',25);   % Upper right corner mark
grid on

figure(3)
axis([0 1 0 1]);
set(gca,'XTick',[0:0.2:1],'FontSize',25) %x axis range 0-1, interval 0.2
set(gca,'YTick',[0:0.1:1],'FontSize',25) %y axis range 0-1, interval 0.1
axis square;
hold on;
% Add title and tags
%title('PoA');
xlabel('Reward Rate \alpha','FontSize',35);
ylabel('Price of Anarchy (PoA)','FontSize',35);

plot(x,y12,'-db',x,y22,'-sc',x,y32,'-hg',x,y42,'-om','linewidth',2,'MarkerSize',10); % linear, color, marker
legend('ATA of Incentive Strategy','ATA of Price Greedy','ATA of without Incentive','ATA of Random Strategy','FontSize',25);   % Upper right corner mark
grid on