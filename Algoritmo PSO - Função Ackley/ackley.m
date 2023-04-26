% Função de Ackley bidimensional
function f = ackley(x,y)
a = 20; %controla a altura dos picos 
b = 0.2;%controla a largura dso vales
c = 2*pi;%controla a oscilação da função
f = -a * exp(-b * sqrt(0.5*(x.^2 + y.^2))) - exp(0.5*(cos(c*x) + cos(c*y))) + a + exp(1);
end