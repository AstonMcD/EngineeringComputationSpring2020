%% Optimization
%
clear; clc; close all
%%
% We went through coding the following methods in class:
%
% * Golden Section Search
% * Gradient Descent
%
%% Problem 1 (40 points)
% 
% * *1a.* List the advantages and disadvantages of Golden Section Search.
%
% *Answer*
%   Advantages:
%        -> Golden Section Search will always find the minimum.
%   Disadvatages:
%        -> It is slow to converge.
%        -> Also it is constrained to using a single variable.
%           [ f(x) not g(x,y) ]
%        -> Bracketing method is used so user needs to know the bracket
%           first.
% 
%
% * *1b.* List the advantages and disadvantages of Gradient Descent.
%
% *Answer*
%   Advantages:
%        -> Gradient Descent is an easier method to understand.
%        -> Supports multivariable functions. [ g(x,y) ]
%        -> User only needs one initial guess.
%   Disadvatages:
%        -> It is not guaranteed to converge.
%
%
% * *1c.* If both of them do converge to a optimum value which one of the two
% methods would converge in lesser number of iterations?
%
% *Answer*
%   -> Gradient Desecent would most likely converge in less iterations than
%      Golden Section Search because Golden Section Search tends to be slow
%      to converge.
%
% * *1d* What problem do you get into with the two minimization method if 
% the solution is located at $x = 0$ or close to it.
% 
% *Answer*
% In the error calculation you must divide by xopt, and dividing by 0 will
% cause errors and be undefined or near 0 will make hugely inaacurate
% numbers.
%% Problem 2: Golden Section Search (30 points)
%
% Let us consider the function: $f(x) = (x-1)\times(x-2)\times(x-3)$. Plot
% this function to see what it looks like. We calculated minimum of this
% cubic function in class. 
%
% PLOT
x = -50:0.1:50;
f = @(X)((x-1).*(x-2).*(x-3))
plot(x, f(x))
% 
% *2a.* If we consider the left and the right bracket at
% $x=-5$ and $x=5$, what is the minimum if the error tolerance is 0.001 and
% maximum iterations allow are 50.
%
% *Answer*
p = (1+sqrt(5))/2;

xL = -5;
xR = 5;

x1 = xL+(p-1)*(xR-xL);
x2 = xR-(p-1)*(xR-xL);

f1 = f(x1);
f2 = f(x2);

err = 1;
tol = 0.001;
i = 0;
maxi = 50;

while err>tol && i<maxi
    if f1<f2 
        xopt = x1; xL = x2; 
        x2 = x1; f2 = f1;
        x1 = xL + (p-1)*(xR-xL); f1 = f(x1);
    else
        xopt = x2; xR = x1;
        x1 = x2; f1 = f2;
        x2 = xR - (p-1)*(xR-xL); f2 = f(x2);
    end
    err = (2-p)*abs((xR-xL));
    i = i+1;
    xopt_st(i) = xopt;
end

if (i<maxi)
    fprintf('Minimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,i,err)
else
    fprintf('Maximum iterations reached, result may not be accurate.')
end
%
%%
% *2b.* Is the answer correct?
%
% *Answer*
% No, the minimum produced with the brackets at -5 and 5 was negative 5
% because towards the left the function goes to negative infinity, the real
% minimum we sought was 2.57721
%
%
%% Problem 3: Gradient Descent (30 points)
%
% Now let us use a quadratic function $g(x) = (x-1)\times(x-2)$ and an
% initial guess of $x = 2$, perform gradient descent to find the minimum.
% The error tolerance and maximum iterations remain the same as before at
% 0.001 and 50 iterations, respectively.
%
% *3a.* Use a step-size or gamma ($\gamma$) value of 1.0. Do you converge to a minimum? What is
% going on? You can plot iteration number versus the error at that iteration see what is
% happening more clearly.
% 
% *Answer*
% It doesn't converge to a minimum, this is because the with the gamma at
% one theres no way to cause change or "descend" in anyway.
g = @(x)((x-1).*(x-2))

xopt_old = 1.2*xopt;
xopt = 2;

syms xsym
dg = matlabFunction(diff(g(xsym)));

i = 0;
maxi = 50;
tol = 0.001;
err = 1;
gamma = 1.0;

while err>tol && i < maxi
    xopt = xopt - gamma* dg(xopt);
    err = abs((xopt-xopt_old)/xopt);
    xopt_old = xopt;
    i = i+1;
    xopt_st(i) = xopt;
end

if (i<maxi)
    fprintf('Minimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,i,err)
else
    fprintf('Maximum iterations reached.')
end

%%
% *3b.* What happens when you use a gamma value of 0.75, everything else
% remaining the same. You can plot iteration number versus the error at that iteration see what is
% happening more clearly.
%
% *Answer*
g = @(x)((x-1).*(x-2))

xopt_old = 1.2*xopt;
xopt = 2;

syms xsym
dg = matlabFunction(diff(g(xsym)));

i = 0;
maxi = 50;
tol = 0.001;
err = 1;
gamma = 0.75;

while err>tol && i < maxi
    xopt = xopt - gamma* dg(xopt);
    err = abs((xopt-xopt_old)/xopt);
    xopt_old = xopt;
    i = i+1;
    xopt_st(i) = xopt;
end

if (i<maxi)
    fprintf('Minimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,i,err)
else
    fprintf('Maximum iterations reached: cannot trust the result')
end

% Minimum at x = 1.50049 after 10 iterations with err 0.00098
%
% The Gradient Descent method then finds a minimum at the correct position
% with an appropriate error.
%
%% Bonus Problem (40 points)
%
% One of your colleagues requested a harder problem. This is how open-ended
% it looks when you are not given the exact solution strategy. 
%
% For *Problem 2a.*, if an initial guess of -2 is given the solution will
% run off (infinite loop, had it not been for maximum iterations). Suggest
% a strategy that allows you to stop the algorithm from running into this
% trouble. You can either employ barrier functions (search online) or
% suggest a cut-off that lets you detect run-off earlier (before maximum
% iterations are reached).
%
% This problem will graded based upon your thought process and the
% effectiveness of your strategy.




