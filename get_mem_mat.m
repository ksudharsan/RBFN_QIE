function [mem_mat]=get_mem_mat(kmat,X,centers,m)

  mem_mat=zeros(size(centers,1),size(X,1));
  
  for i=1:size(X,1)
    den=0;
    for j=1:size(centers,1)
      den=den+(1-kmat(i,j))^(-1/(m-1));
    end
    for j=1:size(centers,1)
      mem_mat(j,i)=(1-kmat(i,j))^(-1/(m-1));
      mem_mat(j,i)=mem_mat(j,i)/den;
    end
  end

end