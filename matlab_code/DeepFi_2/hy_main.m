function [ avg_processing_time,avg_execute_time,estimate_position, position_err,mean_err,accurate_rate,std_err ] = hy_main(  file_train_name,file_test_name,train_num,validation_num,test_num,test_numcase,numdim )

%[ avg_processing_time,avg_execute_time,estimate_position,
%position_err,mean_err,accurate_rate,std_err ] = hy_main(  'hy_quickscan_3_train','hy_quickscan_3_test',40,15,10,10 );


%training phase:set the train_num and validation_num, calculate the average
%processing time and the train position
[avg_processing_time,num_train_position]= hy_training_phase( file_train_name,train_num,validation_num,numdim );

%obtain the estimation data:set the test num and its numcase,calculate the
%test position
[num_test_position] = obtain_estimation_data (file_test_name,test_num,test_numcase,numdim);

%evaluate the positioning effect,calculate relative valuation standard data
[estimate_position, position_err,mean_err,accurate_rate,std_err,avg_execute_time] = position_estimation (num_train_position, num_test_position);
%draw the environment
figure;
xlabel('X/(m)');
ylabel('Y/(m)');
title('Layout of training/testing position in experimental environment');
% for i=1:1:num_train_position
%     dataname1 = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_all\position' num2str(i) '.mat']; 
%     load (dataname1);
%     plot(position(1),position(2),'ob');
%     hold on
% end
for i=1:1:num_train_position
    dataname1 = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_all\position' num2str(i) '.mat']; 
    load (dataname1);
    train_position(i,:) = [position(1),position(2)];
end
plot(train_position(:,1),train_position(:,2),'ob');
hold on;


% for j=1:1:num_test_position
%     dataname2 = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_test\position' num2str(j) '.mat']; 
%     load (dataname2);
%     plot(position(1),position(2),'.-r');
%     hold on
% end

for j=1:1:num_test_position
    dataname2 = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_test\position' num2str(j) '.mat']; 
    load (dataname2);
    test_position(j,:) = [position(1),position(2)];
end
plot(test_position(:,1),test_position(:,2),'*r');
hold on;
  
figure, cdfplot(position_err);
xlabel('distance error/(m)');
ylabel('CDF');
title('The CDF of localization error');

end

