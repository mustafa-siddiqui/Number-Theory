% ECE 270 Lab1:   Generating Pseudo-Random Numbers
% Date:           09/16/2020
% Author:         Mustafa Siddiqui

% set variables in the formula: x[n+1] = (a*x[n]+c) mod m
seed = 8;
a = 13;
m = 256;
c = 3;

% initialize array of 300 numbers to zero
numbers = zeros(300, 1);

% set first element equal to seed
numbers(1) = seed;

% produce 300 numbers with the linear congruential method
for i = 1:299
    numbers(i+1) = mod(((a * numbers(i)) + c), m);
end

% save Rn
Rn = numbers / m;

% plot histogram of Rn
histogram(Rn);

%{ --- }%

% initialize variables
m = 2048;
p = 31;
q = 4;

% initialize array with zeros
numArray = zeros(3000, 1);

% copy first 31 elements from previous randomly generated number array
for j = 1:31
    numArray(j) = numbers(j);
end

% generate the rest of the numbers using the Lagged Fibonacci method
for c = 32:3000
    numArray(c) = mod((numArray(c-p) + numArray(c-q)), m);
end

% save Rn
Rn1 = numArray / m;

% plot histogram
%histogram(Rn1);

