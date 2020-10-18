% @file     Lab2_bubblesort.m
% @brief    Bubble sort implementation.
% @author   Mustafa Siddiqui
% @date     09/30/2020

% array for storing elapsed times
time_elapsed_bubble = zeros(6, 1);

% measure time & sort
tic
bubble_1 = bubble_sort(list_1);
time_elapsed_bubble(1) = toc;

tic
bubble_2 = bubble_sort(list_2);
time_elapsed_bubble(2) = toc;

tic
bubble_3 = bubble_sort(list_3);
time_elapsed_bubble(3) = toc;

tic
bubble_4 = bubble_sort(list_4);
time_elapsed_bubble(4) = toc;

tic
bubble_5 = bubble_sort(list_5);
time_elapsed_bubble(5) = toc;

tic
bubble_6 = bubble_sort(list_6);
time_elapsed_bubble(6) = toc;

% function for bubble sort
function sorted_array = bubble_sort(array)
    sorted_array = array;
    array_length = length(sorted_array);
    for i = 1:(array_length - 1)
        swapped = false;
        
        for j = 1:(array_length - 1)
            if (sorted_array(j) > sorted_array(j+1))
                % swap values
                temp = sorted_array(j);
                sorted_array(j) = sorted_array(j+1);
                sorted_array(j+1) = temp;
                
                swapped = true;
            end
        end
        
        % if swapped is false, then array is sorted now
        if (swapped == false)
            break;
        end
    end
end
