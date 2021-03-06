function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%
% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%

% ----------------- Part 1 -----------------

K = num_labels;
y_bits = eye(K)(y, :);

a1 = [ones(m, 1) X];
z2 = a1 * Theta1';
a2 = [ones(m, 1) sigmoid(z2)];
z3 = a2 * Theta2';
a3 = sigmoid(z3);
h = a3;


% For every example in X.
for i = 1:m
    % I think that this implementation is optimal.
    for k = 1:K
        if (k == y(i))
            J += -log(h(i, k));
        else
            J += -log(1 - h(i, k));
        endif;
    endfor;
endfor;

J /= m;

% ----------------- Part 2 -----------------
% Backpropagation.

% Output layer.
d3 = (a3 - y_bits);
% Hidden layer.
% d2_i = (Theta2' * d3_i) .* a2(i, :)' .* (1-a2(i, :))';
d2 = (d3*Theta2(:, 2:end)) .* sigmoidGradient(z2);
% Adding to Gradient
Theta1_grad = d2'*a1;
Theta2_grad = d3'*a2;
Theta1_grad = (1/m) * (Theta1_grad);
Theta2_grad = (1/m) * (Theta2_grad);

% ----------------- Part 3 -----------------
regularization = 0;
% Theta1
[theta_j, theta_k] = size(Theta1);
for j = 1:theta_j
    for k = 2:theta_k
        regularization += Theta1(j, k)^2;
        Theta1_grad(j, k) += (lambda/m) * Theta1(j, k);
    endfor;
endfor;
% Theta2
[theta_j, theta_k] = size(Theta2);
for j = 1:theta_j
    for k = 2:theta_k
        % We don't use the first theta. That's why we add 1 to k.
        regularization += Theta2(j, k)^2;
        Theta2_grad(j, k) += (lambda/m) * Theta2(j, k);
    endfor;
endfor;
regularization *= (lambda / (2*m));
J += regularization;

% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
