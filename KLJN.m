

% Choosing RUpperAlice = RupperBob =  10 kohm
% Choosing RlowerAlice = RLowerBob = 1 kohm
% These values chosen to simplify code, any abritrary values would work 
% generating thermal noise, ignoring 1/f noise present in resistors
k = 1.38e-23; % boltzman constant 
T = 290; % assuming room temperature operation 
Ru = 10e3; % upper resistors 
Fs = 1e6; % Sample rate, used in t vector and bandwidth
% Vrms^2 = 4kTRf by johnson-nyquist theorem
vU = sqrt(4*k*T*Ru*Fs); % RMS val of 10 kohm resistor noise, 1 MHz bandwidth 
disp("RMS val of noise from 10 kohm resistors:")
disp(vU); % display upper noise generators RMS val
t = (1:1e7)/Fs; % time vector for mean squaring internal signals
thermal_noiseAUpper = vU*randn(1,1e7); % Noise is zero mean, with v RMS val, gen random signal 
figure(1);
plot(t,thermal_noiseAUpper); % plot thermal noise 
grid on;
xlabel('time');
ylabel('Upper resistance thermal noise');

% generate thermal noise of 1 kohm resistors

Rl = 1e3; % lower resistor 
vL = sqrt(4*k*T*Rl*Fs); % 1 MHz bandwidth 
disp("RMS value of noise from smaller resistors: ");
disp(vL);
thermal_noiseALower = vL*randn(1,1e7); % randomize thermal noise signal
figure(2);
plot(t, thermal_noiseALower); % Plot for observation 
grid on;
xlabel('time');
ylabel('Lower resistance thermal noise');

% Connect switches and display RMS val of internal signal
% connecting lower alice to upper bob, and computing RMS vals 
% using circuit analysis and simulations on multisim, I verified that 
% the internal voltage in this transmission is: (RHB*Vla + RLA*Vhb) / (Req) 
% Where Req is the series equivalent resistance between the two sources 
% Simulation is taking forver to run, so I am just taking 1000 samples 
% of the internal voltage
internalV1 = zeros(1000); % vector to hold result, initialized with zeros 
Req = Rl + Ru;
for i = 1:size(internalV1)
    internalV1(i) = (Ru*thermal_noiseALower(i) + Rl*thermal_noiseAUpper(i)) / (Req);  

end % end loop

%for n = 1 : 100  used for observations 

    %disp(internalV1(n))

%end 

% Now get other signal transfer internal voltage vector, upper to lower 
% Once again, simulation took forever with full sized internal voltage
% vector so I am using a 1000 sample vector for internal voltages 
% Formula derived from analysis with bidirectional switch in correct
% position 
internalV2 = zeros(1000); % initialize vector 

for i = 1:size(internalV2)
    internalV2(i) = (Rl*thermal_noiseAUpper(i) + Ru*thermal_noiseALower(i)) / (Req);  

end % end loop

% Note: Internal current can also be computed with formulas but I am not sure if
% thats part of the assignment 

% Compute RMS voltage of each internal voltage data set

% can be found by squaring, averaging, and sqrt(result) but MATLAB provides
% an RMS function that works on vectors 

%RMS1 = rms(internalV1);
%RMS2 = rms(internalV2);
%RMS1/2 are matrices, information is in constant multiplier and first entry
%at col = row = 0, RMSk[0][0]

%disp("Approximate RMS value of internal voltage case 1: lower alice upper bob is: ");
%disp(RMS1); % displays full matrix, see above 
%disp("The RMS value for case 2 is: "); 
%disp(RMS2);

square1 = zeros(size(internalV1));

for i = 1:size(square1)
    square1(i) = internalV1(i) * internalV1(i);

end 

% average data set 

sum = 0.0;

for i = 1:size(square1)
    sum = sum +  square1(i);

end 

averageV1 = sum / 1000;

RMS1 = sqrt(averageV1);
disp(RMS1);
























