%Assignment 2: Sound denoising 
clc;
close all;
clear ;

% a)Read the noisy signal x  from the file “noisy.wav” 
[ymain,Fs_main]=audioread('noisy.wav');     % ymain is a variable containing the amplitude of the samples 
                                            % & fs is the sampling frequency

 % b)Find and display the sampling frequency                                           
 dim = [.3 .2 .1 .1];                                           
 annotation('textbox',dim,'String',"Sampling Frequency = 8000 samples",'FitBoxToText','on');
                                            

% e) I. Find and remove the sinusoidal noise.

%calculate sample count
ymain_SampleCount = size(ymain);
ymain_SampleCount = ymain_SampleCount(1);

frame_Length = 8000;    % file is divided into frames each of length (8000 samples)
yNew_singal = [];       % create an empty vector for the new signal without noise

for i = 1: frame_Length : ymain_SampleCount(1) 
    
    %computes the discrete Fourier transform (DFT) of ymain  using a fast Fourier transform (FFT) 
    y_1(i:i+frame_Length-1) = fft(ymain(i:i+frame_Length-1));
    %Save a copy of y_1 in the variable temp_y_1
    temp_y_1 = y_1(i:i+frame_Length-1);
    %Get the magnitude of y_1
    mag_y = abs(temp_y_1);
    %Removing NOISE is done by deleting frequency components with amplitude higher than 25
    %Note: The amplitudes of most noise frequencies have a value higher than 25
    %Note: The amplitudes of most normal frequencies have a value less than 25
    yNew_singal_fsc = temp_y_1(mag_y<25);
    %Adding this frame to the new signal after removing the noise
    % e) II. Find the clean speech signal.
    yNew_singal = [yNew_singal, ifft(yNew_singal_fsc)];
    % Repeat the previous commands for the next frame  
end    

% c) Sketch the signal x

%plot the main signal 
subplot(2,2,1);
plot(ymain);                                             
title('main Audio noisy.wav Signal');

%ploting the new signal 
subplot(2,2,2);
plot(yNew_singal);                                   
title('main Audio noisy.wav Signal after removing the noise'); 

% Playing the .Wav to hear it

% d) Play as an audio signal. You will listen to a noisy sound
sound(ymain, Fs_main);                              %Play the main audio file
                                                    % Sound is used to send audio signal y to the speaker at sample rate Fs
pause(10)                                           % 10 seconds pause


yNew_singal = yNew_singal *10;                      % To hear it better, you can amplifie it to increase the amplitude (raise the voice )


%f) Play the audio signal after removing noise frequency components for all frames.
sound(yNew_singal)                                  %play the new audio signal after removing the noise  
                                                    %Sound is used to send audio signal y to the speaker at the default sample rate of 8192 hertz.                
                                               
                                                    
                                                    
                                                    