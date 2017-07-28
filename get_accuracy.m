function [accuracy,numRight,total,wrong] = get_accuracy(X,y,Centers,Theta,Betas,Category)
  
  wrong=[];
  numRight=0;
  for (i = 1 : size(X,1))
    scores = evaluateRBFN(Centers,Betas,Theta, X(i, :));
    [maxScore, index] = max(scores);
    if (index == y(i))
        numRight = numRight + 1;
    else 
        wrong=[wrong;i];
    end
  end
  
  total=size(X,1);
  accuracy=((100*numRight)/total);
  
end