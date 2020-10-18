% ECE 270 Lab1:   Generating Pseudo-Random Numbers
% Date:           09/16/2020
% Author:         Mustafa Siddiqui

% return result in a 10,000-element column vector
numbers = rand(10000, 1);

% produce column vector consisting of the mid points
% for 100 bins of width 0.01 in the unit interval
index = 0.005:0.01:0.995;

% display histogram
histogram(numbers, index)
