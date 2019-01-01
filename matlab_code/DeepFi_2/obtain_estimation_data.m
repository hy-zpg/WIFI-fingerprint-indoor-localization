function [num_test_position] = obtain_estimation_data (file_test_name,test_num,test_numcase,numdim)
[hy_train_x1, hy_train_y, ~, ~,num_position] = obtain_training_data(file_test_name,test_num,1,numdim);
%%set the data number of per batch
for i=1:1:num_position
        file_data=['F:\matlab_workspace\hy_deepfi\DeepFi_2\estimation_data\test_data' num2str(i)];
        file_position=['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_test\position' num2str(i)];
        estimation_batch = hy_train_x1(   (test_num*(i-1)+1):test_num*i , :     );
        test_data = hy_getbatchdata( estimation_batch(:,:), test_numcase);
        position = hy_train_y( test_num*(i-1)+1 ,:);
        save (file_data, 'test_data');
        save(file_position,'position');
end
num_test_position = num_position;
end


