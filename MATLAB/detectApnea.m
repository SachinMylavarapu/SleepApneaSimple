function apnea = detectApnea(Y, TMAX, threshold, interval)
% Detects periods when the signal Y is below THRESHOLD for a time at least
% INTERVAL. THRESHOLD is the percentage of the maximum signal [0, 1].
    
    YMax = max(Y); % Upper limit of sleep data
    n = length(Y); % No. of samples
    sampleInterval = round(n / TMAX * interval); % Minimum no. of consecutive samples that should be below threshold for apnea
    apnea = zeros(1, n); % Generate a vector that will contain either zeros or ones to show where apnea is 
    
    i = 1; % initial value
    while i <= (n - sampleInterval + 1)
        newI = i + sampleInterval;
        allBelow = true;
        for j = i:(i + sampleInterval - 1)
            if Y(j) > threshold * YMax
                allBelow = false;
                newI = j + 1;
                break;
            end
        end
        if allBelow == true
            for j = i:(i + sampleInterval - 1)
                apnea(j) = 1;
            end
        end
        i = newI;
    end
end