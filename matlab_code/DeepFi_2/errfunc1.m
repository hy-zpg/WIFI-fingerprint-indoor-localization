%purpose:calculate the error between data and traindata
%input:
%output:error
function [P] = errfunc1(dataname,traindataname)
load (dataname);
load (traindataname);
[numcases , ~, numbatches]=size(test_data);
N=numcases;
P=0;
[ var_data, CV] = calculate_position_propability(dataname);
for batch = 1:numbatches
  data = [test_data(:,:,batch)];
  data = [data ones(N,1)];
  w1probs = 1./(1 + exp(-data*w1)); w1probs = [w1probs  ones(N,1)];
  w2probs = 1./(1 + exp(-w1probs*w2)); w2probs = [w2probs ones(N,1)];
  w3probs = 1./(1 + exp(-w2probs*w3)); w3probs = [w3probs  ones(N,1)];
  w4probs = w3probs*w4; w4probs = [w4probs  ones(N,1)];
  w5probs = 1./(1 + exp(-w4probs*w5)); w5probs = [w5probs  ones(N,1)];
  w6probs = 1./(1 + exp(-w5probs*w6)); w6probs = [w6probs  ones(N,1)];
  w7probs = 1./(1 + exp(-w6probs*w7)); w7probs = [w7probs  ones(N,1)];
  dataout = 1./(1 + exp(-w7probs*w8));
  %d = sum(sum( (data(:,1:end-1)-dataout).^2 )); %Ejideli distance
%     P = P +  1/N*sum(sum( (data(:,1:end-1)-dataout).^2 ));
  d = sum(exp(-sum(((data(:,1:end-1)-dataout).^2)' )./( var(data(:,1:end-1)'.*1 ))));
%     d = sum(exp(-sum(((data(:,1:end-1)-dataout).^2)')./var_data.*CV));
%    P=P+d;
%    P=P+sum(exp(-sum(((data(:,1:end-1)-dataout).^2)')./(2*10*var(data(:,1:end-1)'))));
end


 P=d/numbatches/numcases;
 %P = exp(- P./(var_data.*CV));
 fprintf(1,'squared error: %6.8f ,%s of %s \t \t \n',P, dataname, traindataname);
end
