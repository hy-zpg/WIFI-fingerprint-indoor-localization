function [ var_data, CV] = calculate_position_propability(test_data)
 data_num = size(test_data,1);
 data(:,:) = test_data(1,:,:);
 for i=2:1:data_num
     data(:,:) = [data;test_data(i,:,:)];
 end
mean_data = mean(mean(data));
std_data = std2(data);
var_data = std_data.^2;
CV = std_data./mean_data;
end
 

