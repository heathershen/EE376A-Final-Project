% EE 376 Outreach Project
% Winter 2019

clc; clear; close all;

recObj = audiorecorder;

disp('Start speaking');
recordblocking(recObj, 5);
disp('Done recording');

%%
% Playback the recording
play(recObj);

% Get the audio data
y = getaudiodata(recObj);
filenames = ["test.wav", "test.ogg", "test.flac", "test.mp4", "test.m4a"];
for i =1:length(filenames)
    disp(filenames(i))
    audiowrite(char(filenames(i)), y, 44100)
    info = audioinfo(char(filenames(i)))
end
% Plot it raw
plot(y);
title('Unprocessed data');