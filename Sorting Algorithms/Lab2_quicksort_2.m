% @file     Lab2_quicksort_2
% @brief    Code for implementing the quick sort algorithm with the first
%           value as the pivot.
% @author   Mustafa Siddiqui
% @date     10/02/2020

% main
quick2_1 = quick1_1;
quick2_2 = quick1_2;
quick2_3 = quick1_3;
quick2_4 = quick1_4;
quick2_5 = quick1_5;
quick2_6 = quick1_6;

% array for storing elapsed time
time_elapsed_quick2 = zeros(6, 1);

% measure time & sort
tic
quick2_1 = quick_sort_2(quick2_1, 1, 50);
time_elapsed_quick2(1) = toc;

tic
quick2_2 = quick_sort_2(quick2_2, 1, 50);
time_elapsed_quick2(2) = toc;

tic
quick2_3 = quick_sort_2(quick2_3, 1, 500);
time_elapsed_quick2(3) = toc;

tic
quick2_4 = quick_sort_2(quick2_4, 1, 1000);
time_elapsed_quick2(4) = toc;

tic
quick2_5 = quick_sort_2(quick2_5, 1, 5000);
time_elapsed_quick2(5) = toc;

tic
quick2_6 = quick_sort_2(quick2_6, 1, 10000);
time_elapsed_quick2(6) = toc;

% for selecting the first value as the pivot
function array = quick_sort_2(array, low, high)
    
    if (low < high)
        % pi = partitioning index
        [pi, array] = partition_2(array, low, high);
        
        % separately sort elements before & after partitioning index
        array = quick_sort_2(array, low, (pi - 1));
        array = quick_sort_2(array, (pi + 1), high);
    end
    
end

function [pi, array] = partition_2(array, low, high)
    % pivot is first value
    pivot = array(low);
    
    % initialize partioning index
    pi = low + 1;
    
    % if current value is less than the pivot
    for j = (low + 1):high
        if (array(j) < pivot)
            temp = array(j);        % swap elements
            array(j) = array(pi);
            array(pi) = temp;
            pi = pi + 1;            % increment index of smaller element
        end
    end
    
    % swap first element
    temp = array(low);
    array(low) = array(pi - 1);
    array(pi - 1) = temp;
    
    pi = pi - 1;
end
