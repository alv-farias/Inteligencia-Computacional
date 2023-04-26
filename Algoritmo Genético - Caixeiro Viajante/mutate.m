%% Fun��o de muta��o
function offspring = mutate(offspring, mutation_rate)
    % n_offspring cont�m o n�mero de individuos gerados na etapa de
    % cruzamento
    n_offspring = length(offspring);
    %percorre os individuos e verificando se a taxa de muta��o � maior do
    %que o valor gerado pela fun��o rand (gera valores entre 0 e 1) e se
    %for, � aplicado uma muta��o no individuo trocando de forma aleat�ria
    %dois genes do individuo com base nos indices definidos como ind1 e
    %ind2
    %por fim � realizada a troca de indices no individuo na linha 16
    for i = 1:n_offspring
        if rand < mutation_rate
            ind1 = randi(length(offspring{i}));
            ind2 = randi(length(offspring{i}));
            offspring{i}([ind1, ind2]) = offspring{i}([ind2, ind1]);
        end
    end
end
