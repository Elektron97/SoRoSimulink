%%% Motor Bubbling %%%
function y = motor_babbling(n, gain, distribution_type)
    %% Declare Input
    arguments
        n                   {mustBeInteger}
        gain                {mustBeNumeric}
        distribution_type   {mustBeTextScalar}
    end
    %% Random Output
    switch distribution_type
        case "gaussian"
                y = (1/3)*gain*randn(n, 1);
        case "uniform"
                y = -gain + (2*gain)*rand(n, 1);    % uniform distribution [-gain, gain]
        otherwise
            warning("Unexpected Distribution Type. Null Output Signal");
            y = 0;
    end
end