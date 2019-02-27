%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SCRIPT
%    hw1
% 
% This script runs questions 2 through 4 of the HW1 from ECE313:Music and
% Engineering.
%
% This script was adapted from hw1 recevied in 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Setup
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all
clear functions
clear variables
dbstop if error


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
constants.fs=44100;                 % Sampling rate in samples per second
constants.durationScale=0.5;        % Duration of notes in a scale
constants.durationChord=3;          % Duration of chords



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 2 - scales
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[soundMajorScaleJust]=create_scale('Major','Just','A',constants);
[soundMajorScaleEqual]=create_scale('Major','Equal','A',constants);
[soundMinorScaleJust]=create_scale('Minor','Just','A',constants);
[soundMinorScaleEqual]=create_scale('Minor','Equal','A',constants);

disp('Playing the Just Tempered Major Scale');
soundsc(soundMajorScaleJust,constants.fs);
pause(5)
disp('Playing the Equal Tempered Major Scale');
soundsc(soundMajorScaleEqual,constants.fs);
pause(5)
disp('Playing the Just Tempered Minor Scale');
soundsc(soundMinorScaleJust,constants.fs);
pause(5)
disp('Playing the Equal Tempered Minor Scale');
soundsc(soundMinorScaleEqual,constants.fs);
fprintf('\n');

% EXTRA CREDIT - Melodic and Harmonic scales
[soundHarmScaleJust]=create_scale('Harmonic','Just','A',constants);
[soundHarmScaleEqual]=create_scale('Harmonic','Equal','A',constants);
[soundMelScaleJust]=create_scale('Melodic','Just','A',constants);
[soundMelScaleEqual]=create_scale('Melodic','Equal','A',constants);

pause(5)
disp('Playing the Just Tempered Harmonic Scale');
soundsc(soundHarmScaleJust,constants.fs);
pause(5)
disp('Playing the Equal Tempered Harmonic Scale');
soundsc(soundHarmScaleEqual,constants.fs);
pause(5)
disp('Playing the Just Tempered Melodic Scale');
soundsc(soundMelScaleJust,constants.fs);
pause(5)
disp('Playing the Equal Tempered Melodic Scale');
soundsc(soundMelScaleEqual,constants.fs);
fprintf('\n');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 3 - chords
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fund = 'A'; % need this to determine wavelength for plots

% major and minor chords
[soundMajorChordJust]=create_chord('Major','Just',fund,constants);
[soundMajorChordEqual]=create_chord('Major','Equal',fund,constants);
[soundMinorChordJust]=create_chord('Minor','Just',fund,constants);
[soundMinorChordEqual]=create_chord('Minor','Equal',fund,constants);

pause(4)
disp('Playing the Just Tempered Major Chord');
soundsc(soundMajorChordJust,constants.fs);
pause(4)
disp('Playing the Equal Tempered Major Chord');
soundsc(soundMajorChordEqual,constants.fs);
pause(4)
disp('Playing the Just Tempered Minor Chord');
soundsc(soundMinorChordJust,constants.fs);
pause(4)
disp('Playing the Equal Tempered Minor Chord');
soundsc(soundMinorChordEqual,constants.fs);
fprintf('\n');

% assorted other chords
[soundPowerChordJust]=create_chord('Power','Just',fund,constants);
[soundPowerChordEqual]=create_chord('Power','Equal',fund,constants);
[soundSus2ChordJust]=create_chord('Sus2','Just',fund,constants);
[soundSus2ChordEqual]=create_chord('Sus2','Equal',fund,constants);
[soundSus4ChordJust]=create_chord('Sus4','Just',fund,constants);
[soundSus4ChordEqual]=create_chord('Sus4','Equal',fund,constants);
[soundDom7ChordJust]=create_chord('Dom7','Just',fund,constants);
[soundDom7ChordEqual]=create_chord('Dom7','Equal',fund,constants);
[soundMin7ChordJust]=create_chord('Min7','Just',fund,constants);
[soundMin7ChordEqual]=create_chord('Min7','Equal',fund,constants);

