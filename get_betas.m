function [betas]=get_betas(X,centers,memberships)

    numRBFNeurons=size(centers, 1);
    [n k]=size(memberships);
    sigmas = zeros(numRBFNeurons, 1);
    for (i = 1 : numRBFNeurons)
        dis=zeros(n,1);
        for j=1:n
            dis(j)=euclidean(centers(i, :),X(j,:));
        end
        sigmas(i, :) = mean(dis);
    end
    betas=1 ./(2.*sigmas.^2);
    
end