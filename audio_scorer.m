% EE 376 Outreach Project
% Winter 2019

clc; clear; close all;

recObj = audiorecorder;

disp('Start speaking');
recordblocking(recObj, 3);
disp('Done recording');


% Playback the recording
% play(recObj);

% Andre is a dingus +1

% Get the audio data
y1 = getaudiodata(recObj);



%% Plot the spectrogram using the function, also get the spectrogram values before they are changed to powers
[spec, Smin, Smax, T, F, s_abs] = myspectrogram_test(y1);
colorbar();
colormap('parula');
s = s_abs;
%% Exploring appropriate threshold percentile

% Try to find a natural threshold for the magnitude of the
% coefficients
% close all;
% figure()
% hold on
% histogram(s(:))
% % add vertical lines corresponding to percentiles
% perct_vals = prctile(s(:), [50, 75, 80, 90]);
% ylimits = ylim;
% for i=1:length(perct_vals)
%     line([perct_vals(i) perct_vals(i)], [0, ylimits(2)], 'color', 'red')
% end

% Try looking at the spectrogram with the things below a certain
% threshold zeroed out
figure()
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
subplot(2,1,1)
imagesc(s)
axis('xy')
colorbar()
colormap('parula')
title('Original');

perctile_thresh = 99;
thresh_val = prctile(s(:), perctile_thresh);

s_thresh = s;
s_thresh(s_thresh <= thresh_val) = 0;
% figure()
subplot(2,1,2)
imagesc(s_thresh)
axis('xy')
colorbar()
colormap('parula')
title('Thresholded');

%%

% Same code as above, but written to overwrite the second subplot
% so I can dynamically change the threshold and see the effect.
perctile_thresh = 99;
thresh_val = prctile(s(:), perctile_thresh);

s_thresh = s;
s_thresh(s_thresh <= thresh_val) = 0;
% figure()
subplot(2,1,2)
imagesc(s_thresh)
axis('xy')
colorbar()
colormap('parula')
title('Thresholded');

% Through experimentation, it seems that the 99th percentile
% threshold is probably the best bet for picking ones they
% actually hit.


%% Threshold the data for computing scores

perctile_thresh = 99;
thresh_val = prctile(s(:), perctile_thresh);

s_thresh = s;
s_thresh(s_thresh <= thresh_val) = 0;


%% Finding max and min freq hit after thresholding

% Get the max freq with any magnitude left
[max_vals, inds] = max(s_thresh);
max_ind = max(inds);
max_freq = F(max_ind)

% Get the minimum frequency with any magnitude left
min_val = min(s_thresh(s_thresh>0));
[row, col] = find(s_thresh == min_val);
min_freq = F(row)

%% Tracking the row index of the max value in each column
% Then, compute statistics about it, such as its standard dev

[vals, row_inds] = max(s);
% figure()
% plot(row_inds)

max_ind_std = std(row_inds)
=======
%% Spectrogram plotter
                              %speech,   fs,      T,        w, nfft,     Slim, alpha, cmap, cbar, type)
[spec, plot_handle] = myspectrogram(y, 8000, [18 1], @hamming, 2048, [-45 -2], false, 'jet', true, 'lp');

% Compute the std in terms of freq
max_freq_vec = F(row_inds);
max_freq_std = std(max_freq_vec)

% Do the same calculations, but ignoring entries with no sound
row_inds_filt = row_inds(row_inds>1);
max_ind_filt_std = std(row_inds_filt)

max_freq_filt_vec = F(row_inds_filt);
max_freq_filt_std = std(max_freq_filt_vec)

%% Count the number of periods of silence




