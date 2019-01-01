function  [avg_processing_time,num_train_position]= hy_training_phase( file_train_name,train_num,validation_num,numdim )
%training
tic;
numcases = 5; %set the number per batch
[hy_train_x, hy_train_y, hy_test_x, ~,num_position] = obtain_training_data(file_train_name,train_num,validation_num,numdim);
num_train_position = num_position;
for i=1:1:num_position
        file_data=['F:\matlab_workspace\hy_deepfi\DeepFi_2\dataname_all\batchtestdata' num2str(i)];
        file_position=['F:\matlab_workspace\hy_deepfi\DeepFi_2\position_all\position' num2str(i)];
        position_batch = hy_train_x(   (train_num*(i-1)+1):train_num*i , :     );
        position_testbatch =hy_test_x(  (validation_num*(i-1)+1):validation_num*i , :    );
        position = hy_train_y( train_num*(i-1)+1 ,:);
        batchdata = hy_getbatchdata( position_batch(:,:), numcases);
        testbatchdata = hy_getbatchdata( position_testbatch(:,:), numcases);
        save (file_data, 'batchdata','testbatchdata');
        save (file_position,'position');
        fprintf(1,'training data %s prepared', file_data);
        [numcases, numdims, numbatches]=size(batchdata);
         maxepoch=15; %In the Science paper we use maxepoch=50, but it works just fine. 
%             numhid=300; numpen=150; numpen2=100; numopen=50;
%             numhid=200; numpen=100; numpen2=50; numopen=20;
%             numhid=70; numpen=50; numpen2=30; numopen=15;


            numhid=150; numpen=100; numpen2=100;numopen=50;

            fprintf(1,'Pretraining Layer 1 with RBM: %d-%d \n',numdims,numhid);
            restart=1;
            rbm;
            hidrecbiases=hidbiases; 
            save mnistvh vishid hidrecbiases visbiases;
            
            fprintf(1,'\nPretraining Layer 2 with RBM: %d-%d \n',numhid,numpen);
            batchdata=batchposhidprobs;
            numhid=numpen;
            restart=1;
            rbm;
            forword_err(2,:) = err(:);
            hidpen=vishid; penrecbiases=hidbiases; hidgenbiases=visbiases;
            save mnisthp hidpen penrecbiases hidgenbiases;
            
            fprintf(1,'\nPretraining Layer 3 with RBM: %d-%d \n',numpen,numpen2);
            batchdata=batchposhidprobs;
            numhid=numpen2;
            restart=1;
            rbm;
            hidpen2=vishid; penrecbiases2=hidbiases; hidgenbiases2=visbiases;
            save mnisthp2 hidpen2 penrecbiases2 hidgenbiases2;
            
            fprintf(1,'\nPretraining Layer 4 with RBM: %d-%d \n',numpen2,numopen);
            batchdata=batchposhidprobs;
            numhid=numopen; 
            restart=1;
            rbmhidlinear;
            hidtop=vishid; toprecbiases=hidbiases; topgenbiases=visbiases;
            save mnistpo hidtop toprecbiases topgenbiases;
            
            
            
            fprintf(1,'training backpropagation');
            hy_backpropagation_all;
end
            t=toc;
            avg_processing_time = t./ num_position;
 figure;
 plot(train_err(:),'r');
 hold on
 plot(test_err(:),'b');
 hold on 
 xlabel('epoch times');
 ylabel('mean error(m)');
 legend('train set BP error','validation set BP error');
 title('the training pahse backward propogation error');
 figure,
 plot(err_forward(:),'r' );
 xlabel('epoch times');
 ylabel('mean error(m)');
 legend('train set FP error');
 title('the training pahse propogation propogation error');
end

