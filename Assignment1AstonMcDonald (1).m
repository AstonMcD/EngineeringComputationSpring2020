%% Assignment 1
% * Total points = 100
% * Check the deadline on Canvas and submit on time. The pentalty for late 
% submission is 20% per day. 
% * You can upload multiple times to be safe. The latest submission will be
% graded.
% * Please follow this template or design your own to nicely present your
% results.
% * Most importantly. Enjoy!
%%
clear
clc
close all
%% Easy Problem 1 (30 points)
% Vectorize the following loops:
%
% *1a*
for i = 1:5
    vec1(i) = (5*i+2)^3;
end
vec1
%%
% *Answer*
i = 1:5;
vec1 = (5*i+2).^3; 
vec1
% Your code here. Use this template or any other that would let us see your
% code and answer easily.
%%
% *1b*
i = 1;
while i<=5
    vec2(i) = i^2+4;
    i = i+1;
end
vec2
%%
% *Answer*
i=1:5;
vec2 = i.^2+4;
vec2
%% 

% *1c*
% Can you vectorize the following? Why?
vec3(1) = 1;
i = 1;
while i<5
    i = i+1;
    vec3(i) = (vec3(i-1)+2)^2;
end
vec3
%%
% *Answer*
% No, because you can only vectorize when each instruction is mutually
% independent. According to Lecture 4 the rule is you may only vec3[1] may
% be calculated independent of vec3[2] and so on.
%%
% *1d*
%
% You can vectorize the following:
for i = 1:10
    a = i^2+1;
    if a>10
        vec4(i) = a;
    else
        vec4(i) = 0;
    end
end
vec4
%%
% *Answer*
i=(1:10).^2 + 1;
Vect4 = (a>10) .* a;
Vect4


%%
% *1e*
% 
% What is the inner (scalar) and outer (matrix) products of the following two
% vectors?
vec5 = (1:5);
vec6 = (2:6);
%%
% *Answer*
%vec5 = (1:5);
vec6 = (2:6);
innerproduct = vec5 * vec6'
outerproduct = vec6' * vec5

innerproduct =

    70


outerproduct =

     2     4     6     8    10
     3     6     9    12    15
     4     8    12    16    20
     5    10    15    20    25
     6    12    18    24    30
%%

%% Ramp up Problem 2 (30 points)
% 
% *2a*
%
% We are given the function $f(x,y) = x^2 + y^2 + xy$. Write an inline
% function that accepts vectors of x and y to generate the value of the function.
% Output the answer for |x = -2:2| and |y = -1:3|. 
%%
% *Answer*
f1 = @(x, y)(x.^2 + y.^2 + x.*y);
x = -2:2;
y = -1:3;
f1(x, y)

ans =

     7     1     1     7    19
%%
% *2b*
%
% Use a scatter plot |scatter3(arg1,arg2,arg3)| to visualize your answer
% now using |x=-2:0.1:2| and |y=-2:0.1:2|.
%%
% *Answer*
f1 = @(x, y)(x.^2 + y.^2 + x.*y);
xS = -2:0.1:2;
yS = -2:0.1:2;
scatter3(xS, yS, f1(xS, yS))
xlabel('x-axis')
ylabel('y-axis')
zlabel('f1(x, y)')
title('2b Scatter Plot')
%%
% *2c*
% Plot this function (2D surface) between x = (-2,2) and y = (-2,2) using
% the |scatter3()| function. You will need to generate all permutation of
% (x,y) points as follows:
x = [1 2]; y = [2 3];
xp = [1 2 1 2];
yp = [2 2 3 3];

f1 = @(x,y)(x.^2 + y.^2 +x.*y);
x = -2:0.1:2;
y = -2:0.1:2;
L = length(x)
xp=[];
yp=[];

for i = 1:L
    xp = [xp, x];
    yp = [yp, ones(1, length(x))* y(i)];
end

scatter3(xp, yp, f1(xp,yp));
title('Function w/ Permutations')
xlabel('x-axis')
ylabel('y-axis')
zlabel('x^2 + y^2 + xy')
%%
% You will need to write a code that generates these |xp| and |yp| for given x and y vectors
% of equal length.
%%
% *Answer*
    
%% Touchdown Problem 3 (40 points)
%
% *3a*
%
% Write a function for the MacLaurin series (expansion about x=0) for $f(x)
% = sinx$. The function must accept two input arguments: (1) |x| where the function is to evaluated
% , and (2) n the number of terms to approximate $sinx$.
%%
% *Answer*
% %function [A] = sinApprox(x, n)
% nthTerm = @(x, n)((-1).^(n) .* (x).^(2.*n+1) ./ factorial(2.*n+1));
% A = 0;
% for i = 0:n
%     A = A + nthTerm(x,i);
% end
% end

%0 IS MY FIRST TERM SO 3 TERMS IS WHEN n=2


%%
% *3b*
%
% If you consider only 3 terms in the series expansion what is the relative
% error (not percentage) between the approximate and true solution at
% points |x=[1 2 3]|. What can you say about the approximation as x moves
% further away from $x = 0$?
%%
% *Answer*
%Assuming that it is in radians and not degrees.
error1 = abs(sin(1)-sinApprox(1, 2)) / sin(1);
error1
error2 = abs(sin(2)-sinApprox(2,2)) / sin(2);
error2
error3 = abs(sin(3)-sinApprox(3,2)) / sin(3);
error3

error1 =

   2.3255e-04


error2 =

    0.0264


error3 =

    2.7202

%The approximation is becoming less and less accurate the further x moves
%from x = 0.
%%
% *3c*
%
% Plot the approximate and exact $sin(x)$ between x=0 and x=3.
%%
% *Answer*
xPlot = 0:0.1:3;
plot(xPlot, sin(xPlot),'-o')
xlabel('x-axis')
ylabel('sin(x)')
title('Exact v. Approx sin(x) Plot')
hold
plot(xPlot, sinApprox(xPlot, 2))
%%
% *3d*
%
% Now add approximate $sinx()$ function with 4 terms. What can you
% say about the curves as you increase the number of terms?
%%
% *Answer*
%The curves become more accurate with more terms.
xPlot = 0:0.1:3;
plot(xPlot, sin(xPlot),'-o', xPlot, sinApprox(xPlot, 2), '-b', xPlot, sinApprox(xPlot, 3), '-r')
xlabel('x-axis')
ylabel('sin(x)')
title('Exact v. Approx sin(x) Plot')



%FUNCTIONS
function [A] = sinApprox(x, n)
nthTerm = @(x, n)((-1).^(n) .* (x).^(2.*n+1) ./ factorial(2.*n+1));
A = 0;
for i = 0:n
    A = A + nthTerm(x,i);
end
end
