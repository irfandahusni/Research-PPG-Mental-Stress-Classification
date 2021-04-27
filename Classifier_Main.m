%function [out_main] = Classifier_Main();

%Program untuk mengambil data dan melakukan klasifikasi

%Mengambil Data Puncak Dari Subjek
[cell_data] = Sampling_and_Sequencing_All();

%Mengubah Data menjadi format ML
[dataset5] = machine_learning_format(cell_data,1,1);
[dataset10] = machine_learning_format(cell_data,2,2);
[dataset15] = machine_learning_format(cell_data,3,3);
[dataset20] = machine_learning_format(cell_data,4,4);
[dataset_rest] = machine_learning_format(cell_data,5,5);


%Menggabungkan Data
dataset = [dataset_rest;dataset5;dataset10;dataset15;dataset20];
dataset = dataset(all(dataset,2),:);

% %Pembagian data Train dan Test

train_split = 0.8;
test_split = 0.2;

rng('default');
cv = cvpartition(size(dataset,1),'HoldOut',test_split);
idx = cv.test;
dataTrain = dataset(~idx,:);
dataTest  = dataset(idx,:);

size_Train = size(dataTrain);
size_Test  = size(dataTest);

input_train = dataTrain(:,1:size_Train(2)-1);
target_train = dataTrain(:,size_Train(2));

input_test = dataTest(:,1:size_Train(2)-1);
target_test = dataTest(:,size_Train(2));

% %Menjalankan Klasifikasi
[NNModel classifyNN] = Classifier_Program(input_train,target_train,input_test,target_test,5)

out_main = 0;
%end