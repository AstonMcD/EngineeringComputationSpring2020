%% Assignment 5 (100 points)
%
% *Notes*
%
% * Deadline: 05/10/20 6PM
% * Please download data.mat from canvas for this assignment
% * One of the lowest scores out of the 5 assignments will be dropped
% * The choice of skipping this assignment is yours. If you did well in
% your previous assignments this will not affect your grade.
%
clear
clc
close all
fig = 0;
load data.mat
%% Problem 1: Straight line fit (50 points)
%
% *1a. (25 points)*
% Write a function to perform least squares regression to a straight line
% $y = a_{0} + a_{1}x$. Fit this straight line to the dataset $(x_{1},y_{1})$.
% Report the coefficients $a_{0}$ and $a_{1}$ that allow you to fit a straight line. 
% 
% *Answer*
regress1(x1,y1)

%FUNCTION(S) AT BOTTOM OF FILE
% The fucntion reports a0, a1, and the rsq, however the function only
% outputs rsq.
%
%%
% *1b. (25 points)*
% Plot the original data as scatter points and the straight line fit or
% approximation on the same figure. Report the coefficient of determination
% ($r^2$) for the goodness of fit.

% *Answer*
a0 = 2.11730;
a1 = 0.35265;
rsq = 0.1407;

x = 0:0.5:5;
y = a0 + a1*x;

scatter(x1,y1)                                              %graph
hold on
plot(x,y, 'r')
legend('data points', 'line of best fit')
title('Straight Line Best Fit')
xlabel('x')
ylabel('y')
hold off
figure;

%%

%% Problem 2: Polynomial curve fit (50 points)
%
% *2a. (25 points)*
% Modify the function that you wrote for *Problem 1* so that it can perform
% least squares regression to any polynomial curve of a given degree. Fit a
% cubic polynomial to the dataset $(x_{2},y_{2})$ and report the coefficients 
% $a_{0}$, $a_{1}$, $a_{2}$, and $a_{3}$ for the cubic fit 
% $y = a_{0} + a_{1}x + a_{2}x^2 + a_{3}x^3$. Also report the coefficient of 
% determination ($r^2$) for the goodness of fit.
%
% *Answer*
regress2(x2,y2)
% The function reports the cubic polynomial coefficients and returns the
% coefficient of determination

%%
% *2b. (25 points)*
% Plot the original data as scatter points and the straight line fit or
% approximation on the same figure. Report the coefficient of determination
% ($r^2$) for the goodness of fit.
rsq2 = 0.8022;

n = length(x2);
X = [ones(n,1) x2 x2.^2 x2.^3];

a = (X'*X)\(X'*y2);

y_approx = a(1) + a(2)*x2 + a(3)*x2.^2 + a(4)*x2.^3;

scatter(x2,y2)
hold on
plot(x2,y_approx, 'r')
legend('data points', 'best fit curve')
title('Cubic with Best FIt')
xlabel('x')
ylabel('y')
hold off
ylim([-1 1])

%% FUNCTIONS
function [rsq] = regress1(x, y)
n = length(x);

sum_x = sum(x);
sum_y = sum(y);

sum_xy = sum(x.*y);
sum_xx = sum(x.^2);

a1 = (n*sum_xy-(sum_x*sum_y))./((n*sum_xx)-(sum_x.^2));  
a0 = (sum_y-(a1*sum_x))/n;   

fprintf(' a0 is %.5f .',a0);
fprintf(' a1 is %.5f .',a1);

Sr = sum((y - (a0 + a1*x)).^2);
St = sum((y - mean(y)).^2);
rsq = (St - Sr)/St;

fprintf(' The coefficient of determination is %.5f .',rsq);

end

function [rsq2] = regress2(x, y)
n = length(x);
X = [ones(n,1) x x.^2 x.^3];

a = (X'*X)\(X'*y);

y_approx = a(1) + a(2)*x + a(3)*x.^2 + a(4)*x.^3;

St2 = sum((y-mean(y)).^2); % variance without x (Sy)
Sr2 = sum((y-y_approx).^2); % variance given x (Sy|x)
rsq2 = (St2-Sr2)/St2;

fprintf(' The coefficients for the cubic fit are %.5f, %.5f, %.5f, %.5f .', a(1), a(2), a(3), a(4));
fprintf( 'The coefficient of determination is %.5f .', rsq2);
end
