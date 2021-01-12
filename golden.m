function [iter,xopt,xopt_st] = golden(xl,xr,f,tol,maxiter)

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
maxiter = 100;

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

end