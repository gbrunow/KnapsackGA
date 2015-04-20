function result = geneticAlgorithm(items, population_size, elite_size, mutation_rate, convergence)
    %--- create random initial population --%
    max_weight = 200; max_volume = 500;
    clc;
    fprintf('Creating Initial Population... ');
    for i=1:population_size
        population(i,:) = randi([0 1],size(items,1),1)';
        knapsack = items.*[population(i,:)' population(i,:)' population(i,:)' population(i,:)'];
        knapsack_values = sum(knapsack,1);
        %--- make sure that max_weight and max_volume are not exceeded
        if (knapsack_values(2) > max_weight || knapsack_values(3) > max_volume)
            drop_index = find(population(i,:) == 1);
            drop_index = drop_index(randperm(size(drop_index,2)));
            j = 1;
            while(knapsack_values(2) > max_weight || knapsack_values(3) > max_volume)
                population(i,drop_index(j)) = 0;
                knapsack = items.*[population(i,:)' population(i,:)' population(i,:)' population(i,:)'];
                knapsack_values = sum(knapsack,1);
                j = j + 1;
            end
        end
        knap_m(i,:) = knapsack_values;
        pop_fitness(i) = fitness(population(i,:), items);
    end
    
    nullGenotypes = find(sum(population,2)==0);
    for i=nullGenotypes'
        population(i,randi(size(items,1))) = 1;
    end

    genotypes_convergence = 0;
%     for i=1:15
    generation = 0;
    while genotypes_convergence < convergence
        generation = generation + 1;
        population = nextGeneration(items, population, population_size, elite_size, mutation_rate);
%         genes_convergence = sum(population,1)/(size(population,1));
%         genotypes_convergence = (size(find(genes_convergence<0.1),2) + size(find(genes_convergence>0.9), 2))/size(population,2);
        [a,b,c] = unique(population,'rows');
        % The last column lists the counts
        d = [a accumarray(c,1)];
        repeated_genotypes = max(d(:,end));
        genotypes_convergence = repeated_genotypes/population_size;
%         clc;
%         fprintf(['Genotypes Convergence ', num2str(round(genotypes_convergence*100)),'%%\n']);
%         fprintf(['Generation ', num2str(generation),'\n']);
    end
    for i=1:population_size
        pop_fitness(i) = fitness(population(i,:), items);
    end
    [c index] = min(abs(pop_fitness-max(pop_fitness)));
    knapsack = items.*[population(index,:)' population(index,:)' population(index,:)' population(index,:)'];
    [row,column] = find(knapsack ~= 0);
    row = unique(row);
    result = knapsack(row,:);
end

