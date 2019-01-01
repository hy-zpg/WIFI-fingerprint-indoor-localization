function [avg_processing_time,avg_execute_time,estimate_position, position_err,mean_err,accurate_rate,std_err  ] = center_hy_main(file_train_name,file_test_name,train_num,validation_num,test_num,test_numcase,num_center)

%[ avg_processing_time,avg_execute_time,estimate_position,
%position_err,mean_err,accurate_rate,std_err ] = hy_main(  'hy_quickscan_3_train','hy_quickscan_3_test',40,15,10,10 );


%training phase:set the train_num and validation_num, calculate the average
%processing time and the train position
[avg_processing_time,num_train_position]= hy_training_phase( file_train_name,train_num,validation_num );

%obtain the estimation data:set the test num and its numcase,calculate the
%test position
[num_test_position] = obtain_estimation_data (file_test_name,test_num,test_numcase);

%evaluate the positioning effect,calculate relative valuation standard data
[estimate_position, position_err,mean_err,accurate_rate,std_err,avg_execute_time] = center_position_estimation (num_train_position, num_test_position,num_center);

end

