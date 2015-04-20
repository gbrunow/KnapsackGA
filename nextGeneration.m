function  next_generation = nextGeneration(items, population, population_size, elite_size, mutation_rate)
    max_weight = 200; max_volume = 500;
    for i=1:population_size
        pop_fitness(i) = fitness(population(i,:), items);
    end
    %--- reproductio/selection --%
    total_fitness = sum(pop_fitness,2);
    normalized_pop_fit = pop_fitness./total_fitness;
    rank = 0;

    %--- determine the propability of selection based on the fitness ---%
    for i=1:population_size
        rank = rank + normalized_pop_fit(i);
        ranked_pop(i) = rank;
    end

    %--- arrange mates for reproduction ---%
    for i=1:(population_size)
        [c index] = min(abs(ranked_pop-rand(1)));
        mates(i) = index;
    end
    parents1 = population(mates(1:2:size(population)),:);
    parents2 = population(mates(2:2:size(population)),:);

    %--- reproduction ---%
    reproduction_bits = randi([0 1],size(items,1),population_size/2)';
    children1 = max(min(parents1, ~reproduction_bits), min(parents2, reproduction_bits));
    children2 = max(min(parents2, ~reproduction_bits), min(parents1, reproduction_bits));

    %--- mutation ---%    
    for i = size(children1,1)
        children1(i,:) = mutate(children1(i,:), mutation_rate);
        children2(i,:) = mutate(children2(i,:), mutation_rate);
    end
    new_population = [children1; children2];
    for i=1:population_size
        knapsack = items.*[new_population(i,:)' new_population(i,:)' new_population(i,:)' new_population(i,:)'];
        knapsack_values = sum(knapsack,1);
        if (knapsack_values(2) > max_weight || knapsack_values(3) > max_volume)
            drop_index = find(new_population(i,:) == 1);
            drop_index = drop_index(randperm(size(drop_index,2)));
            j = 1;
            while(knapsack_values(2) > max_weight || knapsack_values(3) > max_volume)
                new_population(i,drop_index(j)) = 0;
                j = j + 1;
                knapsack = items.*[new_population(i,:)' new_population(i,:)' new_population(i,:)' new_population(i,:)'];
                knapsack_values = sum(knapsack,1);
            end
        end
    end     
    nullGenotypes = find(sum(new_population,2)==0);
    for i=nullGenotypes'
        new_population(i,randi(size(items,1))) = 1;
    end
 
     %--- eletism ---%
    for i=1:elite_size
        [c index] = min(abs(pop_fitness-min(pop_fitness))); %index of worst genotype of current generation
        new_population(index,:) = population(i,:); %i elite from original population
    end

    next_generation = new_population;
end

