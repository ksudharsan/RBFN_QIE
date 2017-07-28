function [category] = init_center_quantum(X,y)
  mx=max(y);
  qbits=[];
  category=[];
  sz=size(X,2);
  if(size(unique(y))==1)
    qbits=[1.0/sqrt(2);1.0/sqrt(2);1.0/sqrt(2);1.0/sqrt(2)];
    category=[y(1,1);y(1,1)];
  else
    for i=1:mx
      X_c=X((y==i),:);
      if(size(X_c,1)==0)
        continue;
      end
      temp=[];
      category=[category;i];
      for j=1:sz
        temp=[temp,[1.0/sqrt(2);1.0/sqrt(2)]];
      end
      qbits=[qbits;temp];
    end
  end
  xlswrite("center_quantum.xlsx",qbits); 
end