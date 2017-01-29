function gf=gabor_field(lambda,x0,y0)
% produce the field of the gabor wavelet for the given sf,angle,phase,posi
gamma=1;
if nargin == 1
    x0=0;
    y0=0;
end
sigma=lambda/2;
sigma_x = sigma;
sigma_y = sigma/gamma;
% Bounding box

%[x,y] = meshgrid(xmin:xmax,ymin:ymax);
[x,y]=meshgrid(-63:64,-63:64);
% Rotation
x=x-x0;
y=y-y0;

gb=exp(-.5*(x.^2/sigma_x^2+y.^2/sigma_y^2));
gb(gb<10^-3&gb>-10^-3)=0;
%size(x);
%imshow(gb,[-1,1]);
gf=gb;
end