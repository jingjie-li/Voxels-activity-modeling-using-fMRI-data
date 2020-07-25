function [gb,x,y,x_theta,y_theta]=gabor_fn(theta,lambda,psi,gamma,x0,y0)
% produce a gabor wavelet for the given sf,angle,phase,posi
if nargin == 4
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
theta=2*pi*theta/360;
psi=2*pi*psi/360;
x=x-x0;
y=y-y0;
x_theta=x*cos(theta)+y*sin(theta);
y_theta=-x*sin(theta)+y*cos(theta);

gaussian_mask = exp(-.5*(x_theta.^2/sigma_x^2+y_theta.^2/sigma_y^2));
gaussian_mask(gaussian_mask < (max(gaussian_mask(:))*0.01)) = 0;

gb = gaussian_mask .*cos(2*pi/lambda*x_theta+psi);
%size(x);
%imshow(gb,[]);
end
