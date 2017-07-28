function [kmat]=get_kmat(X,centers)

  lambda=0.5;
  kmat=zeros(size(X,1),size(centers,1));
  sum=zeros(1,size(X,2));
  for i=1:size(X,1)
    sum=sum.+X(i,:);
  end
  sum=sum./size(X,1);
  x_mean=sum;
  eu_dist=euclidean(x_mean,X);
  sigma_sq=max(eu_dist)/lambda;
  
  for i=1:size(X,1)
    for j=1:size(centers,1)
      kmat(i,j)=exp(-1*euclidean(X(i,:),centers(j,:))/sigma_sq);
    end
  end

end