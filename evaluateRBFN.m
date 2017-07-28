function z = evaluateRBFN(Centers, betas, Theta, input)

    phis = getRBFActivations(Centers, betas, input);
    phis = [1; phis];
    
    z = Theta' * phis;
        
end