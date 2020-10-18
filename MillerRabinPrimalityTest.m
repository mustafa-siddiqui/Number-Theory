%{      @file   MillerRabinPrimalityTest.m
        @brief  This script contains a function that implements the Miller Rabin 
                Primality Test on the entered integer numbers. The output is 1 if 
                the number is prime and 0 if the number is composite.
                Additionally, the program contains a function that generates 
                10-digit pseudo-random numbers with last digits 1, 3, 7, or 9. The
                script implements the Miller Rabin Primality Test on the number. The
                number is incremented in a certain manner until the resulting number
                is a prime number. Thus, a 10-digit prime number is generated.
        @author Mustafa Siddiqui
        @date   10/16/2020
%}

% array to hold all prime numbers less than 500
global aV;
aV = [  2 3 5 7 11 13 17 19 23 29 ...
        31 37 41 43 47 53 59 61 67 71 ...
        73 79 83 89 97 101 103 107 109 113 ...
        127 131 137 139 149 151 157 163 167 173 ...
        179 181 191 193 197 199 211 223 227 229 ...
        233 239 241 251 257 263 269 271 277 281 ...
        283 293 307 311 313 317 331 337 347 349 ...
        353 359 367 373 379 383 389 397 401 409 ...
        419 421 431 433 439 443 449 457 461 463 ...
        467 479 487 491 499 ]; 

%--%    
 
% main %
k = zeros(10, 1);
for i = 1:10
    [privateNum, lastDigit] = random();
    while (Miller_Rabin(sym(privateNum)) == 0)
        % random() returns an odd number
        % last digit can never be 5 since when it's 3, we add 4
        if (lastDigit == 3)
            privateNum = privateNum + 4;
        else 
            privateNum = privateNum + 2;
        end

        % update last digit
        lastDigit = rem(privateNum, 10);
        
        % update k
        k(i) = k(i) + 1;
    end
end

average_k = sum(k) / 10;

%--%

% function for implementing the primality test %
function out = Miller_Rabin(n)
    global aV;
    
    % composite number if divisible by 2
    if (mod(n, 2) == 0)
        out = 0;
        return;
    end
    
    % if n is less than 500, check if in array of prime numbers
    if (n > 1 && n < 500)
        out = ismember(n, aV);
        return;
    end 
    
    % if n >= 500
    % express n - 1 = 2^r * d
    d = n - 1;
    r = 0;
    while (rem(d, 2) == 0)
        d = d / 2;
        r = r + 1;
    end
    
    % convert d into binary vector
    A = dec_to_bin(d);
    
    % perform modular exponentiation to get x = w^d mod n
    % W loop
    for i = 1:length(aV)
        x = modExponentiation(aV(i), A, n);
        if (x == 1 || x == n-1)
            continue;
        end
        
        % R loop
        for j = 1:(r - 1)
            x = mod((x * x), n);
            
            if (x == 1)
                % return composite
                out = 0;
                return;
            end
            if (x == n-1)
                % should continue to W loop
                break;
            end
        end
        
        if (x ~= n-1)
            % return composite
            out = 0;
            return;
        end
    end
    
    % return prime
    out = 1;
end

% function to convert decimal to binary representation
function binaryNum = dec_to_bin(decimalNum)
    % convert number to binary number array
    % subtracting '0' from the character array returned by dec2bin()
    % results in ASCII value of '0' being subtracted the string and the 
    % result stored as a number array
    binaryNum = dec2bin(decimalNum) - '0';
end

% for modular exponentiation: b^n mod m
% b = some positive integer
% n = binary number array
% m = some positive integer
% e.g. 3^13 mod 17
function x = modExponentiation(b, n, m)
    % following the pseudocode on page 3 of handout 2: Number Theory and
    % Applications
    
    x = 1;
    power = mod(b, m);
    
    % since binary number is to be compared starting from the right side
    for i = length(n):-1:1
        if (n(i) == 1)
            x = mod((x * power), m);
        end
        power = mod((power * power), m);
    end
end

% function to generate a 10-digit pseudo-random number
function [randNum, lastDigit] = random()
    while(1)
        % get a random 10-digit number and truncate to get integer
        randNum = fix((1000000000 * rand()) + 1000000000);

        % convert number to string and get last digit
        lastDigit = rem(randNum, 10);
        
        if (lastDigit == 1 || ...
            lastDigit == 3 || ... 
            lastDigit == 7 || ... 
            lastDigit == 9)
            break;
        end
    end 
end
