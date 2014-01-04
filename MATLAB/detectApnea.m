function apnea = detectApnea(Y, TMAX, threshold, interval)
% Detects periods when the signal Y is below THRESHOLD for a time at least
% INTERVAL. THRESHOLD is the percentage of the maximum signal [0, 1].
    
    YMax = max(Y);
    n = length(Y);
    sampleInterval = round(n / TMAX * interval)
    apnea = zeros(1, n);
    
    i = 1;
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