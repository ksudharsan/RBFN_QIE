function z = getRBFActivations(centers, betas, input)

    diffs = bsxfun(@minus, centers, input);
    sqrdDists = sum(diffs .^ 2, 2);

    z = exp(-betas .* sqrdDists);

end