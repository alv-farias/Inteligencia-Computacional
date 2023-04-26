%% Fun��o de sele��o dos pais
function parents = select_parents(population, fitness)
    % o n�mero de pais a serem utilizados � definido como o tamanho da
    % popula��o atual
    n_parents = length(population);
    %o "~" ignora os valores ordenados da fun��o sort
    %organiza a aptid�o dos individuos de forma crescente e os indices s�o
    %armazenados em sort_indices
    [~, sort_indices] = sort(fitness);
    %organiza os pais de acordo com a ordem do vetor sort_indices ou seja,
    %com base na sua aptid�o
    parents = cell(n_parents, 1);
    for i = 1:n_parents
        parent_index = sort_indices(i);
        parents{i} = population{parent_index};
    end
end