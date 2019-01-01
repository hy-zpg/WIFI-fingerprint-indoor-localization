function [ output_args ] = heter_obtain_trainding_data(filename1, filename2, num_train, num_validation )

[hy_train_x11, hy_train_y1, hy_test_x11, hy_test_y1,num_position1] = obtain_training_data(filename1,train_num,validation_num);
[hy_train_x12, hy_train_y2, hy_test_x12, hy_test_y2,num_position2] = obtain_training_data(filename2,train_num,validation_num);



end

