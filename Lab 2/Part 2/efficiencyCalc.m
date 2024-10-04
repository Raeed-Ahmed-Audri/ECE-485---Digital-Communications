fileID = fopen('source.txt', 'r'); 
data = fread(fileID, '*uint8'); 
fclose(fileID); 

unique_symbols = unique(data); 
counts = histc(data, unique_symbols); 
probabilities = counts / length(data); 

% Calculated symbols and their Huffman codeword lengths
symbols = [' ', 'A', 'D', 'G', 'H', 'L', 'M', 'N', 'P', 'T', 'W', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y'];
codeword_lengths = [3, 11, 7, 10, 9, 10, 7, 9, 8, 8, 10, 4, 5, 6, 5, 3, 6, 6, 4, 5, 10, 6, 5, 6, 4, 4, 6, 4, 3, 4, 4, 7, 6, 6, 9, 5];


averageCodewordLength = 0; 

for i = 1:length(unique_symbols)
    symbol = char(unique_symbols(i)); 

    % Find the index of the symbol in the given symbols list
    idx = find(symbols == symbol);

    % If the symbol is found in the given list, calculate the average length
    if ~isempty(idx)
        codewordLength = codeword_lengths(idx); % Get the codeword length for this symbol
        averageCodewordLength = averageCodewordLength + probabilities(i) * codewordLength;
    end
end


entropy = -sum(probabilities .* log2(probabilities)); % Calculate entropy


efficiency = entropy / averageCodewordLength;


disp(['Entropy: ', num2str(entropy)]);
disp(['Average Codeword Length: ', num2str(averageCodewordLength)]);
disp(['Huffman Code Efficiency: ', num2str(efficiency)]);


