%purpose:divide the original large data into reasonable batches data 
%input:original data 
%output:the batches of packets 
function [batchdata]=hy_getbatchdata(one_position_data,numcases)


M = size(one_position_data,1);
numdims=size(one_position_data,2); %visible nodes
numbatches=M/numcases;% position number

batchdata = zeros(numcases, numdims,numbatches);
for b=1:numbatches
    for c=1:numcases
        batchdata(c,:,b) = one_position_data( (b-1)*numcases+c , :);
    end
end

%batchdata=batchdata/max(max(max(batchdata)));

% batchdataname=['F:\matlab_workspace\hy_deepfi\DeepFi\dataname'];
% save(batchdataname, 'batchdata');
    
end
