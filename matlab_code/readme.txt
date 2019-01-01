1.将android的手机采集的wifi数据（.txt文件）存放至matlab工程文件目录下
2.运行[ avg_processing_time,avg_execute_time,estimate_position, position_err,mean_err,accurate_rate,std_err ] = hy_main  (file_train_name,file_test_name,train_num,validation_num,test_num,test_numcase,numdim )函数
　　input:
       file_train_name:采集的训练数据文件夹
　　　　　　　file_test_name:采集的测试数据文件夹
　　　　　　　train_num:设置每个RP点训练的数据量（比如在一个点采集１００个数据，那么该点训练的数据可用８０）
　　　　　　　validation_num:设置每个RP点验证的数据量（比如在一个点采集１００个数据，那么该点验证的数据可用２０，训练与验证数据按照４：１的比例进行划分）
　　　　　　　test_num:设置每个测试点的数据量大小，一般采集１０几个数据，数量越大运行时间越慢（可设为１０或者１５）
　　　　　　　test_numcase:设置训练时候batchsize的大小（一般可设为５或者１０）
　　　　　　　numdim:设置使用AP数量的大小（比如采集了来自４０个AP点的wifi数据，此时numdim可设为０～４０之间的任何数字，理论上numdim越大生成的指纹数据更为精确）
　　　output:
       avg_processing_time:计算训练阶段每个RP点耗费的运行时间
       avg_execute_time:计算测试阶段每个RP点耗费的运行时间
       estimate_position:生成测试阶段wifi数据对应的估计坐标位置
       position_err:生成估计坐标位置与实际位置之间的平局误差
       mean_err:生成估计结果的平均误误差
       accurate_rate:生成定位精度
       std_err:生成定位精度的标准差，评估定位漂移指数
