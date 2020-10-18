% @file   Lab2.m
% @brief  Code for lab 2.
% @author Mustafa Siddiqui
% @date   09/30/2020

% initialize variables
x0 = 3;
a = 21;
c = 7;

% initialize 6 lists
list_1 = zeros(50, 1);
list_2 = zeros(100, 1);
list_3 = zeros(500, 1);
list_4 = zeros(1000, 1);
list_5 = zeros(5000, 1);
list_6 = zeros(10000, 1);

% set first element = 3
list_1(1) = x0;
list_2(1) = x0;
list_3(1) = x0;
list_4(1) = x0;
list_5(1) = x0;
list_6(1) = x0;

% populate lists with the formula: x(n+1) = a*x(n)+c mod m
% list 1
for n=1:49
    list_1(n+1) = mod(((a * list_1(n)) + c), 50);
end

% list 2
for n=1:99
    list_2(n+1) = mod(((a * list_2(n)) + c), 100);
end

% list 3
for n=1:499
    list_3(n+1) = mod(((a * list_3(n)) + c), 500);
end

% list 4
for n=1:999
    list_4(n+1) = mod(((a * list_4(n)) + c), 1000);
end

% list 5
for n=1:4999
    list_5(n+1) = mod(((a * list_5(n)) + c), 5000);
end

% list 6
for n=1:9999
    list_6(n+1) = mod(((a * list_6(n)) + c), 10000);
end


