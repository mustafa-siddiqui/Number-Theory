%{
    Random Variables and Distributions
    Converting random numbers with uniform distribution to other probability 
    distributions.
    Mustafa Siddiqui
    12/04/2020
%}

%% Produce 10^5 random numbers with the Linear Congruential Method
totalNum = 10^5;
seed = 6734;
a = 16807;
m = 2147483647;
c = 0;

% initialize array of 10^5 numbers to zero & set first element equal to seed
numbers = zeros(totalNum, 1);
numbers(1) = seed;

% produce 10^5 numbers with the linear congruential method
% x[i+1] = (a * x[i] + c) mod m
for i = 1:(totalNum - 1)
    numbers(i+1) = mod(((a * numbers(i)) + c), m);
end

% limit numbers to be in the unit interval
Rn = numbers / m;

% plot histogram of Rn
figure(1);
histogram(Rn);
title('Histogram of Uniformly Distributed Random Numbers in the Unit Interval');
xlabel('Value');
ylabel('Amount');

%% Conversion to Bernoulli Distribution
% count the number of successes: values in [0, 0.3)
bernoulli = Rn < 0.3;
success = sum(bernoulli);

% calculate pmf
% P(X=1) = p, P(X=0) = 1 - p
p = success / totalNum;
q = 1 - p;
pq = [p, q];

figure(2);
bar([1, 0], pq);
title('Bernoulli Distribution');
xlabel('Failure, Success');
ylabel('P(X)');

%% Conversion to Poisson Distribution
% if alpha = 3, k = 0-10, comparison element = 3/10 = 0.3
k = zeros(11, 1);
success = 0;

% run 10^5 comparisons and record the number of successes per every 10
% elements according to the number of successes found
% i.e. if 3 successes, increment pmfPoisson(3) by 1
c = 1;
for i = 1:1000
    for j = 1:10
        if (Rn(c) < 0.3)
            success = success + 1;
        end
        c = c + 1;
    end
    
    % record how many number of successes per every 10 elements
    k(success + 1) = k(success + 1) + 1;
    success = 0;
end

% scale to appropriate probabilities (< 1)
k = k / 1000;

figure(3);
stem((0:10), k);
title('Poisson Distribution');
xlabel('k');
ylabel('P(N=k)');

%% Poisson Distribution Application

%{
    The number X of photons counted by a receiver in an optical 
    communication system is a Poisson random variable with rate λ1 = 7 when
    a signal is present and a Poisson random variable with rate λ0 = 2 when
    a signal is absent. The probability for the signal to be present is 
    0.5. You should decide that a signal is present when 
    P[signal present|X = k] > P[signal absent|X = k]; otherwise, you should
    decide that the signal is absent. Plot the pmf of P[signal present|X = k] 
    and P[signal absent|X = k] in one figure to find out when the signal
    should be present and when it should be absent.
%}

%% Poisson Distribution Application - All Times [1,10]
t = 1:10;
alpha1 = zeros(10, 1);
alpha0 = zeros(10, 1);

for i = 1:10
    alpha1(i) = 7 * t(i);
    alpha0(i) = 2 * t(i);
end

pmfPoisson1 = zeros(11, 10);
pmfPoisson0 = zeros(11, 10);

% calculate pmf & plot graphs for all ks with all times for 
% P(SignalPresent | X=k)
% P(N=k) = α^k/k! * e^(-α) for k = 0,1,...
% This shows that the overall trend is the same for all values of time
figure(4);
for k = 1:11
    for i = 1:10
        pmfPoisson1(k, i) = (alpha1(i)^(k-1) * exp(-alpha1(i))) / ((alpha1(i)^(k-1) * exp(-alpha1(i))) + (alpha0(i)^(k-1) * exp(-alpha0(i))));
        pmfPoisson0(k, i) = (alpha0(i)^(k-1) * exp(-alpha0(i))) / ((alpha1(i)^(k-1) * exp(-alpha1(i))) + (alpha0(i)^(k-1) * exp(-alpha0(i))));
    end
    plot(1:10, pmfPoisson1(k, :));
    hold on;
end
hold off;

% produces the sames figure as the section below (time = 1)
figure(6);
plot(0:10, pmfPoisson1(:, 1));
hold on;
plot(0:10, pmfPoisson0(:, 1));
plot(0:10, pmfPoisson1(:, 1) > pmfPoisson0(:, 1));
hold off;
title('Poisson Distribution Application');
xlabel('k');
ylabel('P(N=k)');
legend('P(Signal Present | X = k)', 'P(Signal Absent | X = k)', 'Signal Present');

%% Poisson Distribution Application - Time = 1
t = 1;
alpha1 = 7 * t;
alpha0 = 2 * t;

% Note that the factorials in the denominator get cancelled out
% P(SignalPresent | X = k)
% P(SignalPresent | X = k) = P(X=k | SignalPresent) / (P(X=k | SignalPresent) + P(X=k | SignalAbsent))
pmfPoisson1 = zeros(10, 1);

% P(SignalAbsent | X = k)
% P(SignalPresent | X = k) = P(X=k | SignalAbsent) / (P(X=k | SignalPresent) + P(X=k | SignalAbsent))
pmfPoisson0 = zeros(10, 1);

% calculate pmf
% P(N=k) = α^k/k! * e^(-α) for k = 0,1,...
for k = 1:11
    pmfPoisson1(k) = (alpha1^(k-1) * exp(-alpha1)) / ((alpha1^(k-1) * exp(-alpha1)) + (alpha0^(k-1) * exp(-alpha0)));
    pmfPoisson0(k) = (alpha0^(k-1) * exp(-alpha0)) / ((alpha1^(k-1) * exp(-alpha1)) + (alpha0^(k-1) * exp(-alpha0)));
end

% signal is present when P(SignalPresent | X=k) > P(SignalAbsent | X=k)
signalPresent = pmfPoisson1 > pmfPoisson0;

% plot all graphs on the same figure
figure(5);
stem(0:10, pmfPoisson1);
hold on;
stem(0:10, pmfPoisson0);
stem(0:10, signalPresent);
hold off;
title('Poisson Distribution Application');
xlabel('k');
ylabel('P(X=k)');
legend('P(Signal Present | X = k)', 'P(Signal Absent | X = k)', 'Signal Present');


