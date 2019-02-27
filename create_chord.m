function [soundOut] = create_chord( chordType,temperament, root, constants )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%    [ soundOut ] = create_scale( chordType,temperament, root, constants )
% 
% This function creates the sound output given the desired type of chord
%
% OUTPUTS
%   soundOut = The output sound vector
%
% INPUTS
%   chordType = Must support 'Major' and 'Minor' at a minimum
%   temperament = may be 'just' or 'equal'
%   root = The Base frequeny (expressed as a letter followed by a number
%       where A4 = 440 (the A above middle C)
%       See http://en.wikipedia.org/wiki/Piano_key_frequencies for note
%       numbers and frequencies
%   constants = the constants structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fs = constants.fs;
durationChord = constants.durationChord;

if length(root) == 1
    n_keys = 48 + root - 'A';
elseif length(root) == 2
    oct = str2num(root(2));
    n_keys = 12*oct + (root(1) - 'A') + 1;
else
    error('Inproper root specified');
end

root_freq = 2^((n_keys - 49)/12) * 440;

switch chordType
    case {'Major','major','M','Maj','maj'}
        interval = [4 3];
    case {'Minor','minor','m','Min','min'}
        interval = [3 4];
    case {'Power','power','pow'}
        interval = [7];
    case {'Sus2','sus2','s2','S2'}
        interval = [2 5];
    case {'Sus4','sus4','s4','S4'}
        interval = [5 2];
    case {'Dom7','dom7','Dominant7', '7'}
        interval = [4 3 3];
    case {'Min7','min7','Minor7', 'm7'}
        interval = [3 4 3];
    otherwise
        error('Inproper chord specified');
end

switch temperament
    case {'just','Just'}
        switch chordType
            case {'Major','major','M','Maj','maj'}
                ratio_prev = cumprod([9/8*10/9 16/15*9/8]);
            case {'Minor','minor','m','Min','min'}
                ratio_prev = cumprod([9/8*16/15 10/9*9/8]);
            case {'Power','power','pow'}
                ratio_prev = 9/8*10/9*16/15*9/8;
            case {'Sus2','sus2','s2','S2'}
                ratio_prev = cumprod([9/8 10/9*16/15*9/8]);
            case {'Sus4','sus4','s4','S4'}
                ratio_prev = cumprod([9/8*16/15*10/9 9/8]);
            case {'Dom7','dom7','Dominant7', '7'}
                ratio_prev = cumprod([9/8*10/9 16/15*9/8 10/9*9/8]);
                ratio_prev(end) = 9/5;
            case {'Min7','min7','Minor7', 'm7'}
                ratio_prev = cumprod([9/8*16/15 10/9*9/8 16/15*9/8]);
        end
        ratios = [1 ratio_prev];
    case {'equal','Equal'}
        expon = cumsum(interval);
        ratios = [1 ((2*ones(1,length(expon))).^expon).^(1/12)];
    otherwise
        error('Inproper temperament specified')
end


% Complete with chord vectors
t = 0:1/fs:(durationChord-1/fs);
freq_vec = repmat((root_freq*ratios).',1,length(t));
soundOut = sum(sin(2*pi* freq_vec.*repmat(t,length(ratios),1)));
end
