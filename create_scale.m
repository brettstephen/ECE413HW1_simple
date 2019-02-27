function [soundOut] = create_scale( scaleType,temperament, root, constants )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FUNCTION
%    [ soundOut ] = create_scale( scaleType,temperament, root, constants )
% 
% This function creates the sound output given the desired type of scale
%
% OUTPUTS
%   soundOut = The output sound vector
%
% INPUTS
%   scaleType = Must support 'Major' and 'Minor' at a minimum
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
durationScale = constants.durationScale;

if length(root) == 1
    n_keys = 48 + root - 'A';
elseif length(root) == 2
    oct = str2num(root(2));
    n_keys = 12*oct + (root(1) - 'A') + 1;
else
    error('Inproper root specified');
end

root_freq = 2^((n_keys - 49)/12) * 440;

switch scaleType
    case {'Major','major','M','Maj','maj'}
        interval = [2 2 1 2 2 2 1];
    case {'Minor','minor','m','Min','min'}
        interval = [2 1 2 2 1 2 2];
    case {'Harmonic', 'harmonic', 'Harm', 'harm'}
        interval = [2 1 2 2 1 3 1];
    case {'Melodic', 'melodic', 'Mel', 'mel'}
        interval = [2 1 2 2 2 2 1]; % ascending
    otherwise
        error('Inproper scale specified');
end

switch temperament
    case {'just','Just'}
        ratio_prev_min = cumprod([9/8 16/15 10/9 9/8 16/15 9/8 10/9]);
        switch scaleType
            case {'Major','major','M','Maj','maj'}
                ratio_prev = cumprod([9/8 10/9 16/15 9/8 10/9 9/8 16/15]);
            case {'Minor','minor','m','Min','min'}
                ratio_prev = ratio_prev_min;
            case {'Harmonic', 'harmonic', 'Harm', 'harm'}
                ratio_prev = ratio_prev_min;
                ratio_prev(6) = 15/8;
            case {'Melodic', 'melodic', 'Mel', 'mel'}
               ratio_prev = ratio_prev_min;
               ratio_prev(6) = 15/8; 
               ratio_prev(5) = 5/3; 
        end
        ratios = [1 ratio_prev]; % TODO: Pull the Just tempered ratios based on the pattern from the scales
    case {'equal','Equal'}
        expon = cumsum(interval);
        ratios = [1 ((2*ones(1,7)).^expon).^(1/12)];% TODO: Pull the equal tempered ratios based on the pattern from the scales
    otherwise
        error('Improper temperament specified')
end


% Create the vector based on the notes
t = 0:1/fs:(durationScale-1/fs);
freq_vec = reshape(repmat(root_freq*ratios,length(t),1),1,length(t)*8);
soundOut = sin(2*pi* freq_vec.*repmat(t,1,8));
end
