function [new_centers]=GetCenters(kmat,mem_mat,X,centers,m)

  new_centers=zeros(size(centers,1),size(X,2));
  
  for j=1:size(centers,1)
    num=zeros(1,size(X,2));
    for i=1:size(X,1)
      num=num.+X(i,:).*(mem_mat(j,i)^m*kmat(i,j));
    end
    den=0;
    for i=1:size(X,1)
      den=den+(mem_mat(j,i)^m*kmat(i,j));
    end
    new_centers(j,:)=num/den;
  end

end