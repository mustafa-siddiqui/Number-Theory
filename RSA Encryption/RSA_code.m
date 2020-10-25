%{
    This file contains functions which encode a message using the RSA
    encryption algorithm and decode a message encrypted using the RSA 
    encryption algorithm. Additional functions include ones that perform
    modular exponentiation, finding modular multiplicative inverse of a
    number and converting a decimal number to a binary character array.
    The decryption algorithm works on the fact that the private key
    parameters are provided to it. Those parameters are calculated in the 
    'main' part of the file.
    Mustafa Siddiqui
    10/24/2020
%}

% main 

% original message to be encrypted
message = 'MSLIKETHISCOURSE';

% public key parameters
n = 362783;
e = 19;

% private key parameters
% n = p * q
% find d using the fact that it is the modular inverse of e mod (p-1)*(q-1)
p = 887;
q = 409;
d = modMultInv(e, (p- 1 ) * (q - 1));

Code = EnCode(message, n, e);

message = DeCode(Code, n, d);

% -- %

%{
    Function to encode a message with the RSA Encryption Algorithm which
    uses modular exponentiation to work. The returned array (containing 
    numbers) is the encryption of the message passed into the function.
    Parameters:
        message = text to be encoded
        n, e = public key parameters
    Note:
        The public key parameters, n and e, correspond to the divisor and 
        the exponent in the modular exponentiation carried out for
        encryption.
%}
function output = EnCode(message, n, e)
    % character array to store the alphabet
    letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    
    % calculate size of block by computing 2N
    % TO BE CONFIRMED (doesn't work for general cases)
    numDigits = 0;
    temp = n;
    while (temp > 1)
        numDigits = numDigits + 1;
        temp = temp / 10;
    end
    if (mod(numDigits, 2) ~= 0)
        numDigits = numDigits - 1;
    end
    blockSize = numDigits / 2;

    % concatenate message with 'X' if cannot be divided into sections of width
    % equal to blockSize
    r = mod(length(message), blockSize);
    if (r ~= 0)
        for c = 1:(blockSize - r)
            message = strcat(message, 'X');
        end
    end

    % convert character to their integer index position
    blockNum = zeros(length(message), 1);
    for i = 1:length(message)
        for j = 1:length(letters)
            if (message(i) == letters(j))
                blockNum(i) = j - 1;
            end
        end
    end

    % convert integers into 2 character elements in an array
    charArray = cell(length(message), 1);
    for i = 1:length(message)
        if (blockNum(i) < 10)
            charArray{i} = strcat('0', int2str(blockNum(i)));
        else
            charArray{i} = char(int2str(blockNum(i)));
        end
    end

    % concatenate character array into one character string
    string = '';
    for j = 1:length(message)
        string = strcat(string, charArray{j});
    end
    
    % store string as symbolic variable as converting into a number or
    % double loses precision & last digits are corrupted
    num = sym(string);

    % divide the number into blocks of width equal to blockSize
    divisor = 10 ^ blockSize;
    numOfBlocks = length(string) / blockSize;
    numArray = zeros(numOfBlocks, 1);
    for i = numOfBlocks:-1:1
        [num, numArray(i)] = quorem(sym(num), divisor);
    end

    % encrypt message by performing modular exponentiation
    % each number in the output array should have 2N digits where N is the
    % block size determined earlier
    output = cell(length(numArray), 1);
    for i=1:length(numArray)
        numArray(i) = modExponentiation(numArray(i), dec_to_bin(e), n);
        output{i} = int2str(numArray(i));
        lengthString = length(output{i});
        if (lengthString ~= (2 * blockSize))
            for c = 1:((2 * blockSize) - lengthString)
                output{i} = strcat('0', output{i});
            end
        end
    end
end

%{
    Function to decrypt a message encoded using the RSA encryption
    algorithm. It makes of modular exponentiation and some key relations
    between the selected private and public keys to decrypt.
    The returned string is the original message sent.
    Parameters:
        Code = RSA encryption of the original message (array)
        n = public key parameter
        d = private key parameter
    Note:
        The function requires that the private key parameter is provided to
        it. d should be such that it is the modular multiplicative inverse
        of n mod (p-1)*(q-1) where p and q are two prime numbers such that
        n = p*q.
    Note:
        This function will return any padded 'X's during encryption as part
        of the returned string and not remove them.
%}
function stringFinal = DeCode(Code, n, d)
    % character array to store the alphabet
    letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    % decrypt the encrypted number using modular exponentiation as such:
    % M_i = C_i ^ d mod n
    % where C_i represents each element in the encoded array and M_i
    % represents the corresponding decoded element
    M = cell(length(Code), 1);
    for i = 1:length(Code)
        M{i} = modExponentiation(str2double(Code{i}), dec_to_bin(d), n);
    end
    
    % extend the decoded elements to the same number of digits
    lengthOfElements = zeros(length(M), 1);
    for k = 1:length(M)
        M{k} = int2str(M{k});
        lengthOfElements(k) = length(M{k});
    end
    numDigits = max(lengthOfElements);
    
    for c = 1:length(M)
        for d = 1:(numDigits - length(M{c}))
            M{c} = strcat('0', M{c});
        end
    end

    % combine 3-digit entries into one big string
    stringTemp = '';
    for i = 1:length(M)
        stringTemp = strcat(stringTemp, M{i});
    end
    num = sym(stringTemp);

    % the length of the number will always be divisible by 2 since each letter
    % is represented by 2 digits, hence the length is a multiple of 2
    % Divide the num into groups of 2 so that the associated alphabetic 
    % characters can be found and stored in a string
    divisor = 100;
    textArray = cell(length(stringTemp)/2, 1);
    temp = num;
    stringFinal = '';
    for j = (length(stringTemp) / 2):-1:1
        [temp, textArray{j}] = quorem(sym(temp), divisor);
        for c = 1:length(letters)
            % compare with (c-1) since our letter encoding starts with A = 00
            if (textArray{j} == (c - 1))
                stringFinal = strcat(stringFinal, letters(c));
            end
        end
    end

    % reverse the string to produce the original message
    stringFinal = reverse(stringFinal);
end


%{
    for modular exponentiation: b^n mod m
    b = some positive integer
    n = binary number array
    m = some positive integer
    e.g. 3^13 mod 17
%}
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

%{
    Function to calculate the modular multiplicative inverse of a number
    given as such - a (mod m).
    Returns 0 if the inverse does not exist.
%}
function inverse = modMultInv(a, m)
    [g, c, ~] = gcd(a, m);
    if (g == 1)
        inverse = mod(c, m);
    else
        disp('Modular Multiplicative Inverse does not exist for given number');
        inverse = 0;
    end
end

%{ 
    Function to convert decimal to binary representation. Converts decimal
    number to binary number array.
%}
function binaryNum = dec_to_bin(decimalNum)
    % Subtracting '0' from the character array returned by dec2bin()
    % results in ASCII value of '0' being subtracted the string and the 
    % result stored as a number array
    binaryNum = dec2bin(decimalNum) - '0';
end
