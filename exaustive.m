function result = exaustive(items, max_weight, max_volume)
    robberies = de2bi(1:2^size(items, 1)-1)';
    best_robbery = 1;
    best_value = 0;
    knapsack = zeros(10,3);
    for i=1:2^size(items, 1)-1
           knapsack = items(:,2:end).*[robberies(:,i) robberies(:,i) robberies(:,i)];
           knapsack_values = sum(knapsack,1);
           if(knapsack_values(1) <= max_weight && knapsack_values(2) <= max_volume && knapsack_values(3)>best_value)
              best_value = knapsack_values(3);
              best_robbery = i;
           end
    end
    knapsack = items(:,:).*[robberies(:,best_robbery) robberies(:,best_robbery) robberies(:,best_robbery) robberies(:,best_robbery)];
    [row,column] = find(knapsack ~= 0);
    row = unique(row);
    result = knapsack(row,:);
end

