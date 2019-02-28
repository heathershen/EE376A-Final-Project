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

% Andre is a dingus

% Get the audio data
y = getaudiodata(recObj);

% Plot it raw
plot(y);
title('Unprocessed data');














