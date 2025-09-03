%%% Impulse %%%
function y = my_impulse(t, t0, n, gain)
    % Init
    y = zeros(n, 1);
    
    % Fill for t = t0
    if(abs(t - t0) <= 1e-2) 
        y = gain*ones(n, 1);
    end
end