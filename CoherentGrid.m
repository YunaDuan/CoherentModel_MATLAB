function Grid = CoherentGrid(h)
%Getting grid for density estimation
if h<=999
    Grid.Z=[ 0:0.01:99.99 100:0.5:h]; 
else
    Grid.Z=[ 0:0.01:99.99 100:0.5:999 1000:h]; 
end

X=meshgrid(Grid.Z);
X=X-X';
Grid.X=abs(X); 
return