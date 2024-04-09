% using ramp data to characterize 4 bit ADC 

clear;
% data points 
y = [85 101 122 170 75 146 125 60 95 95 115 40 120];
avg = sum(y)/length(y);
dnl = y/avg-1; % compute local differential non linearity 
inl = cumsum(dnl); % compute global integral non linearity 


disp("DNL is: ");
disp(dnl);
disp('INL is: ');
disp(inl);


% computation of INL with error and plot transfer characteristics of ADC 

% Given DNL values (in LSB)
DNL = [0 -0.5 0 0.5 -1 0.5 0.5 0];


offset_error = 0.5;
full_scale_error = 0.5;


N = 3;

% Calculate INL
INL = zeros(1, 2^N);  
for i = 1:2^N
    INL(i) = sum(DNL(1:i));  
end


INL_adjusted = INL + offset_error;
INL_adjusted(end) = INL_adjusted(end) + full_scale_error;  % Adjust last point

input_codes = 0:2^N-1;

% com[ute analog 
V_out = (input_codes / (2^N - 1)) + INL_adjusted / (2^N - 1);

% Plot the transfer curve (ADC characteristic)
figure;
plot(V_out, input_codes, '-o');
xlabel('Analog voltage');
ylabel('Digital out');
title('Transfer Characteristics 3 bit ADC');
grid on;

% Display INL values
disp('INL Values:');
disp(INL_adjusted);

