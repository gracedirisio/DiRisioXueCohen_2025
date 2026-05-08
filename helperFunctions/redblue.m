function cmap = redblue(m)
%bills colormap
    if nargin < 1
        m = 256;
    end

    %bills color codes
    red_rgb = [198 12 48] / 256;
    white_rgb = [1 1 1];
    blue_rgb = [0 51 141] / 256;

    p = linspace(-1, 1, m); %my limits are -1 and 1 

    cmap = interp1([-1 0 1], [blue_rgb; white_rgb; red_rgb], p, 'linear');
end