%% Função de crossover
%Recebe os pais, a taxa de crossover e o numero de pontos de quebra no
%cromossomo
function offspring = crossover(parents, crossover_rate, n_break_points)
    %define o número de filhos que serão gerados
    n_offspring = length(parents);
    %cria uma celula que armazenara os filhos
    offspring = cell(n_offspring, 1);
    %percorre a matriz dos pais em pares, pois dois pais serão utilizados
    %na operação de corssover
    for i = 1:2:n_offspring-1
        %verifica se o crossover será realizado nos pais com base na taxa
        %de crossover definida
        if rand < crossover_rate
            %se for possivel realizar o crossover então é selecionado dois
            %pais adjacentes que estão na matriz depais
            parent1 = parents{i};  
            parent2 = parents{i+1};
            
            %inicialmente os filhos são definidos de uma forma que se
            %mantém iguais aos pais
            offspring1 = parent1;
            offspring2 = parent2;
            %no rendperm o primeiro argumento é dado como length(parent)-1
            %pois o último gene não pode ser ponto de quebra
            %sort organiza os pontos de forma crescente para efetuar as
            %trocas
            break_points = sort(randperm(length(parent1)-1, n_break_points));
            for j = 1:length(break_points)
                %armazena o ponto de quebra atual
                bp = break_points(j);
                %offspring1(bp+1:end) seleciona a parte do vetor que vem
                %após o ponto de quebra atual, ou a parte que será
                %substituída
                %setdiff(parent2, offspring1(1:bp)) desconsidera os genes
                %que estariam antes do ponto de quebra restando apenas o
                %que deve ser adicionado no filho offspring1
                offspring1(bp+1:end) = setdiff(parent2, offspring1(1:bp));
                %repete os passos exemplificados para o filho offspring2
                offspring2(bp+1:end) = setdiff(parent1, offspring2(1:bp));
            end
        %adiciona ao vetor offspring que guarda os filhos gerados os genes
        %do filho 1 e filho 2 em suas respectivas posições de forma que
        %eles fiquem adjacentes
        offspring{i} = offspring1;
        offspring{i+1} = offspring2;
        %se não for realizado o crossover os filhos são definidos como os
        %pais que seriam utilizados no crossover
        else
            offspring{i} = parents{i};
            offspring{i+1} = parents{i+1};
        end
    end
end
