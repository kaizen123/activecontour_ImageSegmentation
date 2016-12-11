function extEnergy = externalEnergyComputation(gx,gy,pts)

    Npts = size(pts,1);
    extEnergy=0;
    for i = 1:Npts
      r = pts(i,1);
      c = pts(i,2);
      extEnergy = extEnergy + abs(gx(r,c))^2 + abs(gy(r,c))^2;
    end


end