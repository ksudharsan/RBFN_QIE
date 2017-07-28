function [d] = euclidean(X, Y)
           S=size(Y,1);
           d=zeros(S,1);
           for i=1:S
              d(i)=sum((X.-Y(i,:)).^2);     
           end
end