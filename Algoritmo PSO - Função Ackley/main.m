% Parâmetros do PSO
num_particles = 300; %número de particulas
max_iter = 100;% quantidade máxima de iteração do algoritmo
c1 = 1.5;%parâmetro de aceleração da partícula
c2 = 1.5;%parâmetro de aceleração da partícula
w = 0.7;%peso de inercia da particula, controla a influencia da velocidade anterior
vmax = 0.1;%velocidade máxima permitida

% Inicialização das partículas

%Gera a posição inicial das particulas em um espaço bidimensional em um
%intervalo de -5 a 5
x = rand(num_particles,2) * 10 - 5;

%Gera valores de velocidade inicial entre -1 e 1
v = rand(num_particles,2) * 2 - 1;

%pbest é a melhor posição da particula até o momento
%inicialmete a mesma começa com os valores iniciais das particulas
pbest = x;

%criar um vetor coluna de tamanho "num_particles" com todos os seus
%elementos iguais a zero. A variável "pbest_fitness" é utilizada para
%armazenar o valor de aptidão do melhor ponto pessoal de cada partícula da população
pbest_fitness = zeros(num_particles,1);%inicialmete é zerada

%avaliar a aptidão de todas as partículas de acordo com suas posições
%atuais, por isso se passar os paramêtros pbest(i,1) e pbest(i,2) para a
%função ackley que no caso são os valores de x e y das partículas e com
%isso as aptidões são armazenadas em pbest_fitness
for i=1:num_particles
    pbest_fitness(i) = ackley(pbest(i,1),pbest(i,2));
end

%gbest_fitness é iniciado como infinito para garantir que na primeieria
%comparação qualquer valor de pbest_fitness será menor garantindo que o
%valor seja atualizado
%gbest_fitness guarda o melhor valor até o momento
gbest_fitness = inf;
%gbest guarda o valor da posição da melhor partícula até o momento e inicia
%com os valores de x e y zerados
gbest = [0,0];

%esse for percorre todas as particulas e verifica que se o valor atual do
%fitness da particula é menor que o melhor valor até o momento e se isso
%for verdade o valor de gbest_fitness é atualizado para o valor da melhor
%particula atualmente e em seguida atualizamos o valor da posição da melhor
%particula em gbest.
%Essa primeira verificação é feita no primeiro instante das partículas, ou
%seja, após elas serem inicializadas e se ter um valor de referencia dos
%parametros de pbest_fitness, gbest_fitness e gbest. No laço principal é
%feita essa verificação e atualizações dos valores a cada iteração sempre
%que for necessário.
for i=1:num_particles
    if pbest_fitness(i) < gbest_fitness
        gbest_fitness = pbest_fitness(i);
        gbest = pbest(i,:);
    end
end

%Mostrando as posições iniciais das particulas
figure;
scatter(x(:,1),x(:,2),30,'k', 'filled'); %utilizei a cor preta para ficar mais fácil de diferenciar das iterações
hold on;
[X,Y] = meshgrid(linspace(-5,5));
Z = ackley(X,Y);
contour(X,Y,Z,20);
title('Posição inicial das partículas');

% PSO
%inicia um vetor para armazenar o fitness que será utilizado de forma geral
%nas iterações do algoritmo. Nesse trecho a cada iteração atualiza-se os
%valores de posição das particulas e refazemos também a comparação para os
%valores de gbest_fitness e gbest. Nesse caso, é o algoritmo PSO sendo
%executado de forma "global"
fitness = zeros(num_particles,1);
for iter=1:max_iter
    for i=1:num_particles
        %Atualização da posição da partícula somando o valor da velocidade
        %atual da particula e o valor de posição atual da particula
        x(i,:) = x(i,:) + v(i,:);
        
        %Após atualizar a posição da particula, aplica-se a equação do PSO
        %para atualizar o valor da velocidade com base na velocidade atual,
        %o vetor que aponta para a melhor posição da particula, o vetor que 
        %aponta para melhor posição encontrada por todas as particulas e
        %levando em consideração os valores definidos de w, c1 e c2
        v(i,:) = w*v(i,:) + c1*rand(1,2).*(pbest(i,:) - x(i,:)) + c2*rand(1,2).*(gbest - x(i,:));
        
        %delimitação da velocidade com base nos limites de velocidade
        %máxima e mínima, ou seja, se o valor extrapolar os limites o
        %mesmmo acaba sendo assumido com o valor definido para os limites
        %de velocidade
        v(i,:) = min(v(i,:),vmax);
        v(i,:) = max(v(i,:),-vmax);
        
        %Agora calcula-se a aptidão da partícula com base na aplicação da
        %função ackley e executamos o mesmo processo executado antes da
        %iteração geral do algoritmo onde se o valor de aptidão atual da particula for
        %menor que o seu melhor valor de aptidão pessoal geral, atualiza-se
        %o valor de pbest_fitness e a posição pbest
        fitness(i) = ackley(x(i,1),x(i,2));
        if fitness(i) < pbest_fitness(i)
            pbest_fitness(i) = fitness(i);
            pbest(i,:) = x(i,:);
            %após verificar a aptidão pessoal da particula, verifica-se se
            %o valor da sua aptidão pessoal é menor do que o valor de
            %aptidão de todas as particulas. Se for, atualiza-se o valor de
            %gbest_fitness e o valor de posição gbest
            if pbest_fitness(i) < gbest_fitness
                gbest_fitness = pbest_fitness(i);
                gbest = pbest(i,:);
            end
        end
    end
    
    % Armazenar os valores das aptidões para plotar os gráficos
    aptidao_media(iter) = mean(fitness);
    aptidao_minima(iter) = min(fitness);
    aptidao_maxima(iter) = max(fitness);
    aptidao_mediana(iter) = median(fitness);
    
    % Plotar a posição das partículas a cada 10 iterações
    %Utilizando o comando ezcontour o gráfico referente a função de ackley
    %não apresenta tantas curvas e sem levar em conta que o mesmo tem uma
    %maior demora para se executado
    
%     if mod(iter,10) == 0
%         figure;
%         plot(x(:,1),x(:,2),'ro', 'MarkerFaceColor', 'blue');
%         hold on;
%         ezcontour(@(x,y)ackley(x,y),[-5,5]);
%         xlabel('x');
%         ylabel('y');
%         title(['Iteração ',num2str(iter)]);
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
        title(['Iteração ',num2str(iter)]);
    end
end

% Plotar os gráficos dos valores médio, mínimo, máximo e mediana da aptidão ao longo das várias gerações
figure;
plot(aptidao_media,'b');
hold on;
plot(aptidao_minima,'r');
plot(aptidao_maxima,'g');
plot(aptidao_mediana,'m');
legend('Média','Mínima','Máxima','Mediana');
xlabel('Iteração');
ylabel('Aptidão');

% Encontrar e imprimir o ponto de mínimo global
[valor_minimo, indice_minimo] = min(fitness);
melhor_particula = x(indice_minimo,:);
fprintf('O ponto de mínimo global é (%f,%f) com valor de aptidão %f\n',melhor_particula(1),melhor_particula(2),valor_minimo);