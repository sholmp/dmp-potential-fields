function lambda = calc_lambda(J)
    

    [U,S,V] = svd(J);
    n = numrows(J);
    s6 = S(n,n); %Smallest singular value
    l_max = 0.1;
    e = 0.2; %Threshold for smallest singular value
    
    if s6 < e
        lambda = (1 - (s6/e)^2) * l_max;
    else
        lambda = 0;
    end

    %https://pdfs.semanticscholar.org/6da9/e9e693cf9ae579535c913755863cce95dbda.pdf
    %p. 4 bottom
end