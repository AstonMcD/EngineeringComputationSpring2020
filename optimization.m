%% Optimization (Minimization/Maximization)
%%
clear
clc
close all
fig = 0;
%%
% Let us take a function that we already know. A quadratic function that
% has only one minimum so our expectation from our algorithm and therefore
% the code is already set.
f = @(x)((x-1).*(x-2));
x = -5:0.1:5;
fig = fig+1;
figure(fig);
plot(x,f(x));
xlabel('x')
ylabel(['func=' func2str(f)])
title('Golden Section Search')
%% Golden Section Search

phi = (1+sqrt(5))/2;

xl = -5;
xr = 5;

x1 = xl+(phi-1)*(xr-xl);
x2 = xr-(phi-1)*(xr-xl);

f1 = f(x1);
f2 = f(x2);

err = 1;
tol = 0.001;
iter = 0;
maxiter = 50;

while err>tol && iter<maxiter
    if f1<f2 % x1 is closer to minimum
        xopt = x1; xl = x2; 
        x2 = x1; f2 = f1;
        x1 = xl + (phi-1)*(xr-xl); f1 = f(x1);
    else
        xopt = x2; xr = x1;
        x1 = x2; f1 = f2;
        x2 = xr - (phi-1)*(xr-xl); f2 = f(x2);
    end
    err = (2-phi)*abs((xr-xl));
    iter = iter+1;
    xopt_st(iter) = xopt;
end

if (iter<maxiter)
    fprintf('Minimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,iter,err)
else
    fprintf('Maximum iterations reached: cannot trust the result')
end
%%
% Plotting the |xopt| is a good way of visualizing the behavior or the
% algorithm. 
figure(fig)
hold on
for i = 1:length(xopt_st)
    plot(xopt_st(i),f(xopt_st(i)),'or');
    pause(0.25)
end
hold off

%% 
% Working as expected! Well let's take another example: a cubic function.
% The bracket and everything else remaining the same. 
g = @(x)((x-1).*(x-2).*(x-3));
x = -5:0.1:5;
fig = fig+1;
figure(fig);
plot(x,g(x));
xlabel('x')
ylabel(['func=' func2str(g)])
title('Golden Section Search')
%%
% I made a separate |function| called |golden()| to make life easier.
[iter,xopt,xopt_st] = golden(xl,xr,g,tol,maxiter);

if (iter<maxiter)
    fprintf('Minimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,iter,err)
else
    fprintf('Maximum iterations reached: cannot trust the result')
end
%%
% Let us plot the |xopt| trajector or movement again
figure(fig)
hold on
for i = 1:length(xopt_st)
    plot(xopt_st(i),g(xopt_st(i)),'or');
    pause(0.25)
end
hold off
%%
% *What the hell??!!* Why do you think this is happening?
% 
% The algorithm can see a lower value at the boundary. So it converges to
% the lowest point which it can find. Sorry! it is not the minimum you were
% looking for. Not to worry, this is acturally a good thing.
%
% Also, what will happen if |xopt = 0|?
%
%% Gradient Descent
% 
% The simpler, faster, and reckless sibling of *Golden Section Search*.
% Something like a Superman movie. It will get the bad folks but will
% destroy the entire city in the process if not careful. Our job is to make
% Superman (Gradient Descent) act like Batman (Golden Section Search).
%
% Let us code it! A quadratic function again, that has only one minimum. 
f = @(x)((x-1).*(x-2));
x = -5:0.1:5;
fig = fig+1;
figure(fig);
plot(x,f(x));
xlabel('x')
ylabel(['func=' func2str(f)])
title('Gradient Descent')
%% 
% We would need the derivative of the function. Let us use the automatic
% differentiation below.

clear xopt_st % Why am I doing this?

xopt = 0; % we need only one point
xopt_old = 0;

syms xsym
df = matlabFunction(diff(f(xsym)));

iter = 0;
err = 1;
gamma = 0.5; % for now, we will change this later
while err>tol && iter < maxiter
    xopt = xopt - gamma* df(xopt);
    err = abs((xopt-xopt_old)/xopt);
    xopt_old = xopt;
    iter = iter+1;
    xopt_st(iter) = xopt;
end

if (iter<maxiter)
    fprintf('Minimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,iter,err)
else
    fprintf('Maximum iterations reached: cannot trust the result')
end
%%
% Look at the error. Compare to Golden Section Search.
% Plot the error with each each iteration to visualize
% what is going on.
%
% Now let us visualize the |xopt| trajectory
figure(fig)
hold on
for i = 1:length(xopt_st)
    plot(xopt_st(i),f(xopt_st(i)),'or');
    pause(0.25)
end
hold off
%%
% I again made this into a function so I can reuse it. Now let us call and
% this function and see it's behavior.

g = @(x)((x-1).*(x-2).*(x-3));
x = -5:0.1:5;
fig = fig+1;
figure(fig);
plot(x,g(x));
xlabel('x')
ylabel(['func=' func2str(g)])
title('Gradient Descent')

xopt = 0;
[iter,xopt,xopt_st] = gradient(xopt,g,gamma,tol,maxiter);

if (iter<maxiter)
    fprintf('Minimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,iter,err)
else
    fprintf('Maximum iterations reached: cannot trust the result')
end

figure(fig)
hold on
for i = 1:length(xopt_st)
    plot(xopt_st(i),g(xopt_st(i)),'or');
    pause(0.25)
end
hold off
%%
% What the hell again??!! Why didn't this thing stop at the boundary? 
%
% There are no brackets that gradient method is aware of so it can descend
% infinitely. Try xopt = 2 and see what happens
g = @(x)((x-1).*(x-2).*(x-3));
x = -5:0.1:5;
fig = fig+1;
figure(fig);
plot(x,g(x));
xlabel('x')
ylabel(['func=' func2str(g)])
title('Gradient Descent')

xopt = 2;
[iter,xopt,xopt_st] = gradient(xopt,g,gamma,tol,maxiter);

if (iter<maxiter)
    fprintf('Minimum at x = %4.5f after %d iterations with err %1.5f\n',xopt,iter,err)
else
    fprintf('Maximum iterations reached: cannot trust the result')
end

figure(fig)
hold on
for i = 1:length(xopt_st)
    plot(xopt_st(i),g(xopt_st(i)),'or');
    pause(0.25)
end
hold off
%% Lessons Learned
% * Golden Section Search: Slow to converge to a minimum within boundaries
% * Gradient Descent: Fast but can easily go out of bounds and get into
% trouble.
% So, how to make Gradient Descent behave. 
% 
% *Gradient Descent Whisperer:* Enforce some barriers (barrier-functions) at
% the end-points so that it does not run off. If you ever hear about
% log-barriers or (some other function)-barrier, you should be able to
% relate what is being done.

