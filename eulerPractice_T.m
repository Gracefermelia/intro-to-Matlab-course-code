%% eulerPractice.m
% This program approximates the following differential equation using
% Euler's method and plots the result.
% dy/dx = cos(x)
% y(t=0) = 0
clear
clc
%% Set Parameters
% Set the number of x values used in the x vector
Nx = 50;

% Set the minimum x value considered in the problem
xmin = 0;

% Set the maximum x value considered in the problem
xmax = 5*pi;

%% Initiali ze Vectors
% Create the x vector using the linspace function
x = linspace(xmin,xmax,Nx);

% Calculate deltax based on the first two time points in the x vector
dx = x(2)- x(1);

% Initialize/eepreallocate the x vector
y = zeros(1,Nx);

% Set the initial value of y (at x = 0) to be equal to 0.
y(1) = 0;

%% Calculate Y Values using Euler Method
% March through x vector, calculate the next y from prior y and x values
%y(2) = cos(x(1))*dx;

%method 1
for iy = 1:Nx-1
    y(iy+1)= y(iy) + cos(x(iy))*dx;
end

%% Plot the Results
yreal = sin(x);
plot(x,y,'r--',...
    x, yreal, 'b');

legend('Approximation', 'Exact');