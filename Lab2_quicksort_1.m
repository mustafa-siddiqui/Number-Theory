% @file     Lab2_bubblesort.m
% @brief    Quick sort implementation #1.
% @author   Mustafa Siddiqui
% @date     09/31/2020

% main
quick1_1 = list_1;
quick1_2 = list_2;
quick1_3 = list_3;
quick1_4 = list_4;
quick1_5 = list_5;
quick1_6 = list_6;

% array for storing elapsed time
time_elapsed_quick1 = zeros(6, 1);

% measure time & sort
tic
quick1_1 = quick_sort_1(quick1_1, 1, 50);
time_elapsed_quick1(1) = toc;

tic
quick1_2 = quick_sort_1(quick1_2, 1, 100);
time_elapsed_quick1(2) = toc;

tic
quick1_3 = quick_sort_1(quick1_3, 1, 500);
time_elapsed_quick1(3) = toc;

tic
quick1_4 = quick_sort_1(quick1_4, 1, 1000);
time_elapsed_quick1(4) = toc;

tic
quick1_5 = quick_sort_1(quick1_5, 1, 5000);
time_elapsed_quick1(5) = toc;

tic
quick1_6 = quick_sort_1(quick1_6, 1, 10000);
time_elapsed_quick1(6) = toc;

% function definitions

% for selecting the last value as the pivot
function array = quick_sort_1(array, low, high)
    
    if (low < high)
        % pi = partitioning index
        [pi, array] = partition_1(array, low, high);
        
        % separately sort elements before & after partitioning index
        array = quick_sort_1(array, low, (pi - 1));
        array = quick_sort_1(array, (pi + 1), high);
    end
    
end

function [pi, array] = partition_1(array, low, high)
    % pivot is last value
    pivot = array(high);
    
    % initialize partioning index
    pi = low - 1;
    
    % if current value is less than the pivot
    for j = low:(high-1)
        if (array(j) < pivot)
            pi = pi + 1;            % increment index of smaller element
            temp = array(j);        % swap elements
            array(j) = array(pi);
            array(pi) = temp;
        end
    end
    
    % swap last element
    temp = array(high);
    array(high) = array(pi + 1);
    array(pi + 1) = temp;
    
    pi = pi + 1;
end