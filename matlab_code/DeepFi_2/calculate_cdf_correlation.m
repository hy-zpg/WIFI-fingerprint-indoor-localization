function [hy_coef] = calculate_cdf_correlation( file_name, train_num, validation_num )
output = GetData('x',file_name);
num_position = size(output,2);
%the number of position
[~,M] = size(output);
%definite the number of test data


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
%obtain output(2,i) data 
for i = 1:1:M
   %train_x
     cell_train_data{i}(:,:) = output{2,i}(7:(6+train_num),2:size(output{2,i}(:,:),2)-1); %Œ¨∂» «47-6+1
   %test_x
     cell_test_data{i}(:,:)  = output{2,i}( size(output{2,i}(:,:),1)-validation_num+1:size(output{2,i}(:,:),1), 2:size(output{2,i}(:,:),2)-1);
   %train_test_y
     cell_y{i}(1,:) = output{1,i}(1:2);
   
end



%transform the 2-D matrix to 2-D matrix
     matrix_train_x = cell_train_data{1}(:,:);
     matrix_test_x = cell_test_data{1}(:,:);
     matrix_y(1,:)= cell_y{1}(1,:);
for i = 2:1:M
     matrix_train_x = [matrix_train_x;cell_train_data{i}(:,:)];
     matrix_test_x =  [matrix_test_x;cell_test_data{i}(:,:)];
     matrix_y = [matrix_y;cell_y{i}(1,:)];
end


for j=1:1:num_position-1
for i=1:1:train_num
    coef{j,i}(:,:) = corrcoef(  matrix_train_x(i,:) , matrix_train_x(train_num*j+i,:));
    hy_coef(j,i) =  coef{j,i}(1,2)-1;
end
    cdfplot(hy_coef(j,:));
    hold on
end
legend('grid_size=10m','grid_size=30cm','grid_size=50m','grid_size=80cm','grid_size=100cm');

end






