% Classification using perceptron

% Reading apple images
A1=imread('apple_04.jpg');
A2=imread('apple_05.jpg');
A3=imread('apple_06.jpg');
A4=imread('apple_07.jpg');
A5=imread('apple_11.jpg');
A6=imread('apple_12.jpg');
A7=imread('apple_13.jpg');
A8=imread('apple_17.jpg');
A9=imread('apple_19.jpg');

% Reading pears images
P1=imread('pear_01.jpg');
P2=imread('pear_02.jpg');
P3=imread('pear_03.jpg');
P4=imread('pear_09.jpg');

% Calculate for each image, colour and roundness
% For Apples
% 1st apple image(A1)
hsv_value_A1=spalva_color(A1); %color
metric_A1=apvalumas_roundness(A1); %roundness
% 2nd apple image(A2)
hsv_value_A2=spalva_color(A2); %color
metric_A2=apvalumas_roundness(A2); %roundness
% 3rd apple image(A3)
hsv_value_A3=spalva_color(A3); %color
metric_A3=apvalumas_roundness(A3); %roundness
% 4th apple image(A4)
hsv_value_A4=spalva_color(A4); %color
metric_A4=apvalumas_roundness(A4); %roundness
% 5th apple image(A5)hsv_value_A5=spalva_color(A5); 
hsv_value_A5=spalva_color(A5);%color
metric_A5=apvalumas_roundness(A5); %roundness
% 6th apple image(A6)
hsv_value_A6=spalva_color(A6); %color
metric_A6=apvalumas_roundness(A6); %roundness
% 7th apple image(A7)
hsv_value_A7=spalva_color(A7); %color
metric_A7=apvalumas_roundness(A7); %roundness
% 8th apple image(A8)
hsv_value_A8=spalva_color(A8); %color
metric_A8=apvalumas_roundness(A8); %roundness
% 9th apple image(A9)
hsv_value_A9=spalva_color(A9); %color
metric_A9=apvalumas_roundness(A9); %roundness

%For Pears
%1st pear image(P1)
hsv_value_P1=spalva_color(P1); %color
metric_P1=apvalumas_roundness(P1); %roundness
%2nd pear image(P2)
hsv_value_P2=spalva_color(P2); %color
metric_P2=apvalumas_roundness(P2); %roundness
%3rd pear image(P3)
hsv_value_P3=spalva_color(P3); %color
metric_P3=apvalumas_roundness(P3); %roundness
%2nd pear image(P4)
hsv_value_P4=spalva_color(P4); %color
metric_P4=apvalumas_roundness(P4); %roundness

%selecting features(color, roundness, 3 apples and 2 pears)
%A1,A2,A3,P1,P2
%building matrix 2x5
x1Apm=[hsv_value_A1 hsv_value_A2 hsv_value_A3 hsv_value_P1 hsv_value_P2];
x2Apm=[metric_A1 metric_A2 metric_A3 metric_P1 metric_P2];

x1Bay=[hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_P3 hsv_value_P4];
x2Bay=[metric_A4 metric_A5 metric_A6 metric_P3 metric_P4];

x1Ats=[hsv_value_A4 hsv_value_A5 hsv_value_A6 hsv_value_A7 hsv_value_A8 hsv_value_A9 hsv_value_P3 hsv_value_P4];
x2Ats=[metric_A4 metric_A5 metric_A6 metric_A7 metric_A8 metric_A9 metric_P3 metric_P4];
% estimated features are stored in matrix P:
%P=[x1Atm;x2Atm;x1Ats;x2Ats];
%Desired output vector
T=[1;1;1;-1;-1]; % <- ČIA ANKSČIAU BUVO KLAIDA!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

TAts=[1 1 1 1 1 1 -1 -1];

%% train single perceptron with two inputs and one output

% generate random initial values of w1, w2 and b
w1 = randn(1);
w2 = randn(1);
b = randn(1);

%koeficientai
y=0;
c=0;
k=0;
aApm=5;
aAts=8;
sign1='';
sign2='';

%kintamieji
vApm=zeros(1,aApm);
vAts=zeros(1,aAts);
ekApm=zeros(1,aApm);
ekAts=zeros(1,aAts);
Ats=zeros(1,aAts);
eta=0.1;
eApm=1;
eAts=0;



% write training algorithm
while eApm ~= 0 % executes while the total error is not 0

for k=1:1:aApm
    vApm(k)=w1*x1Apm(k)+w2*x2Apm(k)+b;
    if vApm(k) > 0
        y = 1;
    else
        y = -1;
    end
    ekApm(k) = T(k) - y;
    %fprintf('ek%d = %f\n', k, ek(k));
end

for k=1:1:aApm
    w1=w1+eta*ekApm(k)*x1Apm(k);
    w2=w2+eta*ekApm(k)*x2Apm(k);
    b=b+eta*ekApm(k);
end

% calculate the total error for these 5 inputs 
eApm = 0;
for k=1:1:aApm
    eApm=eApm+abs(ekApm(k));
end

c=c+1;

fprintf ('e(%d) = %f \n\n',c, eApm);

end

if w2 > 0
    sign1='+';
end

if b > 0
    sign2='+';
end

fprintf ('lygtis:\n%f*x1%c%f*x2%c%f\n', w1, sign1, w2, sign2, b);
fprintf('apmokymas vyko %d ciklų\n\n', c);

for k=1:1:aAts
    vAts(k)=w1*x1Ats(k)+w2*x2Ats(k)+b;

    if vAts(k)>0
        y=1;
    else
        y=-1;
    end
    
    ekAts(k)=TAts(k)-y;
    Ats(k)=y;
end

for k=1:1:aAts
    eAts=eAts+abs(ekAts(k));
end

fprintf('Testavimo rezultatai:\n');
fprintf('Turi būti: ');
fprintf('%d ',TAts);
fprintf('\n');
fprintf('    Gavau: ');
fprintf('%d ',Ats);
fprintf('\n');
fprintf('testavimo paklaida: %f\n', eAts);

%Bayes

PBay=[x1Apm;x2Apm]';
Bayes=fitcnb(PBay,T);

PBayAts=[x1Bay;x2Bay]';

BayesAts=predict(Bayes,PBayAts);
fprintf('\n\nBayes rezultatai:\n');
fprintf('Turi būti: ');
fprintf('%d ',T);
fprintf('\n');
fprintf('    Gavau: ');
fprintf('%d ', BayesAts);
fprintf('\n')
