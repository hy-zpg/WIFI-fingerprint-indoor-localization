function draw_environment_picture(file_train_name,file_test_name,numdim)
[~,num_train_position]= hy_training_phase( file_train_name,40,5,numdim );
[num_test_position] = obtain_estimation_data (file_test_name,5,5,numdim);

for i=1:1:num_train_position
    dataname1 = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_all\position' num2str(i) '.mat']; 
    load (dataname1);
    plot(position(1),position(2),'ob');
    hold on
end

for j=1:1:num_test_position
    dataname2 = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_test\position' num2str(j) '.mat']; 
    load (dataname2);
    plot(position(1),position(2),'.-r');
    hold on
    plot(x,y,'.-b')
end
end