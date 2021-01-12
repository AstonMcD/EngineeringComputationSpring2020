%% Midterm (100 points)
%%
% * *Due date*: 04/15/20 12 Noon 
% * Please ensure you submit before the deadline
% * You can upload multiple submissions: the latest submission will be
% graded
%%
clear
clc 
close all
fig = 0;
%% Problem 1: General Coding (20 points)
% * *1a.* Given two vectors |a = [1 2 3 4]| and |b = [2 8 1 2]| calculate the
% inner or scalar product.
a = [1 2 3 4];
b = [2 8 1 2];

innerproduct = a * b'
%%
% * *1b.* What is the outer or matrix product |a = [1 2 3 4]| and |b = [2 8 1 2]| ?
%
a = [1 2 3 4];
b = [2 8 1 2];

outerproduct = a' * b
%%
% * *1c.* Vectorize the following lines of code using inner or scalar
% product. You should be able to get the same value for distance.
vec1 = 1:2:5;
magnitude = 0;
for i = 1:length(vec1)
    magnitude = magnitude+vec1(i)^2;
end
magnitude = sqrt(magnitude)

%
% *Answer*
i = 1:2:5;
vecNew = (i.^2)
magnitude = sqrt(sum(vecNew))
%%
% * *1d.* Explain what the following piece of code is trying to achieve.
vec2 = [2 8 5 9];
cp = @(vec,n)(ones(n,1).*vec2);
mat = cp(vec2,4)
%
% *Answer*
%  The code shown above is trying to make a matrix that has multiple rows
%  of the same vector. The first line of the code establishes a vector. The
%  second line sets up a function that takes an input of a vector and a
%  number 'n' terms to produce 'n' number of rows of said vector. The third
%  line utilizes the function to make a matrix with 4 rows of vec2 = [2 8 5
%  9]
%% Problem 2: Taylor Series (20 points)
% Given a function $f(x) = sin(x)$ and the value of the function at $x_{0} =
% \frac{\pi}{2}$. Use a Tayor series expansion around $x_{0}$ =
% \frac{\pi}{2}$ to approximately answer the following:
%
% * *2a* What are the values of the $f(x)$ at $x = \pi$ using 2 and 4 terms
% in the Taylor series expansion. You know the answer of $sin(x)$ at $x =
% \pi$, which one of the two is better: the one with 2 terms or the other
% with 4 terms?
%
% *Answer*
% %function [A] = sinApprox(x, n)
% nthTerm = @(x, n)((-1).^(n) .* (x-(pi/2)).^(2.*n) ./ factorial(2.*n));
% A = 0;
% for i = 0:n
%     A = A + nthTerm(x,i);
% end
% end

%0 IS MY FIRST TERM SO 3 TERMS IS WHEN n=2
TwoTerms = sinApprox(pi, 1)
FourTerms = sinApprox(pi, 3)

%%
% * *2b* We can plot $sin(x)$ between $x=0$ and $x=2\pi$ in the 
% figure below. Plot the Taylor series approximation with 2 and 4 terms on
% the same figure using different colors or symbols to distinguish the three curves.
% What can you say about the approximation as we increase
% the number of terms in the series?
x = 0:0.1:2*pi;
fig = fig+1;
figure(fig);
xPlot = 0:0.1:2*pi;
plot(xPlot, sin(xPlot),'-o')
xlabel('x-axis')
ylabel('sin(x)')
title('Exact v. Approx sin(x) Plot')
hold on
plot(xPlot, sinApprox(xPlot, 1))
plot(xPlot, sinApprox(xPlot, 3))
xlabel('x')
ylabel('f(x)')
ylim([-1 1])
grid on

% *Answer*
% The approximation becomes sig

%%
% The 2 term approximation deviates more from true sin(x) compared to 4
% terms approximation.
%% Problem 3: Roots (30 points)
%%
% * *3a* Write one advantage and disadvantage each for open and bracketing methods.
%
% *Answer*
% Bracketing Methods
%   -> Advantage: will always converge to the root in the bracket
%   -> Disadvantagae: slow and computationally inefficient
% Open Methods
%   -> Advantage: fast and computationally efficent
%   -> Disadvantage: prone to diverging
%%
% You are given the function $f(x) = \frac{x}{4-x^{2}}+0.5$.
f = @(x)(x./(4-x.^2)+0.5);
tol = 0.001;
maxiter = 100;

fig = fig+1;
figure(fig)
x = -2:0.1:2;
plot(x,f(x))
xlim([-2,2])
grid on
%%
% * *3b* Find the root of the function using the two bracketing methods: Bisection and
% False position. Use a bracket of (-1.8,1.8). Report the number of
% iterations taken by each method. Use a tolerance of 0.001 and maximum
% iterations at 100.
%
% False Position Method

x1 = -1.5;
x2 = 0.5;

err1 = 1;
tol = 0.001;
xO = x1;

i = 0; 
maxi = 100;

while (err1 > tol && i<maxi)
    root = x2 - ((f(x2)*(x1 - x2))/(f(x1) -f(x2)));
    if f(x2) * f(root) < 0
        x1 = root;
    else
        x2 = root;
    end
    err1 = abs((root - xO)/root).*100;
    xO = root;
    i = i + 1;
    
end

fprintf('Problem 3:\nThe root from the False Position method is %6.4f in %4.2f iterations.\n', root, i);

% Bisection Method
%

err2 = 1;
tol = 0.001;

x1 = -1.5;
x2 = 0.5;

xO = x1;
i = 0; 

