function [hy_train_x1, hy_train_y, hy_test_x1, hy_test_y,num_position] = obtain_training_data(file_name,train_num,validation_num,numdim)
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

%  hy_train_x(:,:) = 10.^(matrix_train_x(:,:)/10); 
%  hy_test_x(:,:) = 10.^(matrix_test_x(:,:)/10); 

%normolize the train_x and test_x data
%train_data
hy_train_x = zeros(size(matrix_train_x));
train_max = max(max(matrix_train_x));
train_min = min(min(matrix_train_x));
  for i=1:1:size(matrix_train_x,1)
      for j=1:1:size(matrix_train_x,2)
          hy_train_x(i,j) = (matrix_train_x(i,j) - train_min)./ (train_max - train_min);
      end
  end
  
%test_data
hy_test_x = zeros(size(matrix_test_x));
test_max = max(max(matrix_test_x));
test_min = min(min(matrix_test_x));
  for i=1:1:size(matrix_test_x,1)
      for j=1:1:size(matrix_test_x,2)
          hy_test_x(i,j) = (matrix_test_x(i,j) - test_min)./ (test_max - test_min);
      end
  end
% %test for estimation
% hy_test = zeros(size(matrix_test));
% test1_max = max(max(matrix_test));
% test1_min = min(min(matrix_test));
%   for i=1:1:size(matrix_test,1)
%       for j=1:1:size(matrix_test,2)
%           hy_test(i,j) = (matrix_test(i,j) - test1_min)./ (test1_max - test1_min);
%       end
%   end
  

%set the dimnum
 hy_train_x1(:,:) = hy_train_x(:,1:numdim);  
 hy_test_x1(:,:) = hy_test_x(:,1:numdim);  

 
 

 
  
  
  

  
  
  
  
  %obtain the the train_y and test_y data
 num1=0; 
 num2=0;
 hy_train_y = zeros(size(hy_train_x,1),2);
 hy_test_y = zeros(size(hy_test_x,1),2);
for i=1:1:M
  
    num_train(i) = size(cell_train_data{i}(:,:),1);
       for j=1:1:num_train(i)
         hy_train_y(num1+j,:) = matrix_y(i,:);
       end
    num1 = num1 + num_train(i);
       for k=1:1:validation_num
           hy_test_y(num2+k,:) = matrix_y(i,:);
       end
    num2 = num2 + validation_num;
      
end
end
