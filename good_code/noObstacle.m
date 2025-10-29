N = 101;
% L = 4*pi;
xL = 12;
yL = 23;
x = linspace(0,xL,N);
y = linspace(0,yL,N);

% It has three data set; 1: past, 2: current, 3: future.
u = zeros(N,N,3);
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
axis([0,xL,0,yL,-2,2]);
xlabel('x');
ylabel('y');
title('2D Wave equation');

% Dirichet Boundary conditions
u(1,:,:) = 0;
u(end,:,:) = 0;
u(:,1,:) = 0;
u(:,end,:) = 0;
u(1:51, 34:69, :) = 0;

filename = 'wave2D_no_obstacle.gif';
for ii=1:500
    % disp(['at ii= ', num2str(ii)]);
    % advance time
    u(2:end-1,2:end-1,3) = s*(u(2:end-1,3:end,2)+u(2:end-1,1:end-2,2)) ...
        + s*(u(3:end,2:end-1,2)+u(1:end-2,2:end-1,2)) ...
        + 2*(1-2*s)*u(2:end-1,2:end-1,2) ...
        - u(2:end-1,2:end-1,1);
    %u(1:53, 33:73, :) = 0;
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