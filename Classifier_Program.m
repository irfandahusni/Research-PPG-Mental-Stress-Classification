%Input and Target
%input = (xlsread('dummydata v2','sheet1','A2:D46')); 
%target = (xlsread('dummydata v2','sheet1','E2:E46')); 
function [out_class classifyNN] = Classifier_Program(trainX,trainY,testX,testY,num_class)
        
        %Training Data
        input = trainX;
        target = trainY;
        inputNN = transpose (input);
        targetplt = transpose(target);
        targetplot = ind2vec(targetplt);
        targetplot = full(targetplot);
        
        %Test Data
        input_test = transpose(testX);
        target_test = transpose(testY);
        target_test = ind2vec(target_test);
        target_test = full(target_test);
        
        input_test_ML = testX;
        target_test_ML = testY;
        
        %******************************************************************************************************
        %Neural Network Classificiation

        %Neural Network Settings :
        hiddenLayerSize = 10;   
        NNmodel = patternnet(hiddenLayerSize);
        NNmodel.input.processFcns = {'removeconstantrows','mapminmax'};
        NNmodel.output.processFcns = {'removeconstantrows','mapminmax'};
        NNmodel.divideFcn = 'dividerand';
        % NNmodel.divideParam.trainInd = 1:5; %Training Data
        % NNmodel.divideParam.valInd   = 6:7; %Validation Data
        % NNmodel.divideParam.testInd  = 8:10; %Test Data
        NNmodel.trainParam.epochs = 100;
        NNmodel.performFcn = 'mse';  %Training Performance Metric
        trainFcn = 'trainrb';  % Training Method
        NNmodel.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
            'plotconfusion', 'plotroc'}; %Plot Function

        %Train Neural Network 
        [NNmodel,tr] = train(NNmodel,inputNN,targetplot);

        %Test Neural Network
        classifyNN = NNmodel(input_test);

        %Compute Performance
        performance = perform(NNmodel,target_test,classifyNN);
        targetNN = vec2ind(target_test); %vector to indices  
        classifyNN = vec2ind(classifyNN);
        inequalityNN = sum(targetNN ~= classifyNN); %find inequality between predicted and actual
        errorNN = inequalityNN/length(target_test);
        accuracyNN = (1-errorNN)*100;

        %Plot Confusion Matrix
        figure(1)
        classifyNN_plot = ind2vec(classifyNN);
        classifyNN_plot = full(classifyNN_plot);

        %Prevent Error from plotting
        l = length(classifyNN_plot(:,1))
        if (l ~= num_class )
            classifyNN_plot(num_class,:) = 0;
        end 

        plotconfusion(target_test,classifyNN_plot);
        title('Neural Network Confusion Matrix');
        %******************************************************************************************************
%         %K Nearest Neighbor Classification
% 
%         %Training KNN
%         kNNModel = fitcknn(input,target)
% 
%         %Classifying kNN
%         classifyKNN = predict(kNNModel,input_test_ML)
% 
%         %Compute Performance 
%         inequalitykNN = sum(target_test_ML ~= classifyKNN); %find inequality between predicted and actual
%         errorkNN = inequalitykNN/length(target_test);
%         accuracykNN = (1-errorkNN)*100;
% 
%         %Plot Confusion Matrix
% 
%         figure(2)
% 
%         plt_classifyKNN = transpose(classifyKNN);
%         plt_classifyKNN = ind2vec(plt_classifyKNN);
%         plotconfusion(target_test,plt_classifyKNN)
%         title('KNN Confusion Matrix')
% 
%         %******************************************************************************************************
%         %Discriminant Analysis Classification (DA)
% 
%         %%Training DA
%         DAModel = fitcdiscr(input,target)
% 
%         %Classifying DA
%         classifyDA = predict(DAModel,input_test_ML)
% 
%         %Compute Performance 
%         inequalityDA = sum(target_test_ML ~= classifyDA); %find inequality between predicted and actual
%         errorDA = inequalityDA/length(target_test);
%         accuracyDA = (1-errorDA)*100;
% 
%         %plot confusion matrix
% 
%         figure(3)
%         plt_classifyDA = transpose(classifyDA);
%         plt_classifyDA = ind2vec(plt_classifyDA);
%         plotconfusion(target_test,plt_classifyDA);
%         title('Discriminant Analysis Confusion Matrix')
% 
%         %******************************************************************************************************
%         %Naive Bayes Classification
% 
%         %%Training NB
%         NBModel = fitcnb(input,target)
% 
%         %Classifying DA
%         classifyNB = predict(NBModel,input_test_ML)
% 
%         %Compute Performance 
%         inequalityNB = sum(target_test_ML ~= classifyNB); %find inequality between predicted and actual
%         errorNB = inequalityNB/length(target_test);
%         accuracyNB = (1-errorNB)*100;
% 
%         figure(4)
%         plt_classifyNB = transpose(classifyNB);
%         plt_classifyNB = ind2vec(plt_classifyNB);
%         plotconfusion(target_test,plt_classifyNB);
%         title('Naive Bayes Confusion Matrix');
% 
%         %******************************************************************************************************
%         figure
%         name = {'NN';'kNN';'DA';'NB'};
%         x = [1:4]; y = [accuracyNN accuracykNN accuracyDA accuracyNB]; 
%         bar(x,y,0.3)
%         set(gca,'xticklabel',name)
%         title('Tingkat Akurasi');
        out_class = NNmodel;
end