function [ password ] = createPassword()
%creates a random 8 character password
symbols = ['a':'z' 'A':'Z' '0:9'];
numRands = length(symbols);
pwlength = 8;
password = symbols(ceil(rand(1, pwlength).*numRands));

end

