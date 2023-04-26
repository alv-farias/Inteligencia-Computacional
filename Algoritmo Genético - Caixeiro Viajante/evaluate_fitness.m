%% Fun��o de avalia��o da aptid�o
%dist_matrix � a matriz de dist�ncias definidas no problema
%solution � a solu��o candidatada do problema. Na execu��o do main �
%passado o valor da gera��o atual com muta��o
function fitness = evaluate_fitness(solution, dist_matrix)
    %inicializa o fitness como zerado
    fitness = 0;
    n = length(solution);
    %A cada itera��o calculasse a dist�ncia com base na matriz de
    %dist�ncias e esse valor � adicionado ao fitness at� verificar todas as
    %cidades
    for i = 1:n-1
        fitness = fitness + dist_matrix(solution(i), solution(i+1));
    end
    %Adiciona a dist�ncia do ultimo ponto para o primeiro
    fitness = fitness + dist_matrix(solution(n), solution(1));
end