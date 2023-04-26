%% Função de seleção dos pais
function parents = select_parents(population, fitness)
    % o número de pais a serem utilizados é definido como o tamanho da
    % população atual
    n_parents = length(population);
    %o "~" ignora os valores ordenados da função sort
    %organiza a aptidão dos individuos de forma crescente e os indices são
    %armazenados em sort_indices
    [~, sort_indices] = sort(fitness);
    %organiza os pais de acordo com a ordem do vetor sort_indices ou seja,
    %com base na sua aptidão
    parents = cell(n_parents, 1);
    for i = 1:n_parents
        parent_index = sort_indices(i);
        parents{i} = population{parent_index};
    end
end