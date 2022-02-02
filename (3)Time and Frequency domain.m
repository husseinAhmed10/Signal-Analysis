%Assignment 3: Time and frequency domains
clc;
close all;
clear ;
j = sqrt(-1);           
% LTI system with impulse response h[n]=(alpha ^ n) u[n]
%a) suitable range of n such that the signal x[n] seems to converge to zero value
x = 0 : 40;                         % ranges of  n of X[n] from 0 to 50
%rangeo of ohmega
range_OF_ohmega = -pi:0.01:pi;
%Possible values of alpha = 0.3, 0.6, 0.9, −0.3, −0.6 𝑎𝑛𝑑 − 0.9. 
Array_of_alpha = [0.3 0.6 0.9 -0.3 -0.6 -0.9];      
% symbolic variables for calculations
syms n z U_Z ohmega;

% f) Repeat on alpha = 0.3, 0.6, 0.9, −0.3, −0.6 𝑎𝑛𝑑 − 0.9. 
% To repeat the following commands for every value in the array
for i = 1: length(Array_of_alpha)
    
    % select different alpha in each loop with different impulse response
    alpha = Array_of_alpha (i);
    h = alpha ^ n ;
    
    figure;
    subplot(2,2,1);
    % subs returns h, replacing all occurrences of n with all possible values of x
    h_in_range = subs(h,n,x);       
    % a) Sketch the impulse response h[n] versus n
    stem(x,h_in_range);
    title(['Impulse Response h[n] for \alpha = ' num2str(alpha)]); 
    %set legend , x-axis , y-axis labels for graph
    legend('h[n]');
    xlabel('n');
    ylabel('h[n]');
    
    % Z-transform of unit step
    U_Z = 1/(1-z^-1);

    % Z-transform of h[n]
    H_z = ztrans(h);

    % Note: s[n] = u[n] conv h[n]   *In Time Domain*
    % Note: S[z] = U[z] . H[z]       *In Z Domain*
    % Z transform of step response
    StepRespOf_S = H_z * U_Z;
    % Inverse Z transform of step response in time domain
    step_resp = iztrans(StepRespOf_S);
    
    % subs returning step response by replacing all occurrences of n
    % according to possible values of X and convert it to double precision
    s_in_range = double(subs(step_resp,n,x));
    
    subplot(2,2,2);
      
    % b) Sketch the Step response of the system
    stem(x,s_in_range);
   %  c) settling time value
     Steady_State = s_in_range(end);
    % find n where the step response to reach and stay within a range of 5%  of the final steady state value.
    %st_values is the array that contains all the values that reach & stay
    %within a range of 5%  of the final steady state value
    st_values = find(abs(double((s_in_range)) - Steady_State) <= 0.05*Steady_State, 1);
    % settling_time variable represents settling time
    settling_time = x(st_values);
    %SettlingTime_value is the function value at setting time
    SettlingTime_value = double(abs(s_in_range(st_values)));
    
    
    %if alpha is positive, plot the horizontal steady state positive line 
    %hold to draw a new graph over the previous one
    hold on;
    %plot the horizontal steady state positive line 
    plot(x,Steady_State*0.95*ones(size(x)),'r');
    hold off;
   % end
    
    %if alpha is negative, plot the horizontal steady state negative line 
    if alpha < 0
        %hold to draw a new graph over the previous one
        hold on;
        %plot the horizontal steady state negative line 
        plot(x,Steady_State*1.05*ones(size(x)),'r');
        hold off;
    end
    subplot(2,2,3);
    
    title(['Step response of the system for \alpha = ' num2str(alpha)]); 
    %set legend , x-axis , y-axis labels for graph
    legend('S[n]','Steady state');
    xlabel('n');
    ylabel('S[n]');
    
    
   
    
    % since |alpha| < 1 , the region of convergence (ROC) contains r = 1
    % So fourier transform exists
    % Defining H(e^(j*Ω)) at r = 1
    Transfer_Function = subs(H_z, z, exp(j*ohmega));
    % subs returning Transfer function by replacing all occurrences of ohmega
    % according to possible values in it's range
    Transfer_Function_subs = subs(Transfer_Function,ohmega,range_OF_ohmega);
    % Get magnitude of H(e^(j*Ω))and convert it to double
    Transfer_Function_mag=(double(abs(Transfer_Function_subs)));
    % Get the Maximum value of H(e^(j*Ω)) 
    Max_Value = max(Transfer_Function_mag);
    % Get 3db value = (1/sqrt(2)) * maximum value
    Value_3db = ((1/sqrt(2))*Max_Value);
    % calulating 3dB value
    if alpha > 0
        %find the 3db value if the system is low pass filter
        Three_DB = find(double(Transfer_Function_mag) >= Value_3db, 1);
    else
        %find the 3db value if the system is high pass filter
        Three_DB = find(double(Transfer_Function_mag) <= Value_3db, 1);
    end
    
    %Get Ω|3db 
    Three_DB_ohmega = range_OF_ohmega(Three_DB);
    
    % d) Sketch magnitude of the system transfer function versus ohmega
    plot(range_OF_ohmega, Transfer_Function_mag);
    %hold to plot the graph over the previous one
    hold on;
    %plot the horizontal 3db line
    plot(range_OF_ohmega,Value_3db*ones(size(range_OF_ohmega)),'r');
    hold off;
    title(['Magnitude of the system transfer function for for \alpha = ' num2str(alpha)]); 
    %set legend , x-axis , y-axis labels for graph
    legend('H[Ω]','3dB Horizontal Line');              
    xlabel('Ω');
    ylabel('H[Ω]');
    
    dim = [.6 .2 .1 .1];
    str = {['Steady state : ' num2str(Steady_State)], ['Settling Time n : ' num2str(settling_time)], ['Ω|3db : ' num2str(abs(Three_DB_ohmega))]};
    annotation('textbox',dim,'string',str,'FitBoxToText','on');

    
end



