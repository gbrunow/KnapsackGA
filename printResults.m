function out = printResults( items, knapsack, time, columns, method )
    clc;
    fprintf(['\n<strong>Knapback ', method ,' ', num2str(size(items,1)), ' items:</strong>\n']);
    totals = sum(knapsack(:,2:end),1);
    fprintf(['Weight: ', num2str(totals(1)),'\tVolume: ', num2str(totals(2)), '\tValue: ', num2str(totals(3)), '\n']);
    fprintf('Items:\n');
    for i=1:columns:size(knapsack,1)
        try
            items_row = ['\t', num2str(knapsack(i,1))];
            for j=1:(columns-1)
                items_row = [items_row, '\t', num2str(knapsack(i+j,1)),];
            end
        catch
        end
        fprintf([items_row, '\n']);
    end
    fprintf(['Time elapsed for ', num2str(size(items,1)) , ' items: ', num2str(time), ' seconds\n']);
end

