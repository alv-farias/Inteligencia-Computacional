%% Par�metros do algoritmo gen�tico
pop_size = 100;  % Tamanho da popula��o
max_gen = 100;  % N�mero m�ximo de gera��es
crossover_rate = 0.8;  % Taxa de crossover
mutation_rate = 0.02;  % Taxa de muta��o
n_break_points = 2;  % N�mero de pontos de quebra

%% Dados do problema
n_cities = 10;  % N�mero de cidades
% Nomes das cidades
city_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];  
% Matriz de dist�ncias entre as cidades
dist_matrix = [0, 29, 82, 46, 68, 52, 72, 42, 51, 55;
               29, 0, 55, 46, 42, 43, 43, 23, 23, 31;
               82, 55, 0, 68, 46, 55, 23, 43, 41, 29;
               46, 46, 68, 0, 82, 15, 72, 31, 62, 46;
               68, 42, 46, 82, 0, 74, 23, 54, 23, 31;
               52, 43, 55, 15, 74, 0, 61, 23, 55, 29;
               72, 43, 23, 72, 23, 61, 0, 42, 23, 31;
               42, 23, 43, 31, 54, 23, 42, 0, 33, 15;
               51, 23, 41, 62, 23, 55, 23, 33, 0, 29;
               55, 31, 29, 46, 31, 29, 31, 15, 29, 0]; 

%% Inicializa��o da popula��o
population = cell(pop_size, 1);
for i = 1:pop_size
    %gera uma sequencia de visitas a cidades aleatorias para o individuo
    population{i} = randperm(n_cities);
end

%% Avalia��o da popula��o
%inicia a matriz de fitness apenas com zeros que ser� preenchida com os
%fitness dos individuos
fitness = zeros(pop_size, 1);
for i = 1:pop_size
    fitness(i) = evaluate_fitness(population{i}, dist_matrix);
end

%% Evolu��o da popula��o

%inicia os valores para a melhor solu��o e melhor fitness como zero e
%infinito respectivamente
%o valor infinto � admitido para que garanta que a mesma sempre armazenar�
%o melhor valor de fitness pois garante que qualquer valor encontrado ser�
%menor que o da primeira gera��o sendo sempre atualizada em cada itera��o
best_solution = [];
best_fitness = Inf;

for gen = 1:max_gen
% Sele��o dos pais
    parents = select_parents(population, fitness);
% Crossover para gerar os individuos
    offspring = crossover(parents, crossover_rate, n_break_points);

% Aplica a Muta��o nos individuos gerados
    offspring = mutate(offspring, mutation_rate);

% Avalia��o da nova popula��o
    offspring_fitness = zeros(pop_size, 1);
for i = 1:pop_size
    offspring_fitness(i) = evaluate_fitness(offspring{i}, dist_matrix);
end

% Elitismo
%basicamente verifica se o fitness atual � melhor do que o fitness do
%melhor individuo ate ent�o
%best_offspring_index armazena o indice do melhor individuo at� ent�o e
%best_offspring_fitness armazena o valor do mesmo
[best_offspring_fitness, best_offspring_index] = min(offspring_fitness);
%Se o best_offspring_fitness for menor que best_fitness que o melhor
%individuo encontrado na gera��o atual � melhor que o melhor individuo
%encontrado at� ent�o e por fim atualiza os valores para best_solution e
%best_fitness
if best_offspring_fitness < best_fitness
    best_solution = offspring{best_offspring_index};
    best_fitness = best_offspring_fitness;
end

% Sele��o da pr�xima popula��o
[population, fitness] = select_population(population, fitness, offspring, offspring_fitness);

% Exibi��o dos resultados apenas com indices das cidades:
    %disp(['Gera��o ', num2str(gen), ': Melhor solu��o = ', num2str(best_solution), ', Fitness = ', num2str(best_fitness)]);
    
% Realiza a troca dos valores para apresentar letras que representam as
% cidades
best_solution_letters = '';
for i = 1:n_cities
    best_solution_letters = [best_solution_letters, city_names(best_solution(i))];
end
% Adiciona a primeira cidade ao final para mostrar toda a sequ�ncia do
% caixeiro viajante
best_solution_letters = [best_solution_letters, city_names(best_solution(1))];

disp(['Gera��o ', num2str(gen), ': Melhor solu��o = ', best_solution_letters, ', Fitness = ', num2str(best_fitness)]);

end