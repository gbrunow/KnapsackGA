function mutated_genotype = mutate( genotype, mutation_rate)
    for i=1:length(genotype)
        if rand(1)<=mutation_rate
            genotype(i) = ~genotype(i);
        end
    end
    mutated_genotype = genotype;
end

