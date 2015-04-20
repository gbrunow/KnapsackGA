clear all;
clc;

max_weight = 200;
max_volume = 500;
items_740 = textread('hw4data.txt');

index=[740, 735, 700, 654, 617, 528, 474, 346, 283, 195];
items_10 = items_740(index,:);

index=[528, 474, 346, 283, 195, 59, 94, 182, 244,325, 394, 452, 493, 518, 563];
items_15 = items_740(index,:);

index=[394, 452, 493, 518, 563, 740, 735, 700, 654, 617, 483, 436, 377, 364, 348, 260, 216, 92, 29, 7];
items_20 = items_740(index,:);

items = items_15;
fprintf('[1] - 10  Items\n');
fprintf('[2] - 15  Items\n');
fprintf('[3] - 20  Items\n');
fprintf('[4] - 740 Items\n');
option = input('\nOption: ');
clc;

%  while option ~= 5
    if option == 1
        items = items_10;
        population_size = 1500;
        elite_size = 3;
        mutation_rate = 0.15;
        convergence = 0.25;
    elseif option == 2
        items = items_15;
        population_size = 1500;
        elite_size = 15;
        mutation_rate = 0.15;
        convergence = 0.8;
    elseif option == 3
        items = items_20;
        population_size = 220;
        elite_size = 2;
        mutation_rate = 0.1;
        convergence = 0.8;
    elseif option == 4
        items = items_740;
        population_size = 1500;
        elite_size = 5;
        mutation_rate = 0.1;
        convergence = 0.8;
    else
        fprintf('Invalid input.\n');
        return;
    end
    %--- Exaustive items ---%
    if option ~= 4
        tic
        knapsack = exaustive(items, max_weight, max_volume);
        time = toc;

        printResults( items, knapsack, time, 3, 'Exaustive');
        fprintf('\nScript paused, press any key to continue\n');
        pause;

    end

    %--- Greedy items --%
    tic
    knapsack = greedy(items);
    time = toc;

    printResults( items, knapsack, time, 3, 'Greedy');
    fprintf('\nScript paused, press any key to continue\n');
    pause;


    %--- Genetic Algorithm ---%
    tic
    knapsack = geneticAlgorithm(items, population_size, elite_size, mutation_rate, convergence);
    time = toc;

    printResults( items, knapsack, time, 3, 'Genetic Algorithm');
    
%     fprintf('\n[1] - 10  Items\n');
%     fprintf('[2] - 15  Items\n');
%     fprintf('[3] - 20  Items\n');
%     fprintf('[4] - 740 Items\n');
%     fprintf('[5] - Stop\n');
%     option = input('\nOption: ');
%     clc;
% end