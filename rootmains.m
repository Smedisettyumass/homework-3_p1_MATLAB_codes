f = @(x) sin(3*pi*cos(2*pi*x).*sin(pi*x));

a = -3;

b = 5; 

n = 4^10;

x0 = linspace(a,b,n);

q = zeros(size(x0));

tic
for i=1:n
    q(i) = fzero(f,x0(i));
end
toc

q = unique(q);