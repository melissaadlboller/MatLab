% Frequency Modulation (FM)
fs = 500e3; % sample rate to 100kHz
Ts = 1/fs;  % time stop
t = 0:Ts:10-Ts; % time vector start / step / end

% generate waves
% wave 1 -> carrier / Träger
fc = 10e3; % Hz
uc = cos(2 * pi * fc * t);

% wave 2 -> baseband / Audiosignal
fb = 1e3; % Hz
ub = cos(2 * pi * fb * t);

% Modulution
%delta_f = 4800;  %Frequenzhub
eta = 2.4;    %Modulationsindex: eta < 1 -> Schmalband-FM (NBFM)
delta_f = eta * fb;
int_ub = 1/fs * cumsum(ub);
ufm = cos(2 * pi * fc * t + 2 * pi * delta_f * int_ub);

% Plot Time Domain (Zeitbereichdarstellung)
figure(1);
subplot(2, 1, 1); % 2 rows, 1 column, 1st row
plot(t, ub, t, ufm), grid on; % ub(t)
title ('time domain');
axis([0.0 0.001 -2.2 2.2]);
xlabel('time');
ylabel('voltage');
legend('FM signal', 'baseband');

% Calculate Frequency Spectrum
% with Fast Fourier Transformation (FFT)
F = fft(ufm); % fourier coefficient (=amplitude) at each frequency
n = length(ufm); %number of samples
f = (0 : n-1)*(fs/n); % vector of frequencies
volt = 2/n * abs(F); % absolut 

%Plot Frequency Domain (Frequenzbereichdarstellung)
subplot(2, 1, 2) %2nd row
plot(f, volt); % volt(f)
grid on;
axis([0 100e3 0 1.2])
title('frequency doamin')
xlabel('frequency');
ylabel('voltage');
