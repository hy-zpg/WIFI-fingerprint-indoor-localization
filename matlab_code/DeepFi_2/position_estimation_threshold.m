function [ estimate_position, position_err,mean_err,accurate_rate,std_err,avg_execute_time] = position_estimation_threshold( num_train_position, num_test_position,threshold )
   tic;
   accurate_num = 0;
   mean_err = 0;
   
for j=1:1:num_test_position
      dataname = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\estimation_data\test_data' num2str(j) '.mat']; 
      
   for i=1:1:num_train_position
     traindataname = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\weightdataname_all\mnist_weights' num2str(i) '.mat'];
     P(i) = errfunc1(dataname,traindataname );
   end

%      [new_P,index] = sort(P,'descend');     
     sum_P = sum(P(:));
     estimate_position(j,1)=0;
     estimate_position(j,2)=0;
     
     
      for i=1:1:num_train_position
         positionname = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_all\position' num2str(i) '.mat'];
         load (positionname);
         Pr(i) = P(i)./ sum_P;
         if Pr(i)< threshold
             continue;
         x(i) = Pr(i).* position(1);
         y(i) = Pr(i).* position(2);
         estimate_position(j,1) = estimate_position(j,1) + x(i);
         estimate_position(j,2) = estimate_position(j,2) + y(i);
      end
         
         
         
%    for i=1:1:num_train_position
%      positionname = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_all\position' num2str(i) '.mat'];
%      load (positionname);
%      Pr(i) = P(i)./ sum_P;
%      x(i) = Pr(i).* position(1);
%      y(i) = Pr(i).* position(2);
%      estimate_position(j,1) = estimate_position(j,1) + x(i);
%      estimate_position(j,2) = estimate_position(j,2) + y(i);
%    end
   
   
   t=toc;
     %save(position_estimation,'estimation_position(j,:)');
     current_positionname = ['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_test\position' num2str(j) '.mat'];
     load (current_positionname);
     position_err(j) =  sqrt(   (estimate_position(j,1)-position(1))^2 +  (estimate_position(j,2)-position(2))^2    );  
     %save(position_err,'err(j)');
     if position_err(j)<1
      accurate_num = accurate_num + 1;
     end
     
     
     
end
     accurate_rate = accurate_num./num_test_position;
     mean_err = 1/num_test_position.*sum(position_err(:));
     std_err = sqrt(var(position_err(:)));
     avg_execute_time = t./num_test_position;
     cdfplot(position_err(:));
     
end
end

