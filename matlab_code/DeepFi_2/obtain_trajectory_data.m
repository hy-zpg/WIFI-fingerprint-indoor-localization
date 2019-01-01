function [ hy_test1,num_point] = obtain_trajectory_data( file_test,test_num,numdim )
output = GetData('x',file_test);
num_point = floor((size(output{2,1},1)-6)/test_num);
for i=1:1:num_point
 cell_test_data{i}(:,:) = output{2,1}( 7+(i-1)*test_num:7+i*test_num-1 , 2:size(output{2,1}(:,:),2)-1); 
end
 matrix_test = cell_test_data{1}(:,:);
for i = 2:1:num_point
     matrix_test = [matrix_test;cell_test_data{i}(:,:)];
end

hy_test = zeros(size(matrix_test));
test_max = max(max(matrix_test));
test_min = min(min(matrix_test));
  for i=1:1:size(matrix_test,1)
      for j=1:1:size(matrix_test,2)
          hy_test(i,j) = (matrix_test(i,j) - test_min)./ (test_max - test_min);
      end
  end
  
  
  %set the numdim
  hy_test1 = hy_test(:,1:numdim);
  
  
  
  for i=1:1:num_point
        file_data=['F:\matlab_workspace\hy_deepfi\DeepFi_2\estimation_trajectory_data\test_data' num2str(i)];
        estimation_batch = hy_test1(   (test_num*(i-1)+1):test_num*i , :     );
        test_data = hy_getbatchdata( estimation_batch(:,:), test_num);
        save (file_data, 'test_data');
  end
end
