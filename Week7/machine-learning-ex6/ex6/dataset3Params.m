function [C, sigma] = dataset3Params(X, y, Xval, yval)
%DATASET3PARAMS returns your choice of C and sigma for Part 3 of the exercise
%where you select the optimal (C, sigma) learning parameters to use for SVM
%with RBF kernel
%   [C, sigma] = DATASET3PARAMS(X, y, Xval, yval) returns your choice of C and 
%   sigma. You should complete this function to return the optimal C and 
%   sigma based on a cross-validation set.
%

% You need to return the following variables correctly.
C = 1;
sigma = 0.1;

% ====================== YOUR CODE HERE ======================
% Instructions: Fill in this function to return the optimal C and sigma
%               learning parameters found using the cross validation set.
%               You can use svmPredict to predict the labels on the cross
%               validation set. For example, 
%                   predictions = svmPredict(model, Xval);
%               will return the predictions on the cross validation set.
%
%  Note: You can compute the prediction error using 
%        mean(double(predictions ~= yval))
%

# Code to get all posible values of C and sigma
% steps = 4;
% multiplicative_steps = repmat(10, steps, 1) .^ ([0:(steps-1)]');
% first_steps_C = [0.01, 0.03];
% all_C = zeros(length(first_steps_C)*steps, 1);
% # Values of C
% for i = 0:(length(first_steps_C)-1)
%     all_C(((i)*steps)+1:((i+1)*steps)) = first_steps_C(i+1) * multiplicative_steps;
% endfor;
% # Values of sigma
% first_steps_sigma = [0.01, 0.03];
% all_sigma = zeros(length(first_steps_sigma)*steps, 1);
% for i = 0:(length(first_steps_sigma)-1)
%     all_sigma(((i)*steps)+1:((i+1)*steps)) = first_steps_sigma(i+1) * multiplicative_steps;
% endfor;

% Code to try each value of C and Sigma and get the min.
% The result with the dataset was C = 1 and Sigma = 0.1
% model= svmTrain(X, y, all_C(1), @(x1, x2) gaussianKernel(x1, x2, all_sigma(1))); 
% predictions = svmPredict(model, Xval);
% min_cost = mean(double(predictions ~= yval));
% for C_i = 2:length(all_C)
%     for sigma_i = 2:length(all_sigma)
%         model= svmTrain(X, y, all_C(C_i), @(x1, x2) gaussianKernel(x1, x2, all_sigma(sigma_i))); 
%         predictions = svmPredict(model, Xval);
%         actual_cost = mean(double(predictions ~= yval));
%         if (min_cost > actual_cost)
%             min_cost = actual_cost;
%             C = all_C(C_i);
%             sigma = all_sigma(sigma_i);
%         endif;
%     endfor;
% endfor;





% =========================================================================

end
