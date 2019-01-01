function [ estimate_position,avg_execute_time ] = hy_main_trajectory( file_train_name,file_test,train_num,validation_num,test_num,numdim  )
[~,num_train_position]= hy_training_phase( file_train_name,train_num,validation_num,numdim );
for i=1:1:num_train_position
    dataname1 = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_all\position' num2str(i) '.mat']; 
    load (dataname1);
    plot(position(1),position(2),'ob');
    hold on
end
[ ~,num_point] = obtain_trajectory_data( file_test,test_num,numdim);
hold on
[ estimate_position,avg_execute_time ] = trajectory_estimation( num_point,num_train_position);

end

