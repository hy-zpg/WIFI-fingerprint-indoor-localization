function [ estimate_position,avg_execute_time ] = trajectory_estimation( num_point,num_train_position)
   tic;
for j=1:1:num_point
   dataname = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\estimation_trajectory_data\test_data' num2str(j) '.mat']; 
   for i=1:1:num_train_position
     traindataname = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\weightdataname_all\mnist_weights' num2str(i) '.mat'];
     P(i) = errfunc1(dataname,traindataname );
   end
     sum_P = sum(P(:));
     estimate_position(j,1)=0;
     estimate_position(j,2)=0;
   for i=1:1:num_train_position
     positionname = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_all\position' num2str(i) '.mat'];
     load (positionname);
     Pr(i) = P(i)./ sum_P;
     x(i) = Pr(i).* position(1);
     y(i) = Pr(i).* position(2);
     estimate_position(j,1) = estimate_position(j,1) + x(i);
     estimate_position(j,2) = estimate_position(j,2) + y(i);
   end
   t=toc;
end
     avg_execute_time = t./num_point;
    
  plot(estimate_position(:,1),estimate_position(:,2),'.-r');
%   hold on
%     x= [0 0.8 1.6 2.4 3.2 4 4.8 5.6 5.6 5.6 5.6 5.6 5.6 4.8 4 3.2 2.4 1.6 0.8 0 0 0 0 0 0 ];
%     y= [0 0 0 0 0 0 0 0 0.8 1.6 2.4 3.2 4.3 4.3 4.3 4.3 4.3 4.3 4.3 4.3 3.2 2.4 1.6 0.8 0];
%     plot(x,y,'.-b')


end

