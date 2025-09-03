%%% Motor Bubbling %%%
function y = chirp(t, n, gain, speed)
    %% Declare Input
    arguments
        t                   {mustBeNonnegative}
        n                   {mustBeInteger}
        gain                {mustBeNumeric}
        speed               {mustBeNumeric}
    end
    %% Compute Signal Law
    phase = 2*pi/n;
    y = zeros(n, 1);

    % for i = 1:n
    %     y(i) = gain*sin((2*pi)*(speed*t)*t + phase*i);
    % end
    y = gain*sin((2*pi)*(speed*t)*t + phase*(1:n)');
end