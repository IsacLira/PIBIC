
function [Hlos]=planarHlos(nRx,nTx)

%Spherical coordenates of each receive
theta=(rand(1,nTx)-0.5)*2*pi/3;
phi=(rand(1,nTx)-0.5)*2*pi/3;

%Angle of rotation about x axis
alpha=pi/18;

% Original rectangular coordenates with tetha and phi dependences
uxo=pi*sin(theta).*cos(phi);
uyo=pi*sin(theta).*sin(phi);
uzo=pi*cos(theta);

% Rotate the coordenate system using the rotation matrix
% R=[1 0 0; 0 cos -sin;0 sin cos]
ux=uxo;
uy=uyo*cos(alpha)-uzo*sin(alpha);
uz=uyo*sin(alpha)+uzo*cos(alpha);

%Generate the Hlos Matrix
Hlos=zeros(nRx,nTx);
for k=1:nTx
    hlos=meshgrid([0:sqrt(nRx)-1])*(ux(k))+meshgrid([0:sqrt(nRx)-1])'*uz(k);
    hlos=exp(-j*hlos);
    Hlos(:,k)=hlos(:);
end
Hlos=Hlos./sqrt(nTx);

%plots
c=sqrt(nRx)-1;
p1 = [0 0 0];
p2 = [0 0 c];
p3 = [c 0 c];
p4 = [c 0 0];

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];
figure
fill3(x, y, z, 'w');
xlabel('x'); ylabel('y'); zlabel('z');
grid on

[X,Z] = meshgrid(0:c);

hold on
plot3(X, [0 0 0 0], Z, 'b.', 'MarkerSize', 20);

R=[1 0 0; 0 cos(alpha) -sin(alpha);0 sin(alpha) cos(alpha)];
p1 = p1*R;
p2 =p2*R;
p3 = p3*R;
p4 = p4*R;

x = [p1(1) p2(1) p3(1) p4(1)];
y = [p1(2) p2(2) p3(2) p4(2)];
z = [p1(3) p2(3) p3(3) p4(3)];

X =tan(alpha)*meshgrid(0:c);
Z = meshgrid(0:c);
Y = meshgrid(0:c)';

figure
fill3(x, y, z, 'w');
xlabel('x'); ylabel('y'); zlabel('z');

hold on
plot3(Y,X,Z, 'b.', 'MarkerSize', 30);
grid on

