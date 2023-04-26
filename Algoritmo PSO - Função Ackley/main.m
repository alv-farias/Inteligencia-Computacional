% Par�metros do PSO
num_particles = 300; %n�mero de particulas
max_iter = 100;% quantidade m�xima de itera��o do algoritmo
c1 = 1.5;%par�metro de acelera��o da part�cula
c2 = 1.5;%par�metro de acelera��o da part�cula
w = 0.7;%peso de inercia da particula, controla a influencia da velocidade anterior
vmax = 0.1;%velocidade m�xima permitida

% Inicializa��o das part�culas

%Gera a posi��o inicial das particulas em um espa�o bidimensional em um
%intervalo de -5 a 5
x = rand(num_particles,2) * 10 - 5;

%Gera valores de velocidade inicial entre -1 e 1
v = rand(num_particles,2) * 2 - 1;

%pbest � a melhor posi��o da particula at� o momento
%inicialmete a mesma come�a com os valores iniciais das particulas
pbest = x;

%criar um vetor coluna de tamanho "num_particles" com todos os seus
%elementos iguais a zero. A vari�vel "pbest_fitness" � utilizada para
%armazenar o valor de aptid�o do melhor ponto pessoal de cada part�cula da popula��o
pbest_fitness = zeros(num_particles,1);%inicialmete � zerada

%avaliar a aptid�o de todas as part�culas de acordo com suas posi��es
%atuais, por isso se passar os param�tros pbest(i,1) e pbest(i,2) para a
%fun��o ackley que no caso s�o os valores de x e y das part�culas e com
%isso as aptid�es s�o armazenadas em pbest_fitness
for i=1:num_particles
    pbest_fitness(i) = ackley(pbest(i,1),pbest(i,2));
end

%gbest_fitness � iniciado como infinito para garantir que na primeieria
%compara��o qualquer valor de pbest_fitness ser� menor garantindo que o
%valor seja atualizado
%gbest_fitness guarda o melhor valor at� o momento
gbest_fitness = inf;
%gbest guarda o valor da posi��o da melhor part�cula at� o momento e inicia
%com os valores de x e y zerados
gbest = [0,0];

%esse for percorre todas as particulas e verifica que se o valor atual do
%fitness da particula � menor que o melhor valor at� o momento e se isso
%for verdade o valor de gbest_fitness � atualizado para o valor da melhor
%particula atualmente e em seguida atualizamos o valor da posi��o da melhor
%particula em gbest.
%Essa primeira verifica��o � feita no primeiro instante das part�culas, ou
%seja, ap�s elas serem inicializadas e se ter um valor de referencia dos
%parametros de pbest_fitness, gbest_fitness e gbest. No la�o principal �
%feita essa verifica��o e atualiza��es dos valores a cada itera��o sempre
%que for necess�rio.
for i=1:num_particles
    if pbest_fitness(i) < gbest_fitness
        gbest_fitness = pbest_fitness(i);
        gbest = pbest(i,:);
    end
end

%Mostrando as posi��es iniciais das particulas
figure;
scatter(x(:,1),x(:,2),30,'k', 'filled'); %utilizei a cor preta para ficar mais f�cil de diferenciar das itera��es
hold on;
[X,Y] = meshgrid(linspace(-5,5));
Z = ackley(X,Y);
contour(X,Y,Z,20);
title('Posi��o inicial das part�culas');

