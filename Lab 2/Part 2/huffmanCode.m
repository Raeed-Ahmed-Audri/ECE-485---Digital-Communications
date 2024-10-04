% Step 1: Read data from the file source.txt
fileID = fopen('source.txt', 'r'); % Opens 'source.txt' in read mode
data = fread(fileID, '*uint8'); % Reads the file contents and saves as 8-bit unsigned integer array
fclose(fileID); % Close the file after reading

% Display the content on the screen (optional)
%disp(char(data')); % Convert the 8-bit data back to characters for display

% Step 2: Find the probability of each symbol
symbols = unique(data); % Find unique symbols in the data
counts = histc(data, symbols); % Count occurrences of each symbol
probabilities = counts / length(data); % Calculate probability of each symbol

% Calculate the entropy of the data
entropy = -sum(probabilities .* log2(probabilities));
disp(['Entropy: ', num2str(entropy)]);

% Step 3: Construct a Huffman code using the huffmandict function
huffmanDict = huffmandict(symbols, probabilities); 

% Display the Huffman codewords and their probabilities
disp('Huffman Codewords and Probabilities:');
for i = 1:length(symbols)
    disp(['Symbol: ', char(symbols(i)), ', Codeword: ', num2str(huffmanDict{i, 2}), ', Probability: ', num2str(probabilities(i))]);
end

% Step 4: Encode the data using Huffman encoding
encodedData = huffmanenco(data, huffmanDict); 

% Step 5: Divide the encoded bit-stream into 8-bit blocks and convert to decimal
L = 8 - rem(length(encodedData), 8); 
b1 = [encodedData' zeros(1, L)]; % Add padding zeros if needed
blocks = reshape(b1, 8, [])'; 
decimalValues = bi2de(blocks, 'left-msb'); 

% Write the decimal values to a binary file encode.huf using fwrite
fileID_encoded = fopen('encode.huf', 'w'); 
fwrite(fileID_encoded, decimalValues, 'uint8'); 
fclose(fileID_encoded); % Close the file after writing

% Compare the file sizes of the original and compressed files
originalFileInfo = dir('source.txt'); 
compressedFileInfo = dir('encode.huf'); 
disp(['Original File Size: ', num2str(originalFileInfo.bytes), ' bytes']);
disp(['Compressed File Size: ', num2str(compressedFileInfo.bytes), ' bytes']);

% Step 6: Read data from the compressed file encode.huf
fileID_compressed = fopen('encode.huf', 'r'); 
compressedData = fread(fileID_compressed, '*uint8'); 
fclose(fileID_compressed); 

% Step 7: Convert the data from decimal numbers to binary bit-stream
binaryStream = de2bi(compressedData, 8, 'left-msb'); 
dataBitStream = reshape(binaryStream', 1, []); 

% Recover the original symbols from the binary bit-stream
dataBitStreamDouble = double(dataBitStream); 
decodedData = huffmandeco(dataBitStreamDouble', huffmanDict); 

% Write the decoded symbols into a new text file decode.txt using fprintf
fileID_decoded = fopen('decode.txt', 'w'); 
fprintf(fileID_decoded, '%c', decodedData); 
fclose(fileID_decoded); 

% Compare the original file and the decoded file
originalData = fileread('source.txt'); % Read the original file
decodedDataText = fileread('decode.txt'); % Read the decoded file
if strcmp(originalData, decodedDataText)
    disp('The original file and the decoded file are identical.');
else
    disp('The original file and the decoded file are different.');
end



