function [centers]=InitCentersUsingQ(X,y,Category)
  
  no_of_centers=size(Category,1);
  rand_val=rand(no_of_centers,size(X,2));
  center_quantum=xlsread("center_quantum.xlsx");
  center_bit=zeros(size(center_quantum));
  centers=[];
  
  for i=1:no_of_centers
    X_curr=X((y==Category(i)),:);
    X_max=max(X_curr);
    X_min=min(X_curr);
    X_avg=X_max.-X_min;
    X_avg=X_avg./4;
    temp=[];
    for j=1:size(X,2)
      decimal=1;
      if(rand_val(i,j)<center_quantum(2*i-1,j)^2)
        decimal=decimal+2;
        center_bit(i,j)=1;
      end
      if(rand_val(i,j)<center_quantum(2*i,j)^2)
        decimal=decimal+1;
        center_bit(i,j)=1;
      end
      temp=[temp,X_min(1,j)+X_avg(1,j)*(decimal-1+rand(1,1))];
    end
    centers=[centers;temp];
  end
  
  xlswrite("center_bits.xlsx",center_bit);
  
end