pause(4)
disp('Playing the Just Tempered Power Chord');
soundsc(soundPowerChordJust,constants.fs);
pause(4)
disp('Playing the Equal Tempered Power Chord');
soundsc(soundPowerChordEqual,constants.fs);
pause(4)
disp('Playing the Just Tempered Sus2 Chord');
soundsc(soundSus2ChordJust,constants.fs);
pause(4)
disp('Playing the Equal Tempered Sus2 Chord');
soundsc(soundSus2ChordEqual,constants.fs);
pause(4)
disp('Playing the Just Tempered Sus4 Chord');
soundsc(soundSus2ChordJust,constants.fs);
pause(4)
disp('Playing the Equal Tempered Sus4 Chord');
soundsc(soundSus2ChordEqual,constants.fs);
pause(4)
disp('Playing the Just Tempered Dom7 Chord');
soundsc(soundDom7ChordJust,constants.fs);
pause(4)
disp('Playing the Equal Tempered Dom7 Chord');
soundsc(soundDom7ChordEqual,constants.fs);
pause(4)
disp('Playing the Just Tempered Min7 Chord');
soundsc(soundMin7ChordJust,constants.fs);
pause(4)
disp('Playing the Equal Tempered Min7 Chord');
soundsc(soundMin7ChordEqual,constants.fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 4 - plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% determine fundamental frequency
fs = constants.fs;
durationChord = constants.durationChord;

if length(fund) == 1
    n_keys = 48 + fund - 'A';
elseif length(root) == 2
    oct = str2num(fund(2));
    n_keys = 12*oct + (fund(1) - 'A') + 1;
end

root_freq = 2^((n_keys - 49)/12) * 440;
wavelength = 1/root_freq;

t1 = 0:1/fs:wavelength;
t10 = 0:1/fs:20*wavelength;

[soundMajorChordJust]=create_chord('Major','Just',fund,constants);
[soundMajorChordEqual]=create_chord('Major','Equal',fund,constants);
[soundMinorChordJust]=create_chord('Minor','Just',fund,constants);
[soundMinorChordEqual]=create_chord('Minor','Equal',fund,constants);

% Major chords
%   Single Wavelength
figure;
%     just tempered
plot(t1,soundMajorChordJust(1:length(t1)))
hold on;
%     equal tempered
plot(t1,soundMajorChordEqual(1:length(t1)))
title('Major Chords: Single Wavelength')
xlabel('t','interpreter','latex')
ylabel('Amplitude','interpreter','latex')
legend('Just-Tempered','Equal-Tempered')
%   Tens of Wavelengths
figure;
%     just tempered
plot(t10,soundMajorChordJust(1:length(t10)))
hold on;
%     equal tempered
plot(t10,soundMajorChordEqual(1:length(t10)))
title('Major Chords: 20 Wavelengths')
xlabel('t','interpreter','latex')
ylabel('Amplitude','interpreter','latex')
legend('Just-Tempered','Equal-Tempered')

% Minor chords
%   Single Wavelength
figure;
%     just tempered
plot(t1,soundMinorChordJust(1:length(t1)))
hold on;
%     equal tempered
plot(t1,soundMinorChordEqual(1:length(t1)))
title('Minor Chords: Single Wavelength')
xlabel('t','interpreter','latex')
ylabel('Amplitude','interpreter','latex')
legend('Just-Tempered','Equal-Tempered')
%   Tens of Wavelengths
figure;
%     just tempered
plot(t10,soundMinorChordJust(1:length(t10)))
hold on;
%     equal tempered
plot(t10,soundMinorChordEqual(1:length(t10)))
title('Minor Chords: 20 Wavelengths')
xlabel('t','interpreter','latex')
ylabel('Amplitude','interpreter','latex')
legend('Just-Tempered','Equal-Tempered')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Question 5 - discussion
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I was able to hear that for the just-tempered major scale, the notes did
% not seem to be at an equal distance apart in pitch. This was more clearly
% evident near the end of the scale. The equal-tempered major scale did
% appear to have equal jumps in pitch. Therefore, the equal-tempered major
% scale sounded better. The same idea applied to the minor scales.
% Similarly, the equal-tempered minor scale sounnded better.

% Listening to the just-tempered major chord, there seemed to be some noise
% additional to the beat frequency. This is because the 