while (err2 > tol)
    root = (x2 + x1).*0.5;
    if f(root) * f(x1) < 0
        x2 = root;
    elseif f(root) * f(x2) < 0
        x1 = root;
    else
        root;
    end
    
    err2 = abs((root-xO)./root)* 100;
    xO = root;
    i = i + 1;
    
end

fprintf('The root from the Bisection method is %6.4f in %4.2f iterations.\n\n', root, i);
%%
% * *3c* Find the solution using the two open methods: Newton-Raphson and
% Secant method. Use an initial guess of 1. Report the number of
% iterations taken by each method. Use a tolerance of 0.001 and maximum
% iterations at 100.
%
%
i = 1;
x(i) = 1;
errNewt(i) = 1;

while errNewt(i) > tol
    i = i + 1;
    fN =  (x(i-1)./(4-x(i-1).^2))+0.5;
    dfN = (4+x(i-1).^2)./(4-x(i-1).^2).^2;
    x(i) = x(i-1) - (fN/dfN);
    errNewt(i) = abs((x(i)-x(i-1))/x(i)).*100;
end

fprintf('The root from the Newton Raphson method is %6.4f in %4.2f iterations\n', x(i), i-1)

%
% Secant Method

tol = 0.001;
xSec(1) = 1;   
xSec(2) = 1.1;    
errSec(1) = 1;

i = 2;
max = 100;

while (errSec > tol && i < max)
    xSec(i+1) = xSec(i) - f(xSec(i)) *((xSec(i)-xSec(i-1))/(f(xSec(i))-f(xSec(i-1))));
    errSec = abs((xSec(i+1)-xSec(i))/xSec(i+1)).*100;
    i = i + 1;
    
end

fprintf('The root from the Secant method is %6.4f in %4.2f iterations.\n\n', xSec(i), i-2);

%% Problem 4: Optimization (30 points) 
% * *4a* Write one advantage and disadvantage of Golden Section Search and
% Gradient Descent methods for minimization/optimization.

% *Answer*
% Golden Section Search
%   -> Advantage: it will always find the minimum
%   -> Disadvantagae: it is slow to converge
% Gradient Descent
%   -> Advantage: supports multivariable funcitons and only needs one guess
%   -> Disadvantage: it is not guaranteed to converge

% * *4b* We are interested in finding the roots of $g(x) = (x-1)(x-2)(x-3)$.
% What are the roots of the $f(x) = 0$ without solving it. Plot the
% function between $x=0.75$ and $x=3.25$ to visualize this.
%
% *Answer*
% The roots are x=1, x=2, and x=3, whenever you plug in one of these
% numbers to the function it equals 0. Also, looked at the graph to confirm
% the roots.
g = @(x)((x-1).*(x-2).*(x-3));
fig = fig+1;
figure(fig)
x = 0.75:0.01:3.25;
plot(x,g(x))
title('Roots of g(x)')
xlabel('x')
ylabel('y')
grid on
%%
%
% * *4c* Let us now consider another function $h(x) = g(x)^{2}$. Plot this
% function on the same plot using different color. How can you use $h(x)$ to
% find the roots of $g(x)$? Describe in words only. 
%
% *Answer*
% h(x) and g(x) have the same roots so when you find the minimum of h(x)
% using optimization you are finding the roots of both h(x) and g(x). This
% is simply because h(x) is just the squared equation of g(x).

h = @(x)(((x-1).*(x-2).*(x-3)).^2);
fig = fig+1;
figure(fig);
x = 0.75:0.01:3.25;
plot(x,g(x),'-r',x,h(x),'-b')
title('h(x) vs g(x)')
xlabel('x')
ylabel('y')
grid on
%%
%%
% * *4d* If you use Gradient Descent Optimization on $h(x)$ with an initial guess
% of 1.0, a tolerance of 0.001, and gamma value at 1.0,
% which root of $g(x)$ do you converge to?
% Report the number of iterations taken by the Gradient Descent method.

% *Answer*
% converges to the first root x=1
h = @(x)(((x-1).*(x-2).*(x-3)).^2);

xopt = 1;
xopt_old = 1.2*xopt;

syms xsym
dh = matlabFunction(diff(h(xsym)));

i = 0;
maxi = 50;
tol = 0.001;
err = 1;
gamma = 1.0;

while err>tol && i < maxi
    xopt = xopt - gamma* dh(xopt);
    err = abs((xopt-xopt_old)/xopt);
    xopt_old = xopt;
    i = i+1;
    xopt_st(i) = xopt;
end

if (i<maxi)
    fprintf('Problem 4:\nMinimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,i,err)
else
    fprintf('Maximum iterations reached.')
end
%
%%
% * *4e* Which root due to you converge to when you use an initial guess of 0.5 instead of 1.0, 
% with a gamma values of 0.07 for problem 4d, tolerance remaining the same.
%
% *Answer*
% converges to the second root x=2
h = @(x)(((x-1).*(x-2).*(x-3)).^2);

xopt = 0.5;
xopt_old = 1.2*xopt;

syms xsym
dh = matlabFunction(diff(h(xsym)));

i = 0;
maxi = 50;
tol = 0.001;
err = 1;
gamma = 0.07;

while err>tol && i < maxi
    xopt = xopt - gamma* dh(xopt);
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



%FUNCTIONS
%   *Approximation for sin(x) about x = pi/2*
function [A] = sinApprox(x, n)
nthTerm = @(x, n)((-1).^(n) .* (x-(pi/2)).^(2.*n) ./ factorial(2.*n));
A = 0;
for i = 0:n
    A = A + nthTerm(x,i);
end
end
