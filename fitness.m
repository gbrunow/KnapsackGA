function fit = fitness( genotype, items )
    value = 4;
    knapsack = items.*[genotype' genotype' genotype' genotype'];
    knapsack = sum(knapsack,1);
    fit = knapsack(value)/1e6;
end

