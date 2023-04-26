%% Parâmetros do algoritmo genético
pop_size = 100;  % Tamanho da população
max_gen = 100;  % Número máximo de gerações
crossover_rate = 0.8;  % Taxa de crossover
mutation_rate = 0.02;  % Taxa de mutação
n_break_points = 2;  % Número de pontos de quebra

%% Dados do problema
n_cities = 10;  % Número de cidades
% Nomes das cidades
city_names = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];  
% Matriz de distâncias entre as cidades
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

%% Inicialização da população
population = cell(pop_size, 1);
for i = 1:pop_size
    %gera uma sequencia de visitas a cidades aleatorias para o individuo
    population{i} = randperm(n_cities);
end

%% Avaliação da população
%inicia a matriz de fitness apenas com zeros que será preenchida com os
%fitness dos individuos
fitness = zeros(pop_size, 1);
for i = 1:pop_size
    fitness(i) = evaluate_fitness(population{i}, dist_matrix);
end

%% Evolução da população

%inicia os valores para a melhor solução e melhor fitness como zero e
%infinito respectivamente
%o valor infinto é admitido para que garanta que a mesma sempre armazenará
%o melhor valor de fitness pois garante que qualquer valor encontrado será
%menor que o da primeira geração sendo sempre atualizada em cada iteração
best_solution = [];
best_fitness = Inf;

for gen = 1:max_gen
% Seleção dos pais
    parents = select_parents(population, fitness);
% Crossover para gerar os individuos
    offspring = crossover(parents, crossover_rate, n_break_points);

% Aplica a Mutação nos individuos gerados
    offspring = mutate(offspring, mutation_rate);

% Avaliação da nova população
    offspring_fitness = zeros(pop_size, 1);
for i = 1:pop_size
    offspring_fitness(i) = evaluate_fitness(offspring{i}, dist_matrix);
end

% Elitismo
%basicamente verifica se o fitness atual é melhor do que o fitness do
%melhor individuo ate então
%best_offspring_index armazena o indice do melhor individuo até então e
%best_offspring_fitness armazena o valor do mesmo
[best_offspring_fitness, best_offspring_index] = min(offspring_fitness);
%Se o best_offspring_fitness for menor que best_fitness que o melhor
%individuo encontrado na geração atual é melhor que o melhor individuo
%encontrado até então e por fim atualiza os valores para best_solution e
%best_fitness
if best_offspring_fitness < best_fitness
    best_solution = offspring{best_offspring_index};
    best_fitness = best_offspring_fitness;
end

% Seleção da próxima população
[population, fitness] = select_population(population, fitness, offspring, offspring_fitness);

% Exibição dos resultados apenas com indices das cidades:
    %disp(['Geração ', num2str(gen), ': Melhor solução = ', num2str(best_solution), ', Fitness = ', num2str(best_fitness)]);
    
% Realiza a troca dos valores para apresentar letras que representam as
% cidades
best_solution_letters = '';
for i = 1:n_cities
    best_solution_letters = [best_solution_letters, city_names(best_solution(i))];
end
% Adiciona a primeira cidade ao final para mostrar toda a sequência do
% caixeiro viajante
best_solution_letters = [best_solution_letters, city_names(best_solution(1))];

disp(['Geração ', num2str(gen), ': Melhor solução = ', best_solution_letters, ', Fitness = ', num2str(best_fitness)]);

end