x = 9;
y = 3;
z = perm(x,y);

function p = perm(n,r)
p = fact(n)*fact(n-r);
end

function f = fact(n)
f = prod(1:n);
end