%% Fun��o de sele��o da pr�xima popula��o
function [population, fitness] = select_population(population, fitness, offspring, offspring_fitness)
   % pega o tamanho da popul��o, ou seja, a quantidade de individuos
    n_population = length(population);
   % offspring cont�m os individuos gerados pelo cruzamento
    
    %mant�m as aptid�es atuais e dos pr�ximos individuos
    fitness_values = [fitness; offspring_fitness];
    total_population = [population; offspring];
    
    % o "~" ignora os valores ordenados da fun��o sort e a vari�vel
    % sorted_indices armazena apenas o �ndice dos valores ordenados de
    % forma crescente de fitness_values
    [~, sorted_indices] = sort(fitness_values);
    
    %salva os valores de total_population na celula population na ordem
    %definida pela vari�vel sorted_indices, ou seja, de forma crescente
    population = cell(n_population, 1);
    for i = 1:n_population
        population{i} = total_population{sorted_indices(i)};
    end
    
    %salva os valores de aptid�o de forma crescente com base no vetor
    %sorted_indices
    fitness = fitness_values(sorted_indices(1:n_population));
end