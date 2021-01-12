%% Roots
%
% Previously, we discussed two classes of root finding methods: (1) Bracket
% , and (2) Open methods. We will be using those now and maybe improve upon
% the algorithm a little bit.
%
% *Bracketing Methods*
%
% * Bisection
% * False position
%
% *Open Methods*
%
% * Fixed point 
% * Newton Raphson
% * Secant method
%
% We programmed most of these in class so we will be mostly using it here.
%%
clear
clc
close all
fig = 0;
%% Problem 1 (45 points)
% * *1a* (5 points)
%
% In a few lines list the advantages and disadvantages of Bracketing
% methods.
%
% *Answer*

% The bracketing methods usually work but will often converge slowly. The fix 
% point method lets you decide an inital basic code. However, you must 
% have some idea of what the code looks like before the process again. 
%  
% The advantage to using the bisection method is it differs to the false 
% position in which it finds the root by joining an lower and upper. The 
% false position method sometimes lead to poor covergence as the iterations
% are continuing. You can always find the root in the bracket, but it can 
% be slow and computationally inefficient.
%
% * *1b* (5 points)
%
% What are the advantages and disadvantages of the Open methods?
%
% *Answer*
%
% Open methods are fast and computationally efficient, however they are
% prone to diverging.They require less iterations than the bracketing
% methods but they still need an initial guess like the bracketing methods
%
% * *1c* (20 points)
% 
% You are given a fourth order polynomial function $f(x) = (x^4 + x^3 - 5x^2 - 7x +
% 9)$. Find all the roots of this polynomial function using one bracketing
% and one open method of your choice. The choice of bracket and initial
% guess is yours. The relative error should be 0.0001. Use a maximum
% iterations of 50.
%
% I would suggest staying away from fixed-point method as the choice of
% open method. So, only two choices in open-methods.
x = -3:0.1:3;
f = @(x)(x.^4+2*x.^3-5*x.^2-7*x+8);
fig = fig+1;
figure(fig)
plot(x,f(x))
xlabel('x')
ylabel('f(x)')
title('Problem 1c')
grid on
%%
%
% *Answer*
%   BRACKETING
x1 = 0;
x2 = 2;
tol = 0.0001;

err = 1;
xold = x1;

i = 0; 
imax = 50;

while (err > tol && i<imax)
    root = x2 - ((f1(x2)*(x1 - x2))/(f1(x1) -f1(x2)));
    if f1(x2) * f1(root) < 0
        x1 = root;
    else
        x2 = root;
    end
    err = abs((root - xold)/root).*100;
    xold = root;
    i = i + 1;
end
root_1cBracket=root
iterations_1cBracket=i
    % with brackets from 0 to 1
    % root = 8.718 with 10 iterations
    
    %with brackets from 1 to 2
    %root = 1.7129 with 15 iterations

%   OPEN METHOD

syms xsym   
df = matlabFunction(diff(f(xsym)));
xm_op = @(f,x,xh)(x-f(x)/df(x));

err = 1; % initialize error
tol = 0.0001;
i = 0; % initialize iation counter
imax=50;

xm = 1;
xold1 = xm;
xold2 = xm + 0.1;
vec = zeros(1,3);


while (err>tol && i<imax)
    i = i +1;
    xm = xm_op(f,xold1,xold2);
    
    err = abs((xm-xold1)/xm)*100;
    xold2 = xold1;
    xold1 = xm;
    
    vec(i,1) = err;
    vec(i,2) = xm;
    vec(i,3) = f(xm);
    
end

root_1cOpen = xm
iterations_1cOpen = i
% when initial xm=1 then root = 0.8718 with 4 iterations
% when initial xm=2 then root = 1.7129 with 5 iterations


%%
% * *1d* (5 points)
% 
% How many real roots does this function have? Answer in words: no
% computations required.
%
% *Answer*
% The function has two real roots. However, it is a 4th order function so
% there are like 2 imaginary roots as well.
%
% * *1e* (10 points)
%
% Find one of the roots to the above problem with an initial guess of -2.0? 
% The relative error desired and maximum iterations are unchanged at 0.0001
% and 50. Output the root and number of iterations.
%
% You can compare this answer from the roots you found in 1c. Is this
% answer correct to the desired tolerance? (true or false). In either case why?
%
f = @(x)(x.^4+2*x.^3-5*x.^2-7*x+8);
syms xsym   
df = matlabFunction(diff(f(xsym)));
xm_op = @(f,x,xh)(x-f(x)/df(x));

err = 1; % initialize error
tol = 0.0001;
i = 0; % initialize iation counter
imax=100;

xm = -2;
xold1 = xm;
xold2 = xm + 0.1;
vec = zeros(1,3);


