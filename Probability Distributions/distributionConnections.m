%{
    Random Variables and Distributions
    Exploring the connections among Binomial, Poisson and Normal 
    Distributions.
    Mustafa Siddiqui
    12/04/2020
%}

%% Binomial Distribution
n = [10, 20, 30, 50];
mean = 7;

% cell array to store the binomial pmfs and cdfs
binomial = cell(length(n), 2);

for i = 1:length(n)
    pmfPoisson = zeros(n(i), 1);
    cdfPoisson = zeros(n(i), 1);
    
    % mean = n * p
    p = mean / n(i);
    
    for k = 1:n(i)
        % calculate pmf
        % P(X=k) = nCk * p^k * (1-p)^(n-k), for k = [0, n]
        pmfPoisson(k) = binomCoefficient(n(i), k) * p^k * (1-p)^(n(i)-k);
        
        % calculate cdf
        if (k == 1)
            cdfPoisson(k) = pmfPoisson(k);
        elseif (k < n(i))
            cdfPoisson(k + 1) = cdfPoisson(k) + pmfPoisson(k);
        end
    end
    
    % store pmfs and cdfs in cell array
    binomial{i, 1} = pmfPoisson;
    binomial{i, 2} = cdfPoisson;
end

% plot pmfs and cdfs on the same plot
figure(1);
c1 = [1, 3, 5, 7];
c2 = [2, 4, 6, 8];
for j = 1:length(n)
    subplot(4, 2, c1(j));
    stem(1:n(j), binomial{j, 1});
    title(sprintf('pmf for n = %d', n(j)));
    xlabel('k');
    ylabel('P(X = k)');
    hold on;
    subplot(4, 2, c2(j));
    stem(1:n(j), binomial{j, 2});
    title(sprintf('cdf for n = %d', n(j)));
    xlabel('k');
    ylabel('P(X <= k)');
end
hold off;
sgtitle('Binomial Distribution');

%% Poisson Distribution
t = 1;
lambda = 7;
alpha = lambda * t;
n = 21;

pmfPoisson = zeros(21, 1);
cdfPoisson = zeros(21, 1);
for i = 1:n
    pmfPoisson(i) = (alpha^(i-1) * exp(-alpha)) / factorial(i-1);
    if (i == 1)
        cdfPoisson(i) = pmfPoisson(i);
    elseif (i < n)
        cdfPoisson(i + 1) = cdfPoisson(i) + pmfPoisson(i);
    end
end

% plot pmf and cdf on the same plot
figure(2);
subplot(2, 1, 1);
stem(0:(n-1), pmfPoisson);
title('pmf');
xlabel('k');
ylabel('P(X = k)');
hold on;

subplot(2, 1, 2);
stem(0:(n-1), cdfPoisson);
title('cdf');
xlabel('k');
ylabel('P(X <= k)');
hold off;
sgtitle('Poisson Distribution');

%% Connecting Binomial and Poisson Distributions
n = 100;
t = 1;
lambda = 7;
alpha = lambda * t;
p = lambda / n;

pmfBinomial = zeros(n+1, 1);
for i = 0:n
    pmfBinomial(i + 1) = binomCoefficient(n, i) * p^i * (1 - p)^(n - i); 
end

pmfPoisson = zeros(n+1, 1);
for k = 0:n
    pmfPoisson(k + 1) = (alpha^k * exp(-alpha)) / factorial(k);
end

% plot both pmfs on the same figure
figure(3);
subplot(2, 1, 1);
stem(0:20, sym(pmfBinomial(1:21)));
title('pmf for Binomial Distribution');
xlabel('k')
ylabel('P(X = k)');
hold on;

subplot(2, 1, 2);
stem(0:20, sym(pmfPoisson(1:21)));
title('pmf for Poisson Distribution');
xlabel('k')
ylabel('P(X = k)');
hold off;
sgtitle('Connection between Binomial and Poisson Distributions');

%% Connecting Binomial and Normal Distributions
n = [10, 20, 30, 50];
p = 0.7;
x = 1000;

% cell array to store pdfs and cdfs
normal = cell(length(n), 2);

for i = 1:length(n)
    mean = n(i) * p;
    variance = n(i) * p * (1-p);
    
    pdf = zeros(n(i), 1);
    cdf = zeros(n(i), 1);
    for k = 1:n(i)
        % calculate pdf
        % f_X(x) = 1/(2pi*sigma) * exp(-(x-m)^2/(2*sigma^2)) for x=(-inf,inf)
        pdf(k) = 1/(2*pi * sqrt(variance)) * exp(-(k-mean)^2 / (2*variance));
        
        % calculate cdf
        if (k == 1)
            cdf(k) = pdf(k);
        elseif (k < n(i))
            cdf(k + 1) = cdf(k) + pdf(k);
        end
    end
    
    % store pdfs and cdfs in cell array
    normal{i, 1} = pdf;
    normal{i, 2} = cdf;
end

% plot pmfs and cdfs on the same plot
figure(4);
c1 = [1, 3, 5, 7];
c2 = [2, 4, 6, 8];
for j = 1:length(n)
    subplot(4, 2, c1(j));
    plot(1:n(j), normal{j, 1});
    title(sprintf('pdf for n = %d', n(j)));
    xlabel('k');
    ylabel('P(X = k)');
    hold on;
    subplot(4, 2, c2(j));
    plot(1:n(j), normal{j, 2});
    title(sprintf('cdf for n = %d', n(j)));
    xlabel('k');
    ylabel('P(X <= k)');
end
hold off;
sgtitle('Normal Distribution');

%% Functions

%{ 
    Calculate Binomial Coefficient with large numbers.
    Makes use of symbolic variables to keep precision for large values
    c = n! / ((n-k)! * k!)
%}
function c = binomCoefficient(n, k)
    if (k > n)
        c = 0;
        disp('ERROR (binomCoefficient): k is larger than n');
        return;
    end
    c = factorial(sym(n)) / (factorial(sym(n - k)) * factorial(sym(k)));
    c = sym(c);
end





