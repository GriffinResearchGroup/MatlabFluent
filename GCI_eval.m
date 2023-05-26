% This is a script to estimate discretization error based on the process
% outlined by the Fluids Engineering Division of ASME

% Celik, I. B., Ghia, U., Roache, P. J., Freitas, C. J., Coleman, H., & 
% Raad, P. E. (2008). Procedure for estimation and reporting of uncertainty 
% due to discretization in CFD applications. Journal of Fluids Engineering, 
% Transactions of the ASME, 130(7), 0780011–0780014.
% https://doi.org/10.1115/1.2960953/444689</div>

clear

% Define property of interest for each grid, keep in mind Grid 1 is most
% refined and Grid 3 is least refined
phi = [0.73503732989992 0.733017855766725 0.738656272113582];

% Define grid properties, keep in mind Grid 1 is most refined and Grid 3 is
% least refined
V = 6591.961; % Domain volume
N = [11305905 6113692 2077037]; % Number of cells in each grid
h = (V./N).^(1/3);

% Calculate grid refinement factors (r) and difference terms (sigma)
r = [h(2)/h(1) h(3)/h(2)];
sigma = [phi(2)-phi(1) phi(3)-phi(2)];
s = 1 * sign(sigma(2)/sigma(1));

p(1) = 3; % Initial guess of apparent order of accuracy

% Initialize array index and error
i = 1;
error = 1;

% Conduct guess and check until below desired error for apparent order of
% accuracy
while error > 0.00001
    i = i + 1;
    q = log(((r(1)^(p(i-1))) - s)/((r(2)^(p(i-1))) - s));
    p(i) = (1/log(r(1)))*(abs(log(abs(sigma(2)/sigma(1))) + q));
    if i >= 100
        break
    end
    error = abs(p(i)-p(i-1));
end

% Calculate extrapolated value of property of interest
phi_ext = (r(1)^p(i)*phi(1) - phi(2))/(r(1)^p(i) - 1);
% Calculate approximate relative error
e_a = abs((phi(1) - phi(2))/phi(1));
% Calculate extrapolated relative error
e_ext = abs((phi_ext - phi(1))/phi_ext);
% Calculate fine-grid convergence index
GCI = (1.25*e_a)/(r(1)^p(i) - 1);

% Print results to console
formatSpec = 'Apparent order of accuracy = %.4f\n';
fprintf(formatSpec,p(i));
formatSpec = 'Extrapolated value of property = %.6g\n';
fprintf(formatSpec,phi_ext);
formatSpec = 'Approximate relative error = %.4e\n';
fprintf(formatSpec,e_a);
formatSpec = 'Extrapolated relative error = %.4e\n';
fprintf(formatSpec,e_ext);
formatSpec = 'Fine-grid convergence index = %.4e\n';
fprintf(formatSpec,GCI);