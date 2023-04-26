%% Função de avaliação da aptidão
%dist_matrix é a matriz de distâncias definidas no problema
%solution é a solução candidatada do problema. Na execução do main é
%passado o valor da geração atual com mutação
function fitness = evaluate_fitness(solution, dist_matrix)
    %inicializa o fitness como zerado
    fitness = 0;
    n = length(solution);
    %A cada iteração calculasse a distância com base na matriz de
    %distâncias e esse valor é adicionado ao fitness até verificar todas as
    %cidades
    for i = 1:n-1
        fitness = fitness + dist_matrix(solution(i), solution(i+1));
    end
    %Adiciona a distância do ultimo ponto para o primeiro
    fitness = fitness + dist_matrix(solution(n), solution(1));
end