while (err>tol && i<imax)
    i = i +1;
    xm = xm_op(f,xold1,xold2);
    
    err = abs((xm-xold1)/xm)*100;
    xold2 = xold1;
    xold1 = xm;
    
    vec(i,1) = err;
    vec(i,2) = xm;
    vec(i,3) = f(xm);
    
end

root_1e = xm
iterations_1e = i
% I got the root = 1.7185 with 50 iterations which is very close to the
% desired answer but is not within the desired tolerance of 0.0001. When I
% tested to see how many iterations it required to reach 1.7129 it only
% needed 3 more iterations (53 iterations) which leads me to believe that
% the initial guess is just a little to far away to lead to a good answer.
%% Problem 2 (55 points)
% Now let us take a different function $g(x) = -x^{3.2}+2$. You will be
% quick to realize that this is not a polynomial. In the following when I say
% roots it implies intersection with the x-axis.
x = 0.01:0.1:3;
g = @(x)(-x.^3.2+2);
fig = fig+1;
figure(fig)
plot(x,g(x))
xlabel('x')
ylabel('g(x)')
title('Problem 2')
grid on
%%
% For all of the following problems: use a tolerance of 0.0001. Also a maximum
% iterations of 50 if you are using one of the open methods.
%nthroot(-1, 3)
%x>0
%%
%
% * *2a* (10 points)
%
% How many real roots does this problem seem to have? Use any one of the
% bracketing methods to find the roots.
% 
%
% *Answer*
% according to the graph there is only real root as negative values of x
% are not graphed. The bracketing method also appears to show one real root
% but it does also show imaginary values depending on the method used.`
% 1` B3
x1 = 0;
x2 = 2;
tol = 0.0001;

err = 1;
xold = x1;

i = 0; 
imax = 50;

while (err > tol && i<imax)
    root = x2 - ((g(x2)*(x1 - x2))/(g(x1) -g(x2)));
    if g(x2) * g(root) < 0
        x1 = root;
    else
        x2 = root;
    end
    err = abs((root - xold)/root).*100;
    xold = root;
    i = i + 1;
end
root_2a = root
iterations_2a = i
%
% *Answer*
% root = 1.2419 with 20 iterations and the brackets are from 0 to 2..
%   
%
%%
% * *2b* (5 points)
%
% What is the slope of this curve at x = 0?
%
% *Answer*
syms xsym 
dg = matlabFunction(diff(g(xsym)));
dg(0)
% slope = 0 the tangent line is y=2 which is parallel with the x-axis
%%
% * *2c* (10 points)
%
% We want to use Newton-Raphson method that requires that we use the
% derivative of the function $g(x)$. What happens to this derivative at
% negative values of x?
%
% The newton-raphson method becomes difficult to use when equations have a
% difficult derivative because MATLAB struggles to graph complex roots.
% Thus the newton raphson method will diverge unless the user specifies the
% program to only values above 0. Then the program will find positive
% roots.
%%
% * *2d* (15 points)
%
% Using Newton-Raphson method find the root with an initial guess of -1.7.
% Is the result correct? Compare your answer to 2a.
%
g = @(x)(-x.^3.2+2);

syms xsym 
dg = matlabFunction(diff(g(xsym)));
dg(0);

tol = 0.0001;
err = 1;
xi = -1.7;

i = 0;
imax = 50;
parameter = 0.516; 

while (err>tol && i<imax)
    xroot = xi - g(xi)/dg(xi)*parameter;
    err = abs((xroot-xi)/xroot);
    xi = xroot;
    i = i + 1;
end

if (g(xroot)>err)
    fprintf('Converged to wrong solution.')
else
    root_2d = abs(xroot)
    iterations_2d = i
end

%
% *Answer*
%   root = 1.2419 with 15 iterations
%
% * *2e* (15 points)
%
% Now let us restrict ourselves to using Newton-Raphson method. What is the
% value of the initial guess that is not equal to zero and results in the
% maximum number of newton iterations? You can do this by giving initial 
% guesses between 0.1 and 2 in increments of 0.1.
%
% *Answer* I found the maximum number of newton iterations to be 34 at
% initial guess 0.1
g = @(x)(-x.^3.2+2);

syms xsym 
dg = matlabFunction(diff(g(xsym)));
dg(0);

tol = 0.0001;
err = 1;
maxiter = 0;
xInitial = 0;

for xi = 0.1:0.1:2
xn = xi;
i = 0;
parameter = 0.516; 

while (err>tol)
    xroot = xn - g(xn)/dg(xn)*parameter;
    err = abs((xroot-xn)/xroot);
    xn = xroot;
    i = i + 1;
end
    if i > maxiter
        maxiter = i;
        xInitial = xi;
    end

end
maxiter
xInitial


%


