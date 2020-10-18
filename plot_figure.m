m = [50 100 500 1000 5000 10000];

plot(m, time_elapsed_bubble);
%plot(log(m), log(time_elapsed_bubble));

hold on

plot(m, time_elapsed_quick1);
plot(m, time_elapsed_quick2);
%plot(log(m), log(time_elapsed_quick1));
%plot(log(m), log(time_elapsed_quick2));

title('Execution time for different sorting algorithms');
legend('bubble sort', 'quick sort 1', 'quick sort 2');
xlabel('Number of elements in array');
ylabel('Execution Time (s)');

hold off