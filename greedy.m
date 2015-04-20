function result = greedy( items )
    max_weight = 200;
    max_volume = 500;
    items = rateAndSort(items);     
    knapsack = zeros(1,4);
    total_weight = 0;
    total_volume = 0;
    weight = 2; volume = 3;
    for i=1:size(items,1)

        if total_weight + items(i,weight) <= max_weight && ...
           total_volume + items(i,volume) <= max_volume
            total_weight = total_weight + items(i,weight);
            total_volume = total_volume + items(i,volume);
            knapsack = [knapsack; items(i,:)];
        end
    end
    result = knapsack(2:end,:);
end

