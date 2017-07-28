function [Theta] = getTheta(Centers,Betas,X,y,tot_classes)    

    m=size(X,1);
    numRBFNeurons = size(Centers, 1);
    X_active = zeros(m, numRBFNeurons);

    for (i = 1 : m)
        input = X(i, :);
        z = getRBFActivations(Centers, Betas, input);
        X_active(i, :) = z';
    end

    X_active = [ones(m, 1), X_active];
    Theta = zeros(numRBFNeurons + 1, tot_classes);

    for (c = 1 : tot_classes)
    
        y_c = (y == c);
        Theta(:, c) = pinv(X_active' * X_active) * X_active' * y_c;
    end
    
end