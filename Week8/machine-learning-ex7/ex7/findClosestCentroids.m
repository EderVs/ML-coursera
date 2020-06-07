function idx = findClosestCentroids(X, centroids)
%FINDCLOSESTCENTROIDS computes the centroid memberships for every example
%   idx = FINDCLOSESTCENTROIDS (X, centroids) returns the closest centroids
%   in idx for a dataset X where each row is a single example. idx = m x 1 
%   vector of centroid assignments (i.e. each entry in range [1..K])
%

% Set K
K = size(centroids, 1);

% You need to return the following variables correctly.
idx = zeros(size(X,1), 1);

% ====================== YOUR CODE HERE ======================
% Instructions: Go over every example, find its closest centroid, and store
%               the index inside idx at the appropriate location.
%               Concretely, idx(i) should contain the index of the centroid
%               closest to example i. Hence, it should be a value in the 
%               range 1..K
%
% Note: You can use a for-loop over the examples to compute this.
%

m = length(X);
for i = 1:m
    x_i = X(i, :);
    # Taking the first centroid as the min in the beginning.
    closest_k = 1;
    closest_k_d = sum((x_i - centroids(1, :)) .^ 2);
    for k = 2:K
        mu_k = centroids(k, :);
        d = sum((x_i - mu_k) .^ 2);
        if (d < closest_k_d)
            closest_k = k;
            closest_k_d = d;
        endif;
    endfor;
    idx(i) = closest_k;
endfor;


% =============================================================

end

