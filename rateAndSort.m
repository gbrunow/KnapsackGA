function result = rateAndSort( items )
    max_weight = 200;
    max_volume = 500;
    weight = 2; volume = 3; value = 4; ratio = 5;
%     for i=1:size(items,1)
%        items(i,ratio) = items(i,value)/(items(i,weight)*max_weight+items(i,volume)*max_volume);    
%     end
    items(:,ratio) = items(:,value).^2./(items(:,weight)*max_weight+items(:,volume)*max_volume);    
    items = sortrows(items,-ratio);
    result = items(:,1:4);
end

