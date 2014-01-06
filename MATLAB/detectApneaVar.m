% This function detects sleep apnea from an audio signal Y using the
% variance method.
% This is done by calculating the variance of a small section of the
% function and checking if it is above a threshold value (determined by sensitivity)
% which can be changed according to precision/speed requirements.

function apnea = detectApneaVar (Y , TMAX , sensitivity)

n = length (Y);
apnea = zeros (1 , n);

% Calculate variance of whole signal (as a yardstick)

mean  = sum(Y) / n ;
variance = sum((Y - mean).^2) / (n - 1) ;

maxVariance = variance / sensitivity;

% Calculate the variance through a moving window of size 10

twindow = [1:10 ; Y( 1:10 )];
    
% This vector contains the locations of the moving window

for i = 1:n-10

    mu = sum( twindow(2,:) ) / 10;
    sigma2 = sum( (twindow(2,:) - mu).^2 ) / 9 ;
    
    if sigma2 > maxVariance 
        apnea(1 , twindow(2,:)) = 1;
    end
    
    twindow(1,:) = twindow(1,:) + 1; % Update the window for the next round of variance calculations
    twindow(2,:) = Y ( twindow(1,:) )

end