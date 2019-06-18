function [Ain,Vin,pass]=PM_tester(t,AP,VP)
pass=1;
%Test inputs of Ain
if t==50 || t==150 || t==220 || t==500 || t==1210 || t==1860 || t==2420 || t==3600 || t==3610 || t==3620 || t==3630 || t==3640 || t==4350 || t==4800 || t==5550
    Ain=1;
else
    Ain=0;
end

%Test inputs of Vin
if t==169 || t==330 || t==3730 || t==3900 || t==4100 || t==4300 || t==4500
    Vin=1;
else
    Vin=0;
end

if t-1==731
    if VP==1
        
    else
        pass=0;
        return;
    end
end
% Evaluating PM outputs -- 2
if t-1==1361
    if VP==1
        
    else
        pass=0;
        return;
    end
end
% Evaluating PM outputs -- 3
if t-1==2011
    if VP==1
        
    else
        pass=0;
        return;
    end
end
% Evaluating PM outputs -- 4
if t-1 ==2571
    if VP==1
        
    else
        pass=0;
        return;
    end
end
% Evaluating PM outputs -- 5
if t-1 == 3422
    if AP==1
        
    else
        pass=0;
        return;
    end
end
% Evaluating PM outputs -- 6
if t-1==3572
    if VP==1
        
    else
        pass=0;
        return;
    end
end
% Evaluating PM outputs -- 7
if t-1==5501
    if VP==1
        
    else
        pass=0;
        return;
    end
end