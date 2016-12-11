function E_int = internal_energy(pts)
E_int = 0;
alpha =1;
beta=1;
for i=1:40
    
    ax = pts(i,1);
    ay = pts(i,2);
    
    if i==40
        bx = pts(1,1);
        by = pts(1,2);
        cx = pts(2,1);
        cy = pts(2,2);
    elseif i==39
        bx = pts(40,1);
        by = pts(40,2);
        cx = pts(1,1);
        cy = pts(1,2);
    else
        bx = pts(i+1,1);
        by = pts(i+1,2);
        cx = pts(i+2,1);
        cy = pts(i+2,2);
    end
    d = sqrt((bx-ax)^2 + (by-ay)^2);
    b = sqrt((ax - 2*bx+cx)^2+(ay-2*by+cy)^2);
    E_int = E_int+alpha*d+beta*b;
end