% PSO
%inicia um vetor para armazenar o fitness que ser� utilizado de forma geral
%nas itera��es do algoritmo. Nesse trecho a cada itera��o atualiza-se os
%valores de posi��o das particulas e refazemos tamb�m a compara��o para os
%valores de gbest_fitness e gbest. Nesse caso, � o algoritmo PSO sendo
%executado de forma "global"
fitness = zeros(num_particles,1);
for iter=1:max_iter
    for i=1:num_particles
        %Atualiza��o da posi��o da part�cula somando o valor da velocidade
        %atual da particula e o valor de posi��o atual da particula
        x(i,:) = x(i,:) + v(i,:);
        
        %Ap�s atualizar a posi��o da particula, aplica-se a equa��o do PSO
        %para atualizar o valor da velocidade com base na velocidade atual,
        %o vetor que aponta para a melhor posi��o da particula, o vetor que 
        %aponta para melhor posi��o encontrada por todas as particulas e
        %levando em considera��o os valores definidos de w, c1 e c2
        v(i,:) = w*v(i,:) + c1*rand(1,2).*(pbest(i,:) - x(i,:)) + c2*rand(1,2).*(gbest - x(i,:));
        
        %delimita��o da velocidade com base nos limites de velocidade
        %m�xima e m�nima, ou seja, se o valor extrapolar os limites o
        %mesmmo acaba sendo assumido com o valor definido para os limites
        %de velocidade
        v(i,:) = min(v(i,:),vmax);
        v(i,:) = max(v(i,:),-vmax);
        
        %Agora calcula-se a aptid�o da part�cula com base na aplica��o da
        %fun��o ackley e executamos o mesmo processo executado antes da
        %itera��o geral do algoritmo onde se o valor de aptid�o atual da particula for
        %menor que o seu melhor valor de aptid�o pessoal geral, atualiza-se
        %o valor de pbest_fitness e a posi��o pbest
        fitness(i) = ackley(x(i,1),x(i,2));
        if fitness(i) < pbest_fitness(i)
            pbest_fitness(i) = fitness(i);
            pbest(i,:) = x(i,:);
            %ap�s verificar a aptid�o pessoal da particula, verifica-se se
            %o valor da sua aptid�o pessoal � menor do que o valor de
            %aptid�o de todas as particulas. Se for, atualiza-se o valor de
            %gbest_fitness e o valor de posi��o gbest
            if pbest_fitness(i) < gbest_fitness
                gbest_fitness = pbest_fitness(i);
                gbest = pbest(i,:);
            end
        end
    end
    
    % Armazenar os valores das aptid�es para plotar os gr�ficos
    aptidao_media(iter) = mean(fitness);
    aptidao_minima(iter) = min(fitness);
    aptidao_maxima(iter) = max(fitness);
    aptidao_mediana(iter) = median(fitness);
    
    % Plotar a posi��o das part�culas a cada 10 itera��es
    %Utilizando o comando ezcontour o gr�fico referente a fun��o de ackley
    %n�o apresenta tantas curvas e sem levar em conta que o mesmo tem uma
    %maior demora para se executado
    
%     if mod(iter,10) == 0
%         figure;
%         plot(x(:,1),x(:,2),'ro', 'MarkerFaceColor', 'blue');
%         hold on;
%         ezcontour(@(x,y)ackley(x,y),[-5,5]);
%         xlabel('x');
%         ylabel('y');
%         title(['Itera��o ',num2str(iter)]);
%     end

    if mod(iter,10) == 0
        figure;
        scatter(x(:,1),x(:,2),30,'r','filled');
        hold on;
        [X,Y] = meshgrid(linspace(-5,5));
        Z = ackley(X,Y);
        contour(X,Y,Z,20);
        xlabel('x');
        ylabel('y');
        title(['Itera��o ',num2str(iter)]);
    end
end

% Plotar os gr�ficos dos valores m�dio, m�nimo, m�ximo e mediana da aptid�o ao longo das v�rias gera��es
figure;
plot(aptidao_media,'b');
hold on;
plot(aptidao_minima,'r');
plot(aptidao_maxima,'g');
plot(aptidao_mediana,'m');
legend('M�dia','M�nima','M�xima','Mediana');
xlabel('Itera��o');
ylabel('Aptid�o');

% Encontrar e imprimir o ponto de m�nimo global
[valor_minimo, indice_minimo] = min(fitness);
melhor_particula = x(indice_minimo,:);
fprintf('O ponto de m�nimo global � (%f,%f) com valor de aptid�o %f\n',melhor_particula(1),melhor_particula(2),valor_minimo);