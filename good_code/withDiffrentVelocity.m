N = 101;
% L = 4*pi;
xL = 12;
yL = 12;
x = linspace(0,xL,N);
y = linspace(0,yL,N);
c_air=.373;
c_water=1.480;

% It has three data set; 1: past, 2: current, 3: future.
u = zeros(N,N,3);
c = ones(N,N)*c_air;
c(12:38, 75:93) = c(12:38, 75:93) / c_air * c_water;
s = 0.5;

% Gaussian Pulse
[X,Y] = meshgrid(x,y);
x0 = 10;
y0 = 2;
init_u = 2*exp(-2*(X-x0).^2-2*(Y-y0).^2);
u(:,:,1) = init_u;
u(:,:,2) = init_u;

% Plot the initial condition.
handle_surf = surf(X,Y,init_u);
axis([0,xL,0,yL,-2,8]);
xlabel('x');
ylabel('y');
title('2D Wave equation');

% Dirichet Boundary conditions
u(1,:,:) = 0;
u(end,:,:) = 0;
u(:,1,:) = 0;
u(:,end,:) = 0;
u(1:51, 34:69, :) = 0;

dx = x(2) - x(1);  % spacing in x-direction
dy = y(2) - y(1);  % spacing in y-direction
fprintf('dx = %d\n', dx);
fprintf('dy = %d\n', dy);
dt = 0.05;
filename = 'wave2D_with_diffrent_regions.gif';
for ii=1:1500
    % disp(['at ii= ', num2str(ii)]);
    % advance time
    u_n_ij =u(2:end-1,2:end-1,2);
    u_mn_ij=u(2:end-1,2:end-1,1);
    u_n_pij=u(3:end+0,2:end-1,2);
    u_n_mij=u(1:end-2,2:end-1,2);
    u_n_ipj=u(2:end-1,3:end+0,2);
    u_n_imj=u(2:end-1,1:end-2,2);

    c_c =c(2:end-1,2:end-1);
    c_px=c(3:end+0,2:end-1);
    c_mx=c(1:end-2,2:end-1);
    c_h_px = (c_px+c_c)/2;
    c_h_mx = (c_mx+c_c)/2;
    c_py=c(2:end-1,3:end+0);
    c_my=c(2:end-1,1:end-2);
    c_h_py = (c_py+c_c)/2;
    c_h_my = (c_my+c_c)/2;
    u(2:end-1,2:end-1,3) = 2*u_n_ij - u_mn_ij + (dt*c_h_px/dx).^2.*(u_n_pij-u_n_ij) ...
		                                      + (dt*c_h_mx/dx).^2.*(u_n_mij-u_n_ij) ...
   		                                      + (dt*c_h_py/dy).^2.*(u_n_ipj-u_n_ij) ...
		                                      + (dt*c_h_my/dy).^2.*(u_n_imj-u_n_ij);
    
    u(1:51, 34:69, :) = 0;
    u(:,:,1) = u(:,:,2);
    u(:,:,2) = u(:,:,3);

    % update the figure
    handle_surf.ZData = u(:,:,2);
    drawnow;

    % capture frame to generate gif
    frame = getframe(gcf);
    im = frame2im(frame);
    im = imresize(im,0.5);
    [A,map] = rgb2ind(im,128);
    if ii==1
        imwrite(A,map,filename,'gif','LoopCount',Inf,'DelayTime',0.02);
    else
        imwrite(A,map,filename,'gif','WriteMode','append','DelayTime',0.02);
    end
end

fprintf('GIF file %s created.\n', filename);