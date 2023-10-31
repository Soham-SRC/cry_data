% Specify the folder containing the audio files
inputFolder = '/data_copy/data_44khz';

% Specify the target sample rate (16 kHz)
targetSampleRate = 16000;

% Create an output folder to store downsampled files
outputFolder = '../data_16khz';
if ~exist(outputFolder, 'dir')
    mkdir(outputFolder);
    %% 
end

% Get a list of all audio files in the input folder
fileList = dir(fullfile(inputFolder, '*.wav')); % Change the file extension if your files are in a different format

% Loop through each audio file and downsample it
for i = 1:length(fileList)
    % Load the audio file
    filePath = fullfile(inputFolder, fileList(i).name);
    [audio, originalSampleRate] = audioread(filePath);

    % Downsample the audio to the target sample rate
    audioDownsampled = resample(audio, targetSampleRate, originalSampleRate);

    % Construct the output file path
    [~, fileName, fileExt] = fileparts(fileList(i).name);
    outputFile = fullfile(outputFolder, [fileName '_downsampled.wav']); % Change the file extension if your files are in a different format

    % Write the downsampled audio to the output file
    audiowrite(outputFile, audioDownsampled, targetSampleRate);

    fprintf('Downsampled %s to %d Hz\n', fileList(i).name, targetSampleRate);
end
