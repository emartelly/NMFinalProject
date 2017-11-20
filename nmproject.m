clear all
%% Constants
%%% Constant Definitions
n = 3; %number of nodes
L = 3; %beam length
Le = L/n;% element length
EI = 1; %Young's Modulus and Moment of Inertia for beam
p = 1; % Density 

%% Mass Matrix
%Populate Mass Matrix
Me = zeros(4);

%Mass matrix for one element
Me(1,1) = 156;
Me(2,1) = 22*Le;
Me(3,1) = 54;
Me(4,1) = -13*Le;

Me(2,2) = 4*Le^2;
Me(3,2) = 13*Le;
Me(4,2) = -3*Le^2;

Me(3,3) = 156;
Me(4,3) = -22*Le;

Me(4,4) = 4*Le^2;

% Reflect matrix along diagonal
Me = Me+tril(Me,-1).';

N = 2*n + 2; %dimensions of final matrix

%Mass matrix for all elements
M = zeros(N);

[r,c]=size(Me);
d = 0;
for i = 1:n
    xpos=i+d;ypos=i+d;
    M(xpos:xpos+r-1,ypos:ypos+c-1)=Me;
    d = d+1;
end

% Adjust for elements where nodes add up
for i=3:N-2
    if mod(i,2) == 1
        M(i,i) = 156*2;
        M(i+1,i) = 0;
        M(i,i+1) = 0;
    else
        M(i,i) = 8*Le^2;
        M(i+1,i) = 13*Le;
        M(i,i+1) = 13*Le;
    end
end

M = ((p*Le)/420)*M;

%% Stiffness Matrix
% Populate Stiffness Matrix
Ke = zeros(4);

%Mass matrix for one element
Ke(1,1) = 12;
Ke(2,1) = 6*Le;
Ke(3,1) = -12;
Ke(4,1) = 6*Le;

Ke(2,2) = 4*Le^2;
Ke(3,2) = -6*Le;
Ke(4,2) = 2*Le^2;

Ke(3,3) = 12;
Ke(4,3) = -6*Le;

Ke(4,4) = 4*Le^2;

% Reflect matrix along diagonal
Ke = Ke+tril(Ke,-1).';

N = 2*n + 2; %dimensions of final matrix

%Mass matrix for all elements
K = zeros(N);

[r,c]=size(Me);
d = 0;
for i = 1:n
    xpos=i+d;ypos=i+d;
    K(xpos:xpos+r-1,ypos:ypos+c-1)=Ke;
    d = d+1;
end

% Adjust for elements where nodes add up
for i=3:N-2
    if mod(i,2) == 1
        K(i,i) = 24;
        K(i+1,i) = 0;
        K(i,i+1) = 0;
    else
        K(i,i) = 8*Le^2;
        K(i+1,i) = -6*Le;
        K(i,i+1) = -6*Le;
    end
end

M = ((p*Le)/420)*M;