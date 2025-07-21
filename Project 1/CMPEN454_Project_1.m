function CMPEN454_Project_1()
    % Load the CIFAR-10 dataset and CNN parameters
    load('cifar10testdata.mat');   
    load('CNNparameters.mat');     
    load('debuggingTest.mat');     

    %I wanted to take out the for loop that goes through the layers to make
    %it more general just in case there wasnt a file that says what each
    %layer is
    
    %If whole folder is used, code can be run with no changes.
    %if planning on using a script or mutiple images comment out the figure
    %line on line 38 so that images of every index dont show up and clog up
    %your computer

    %if you dont have the plane2.jpg or a custom image comment out line 22, 25, and 28
    %through 30 so code will successfully run
    
    %any code with double percentage symbols instead of single, means that
    %code is needed for some optional parts
    % Read your image (replace 'Custome_Image.jpg' with the path to your image)
    your_image = imread('Plane2.jpg');

    % Resize the image to 32x32
    resized_image = imresize(your_image, [32 32]);

    % If the image is grayscale, convert it to RGB
        if size(resized_image, 3) == 1
            resized_image = repmat(resized_image, [1, 1, 3]);
         end
 %change to what you want to display
set = resized_image;
classification_matrix = zeros(10, 10);
%change "size(set,4)" if you want to go through a number other than the
%size of the set
for i = 1:(size(set,4))
    %displays original image
    figure; imagesc(set(:,:,:,i)); title('Image');
    % setting up the image into a variable
    input_image = set(:,:,:,i); % Change the index as needed

    % Initialize a cell array to store outputs of each layer
    layer_outputs = cell(1, length(layertypes));

    % Layer 1: Image Normalization
    layer = 1;
    layer_outputs{layer} = apply_imnormalize(input_image);

    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 1: Image Normalization');

    % Layer 2: Convolution
    layer = 2;
    layer_outputs{layer} = apply_convolve(layer_outputs{layer-1}, filterbanks{layer}, biasvectors{layer});
  

    % Layer 3: ReLU
    layer = 3;
    layer_outputs{layer} = apply_relu(layer_outputs{layer-1});
    
    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 3: ReLU');

    % Layer 4: Convolution
    layer = 4;
    layer_outputs{layer} = apply_convolve(layer_outputs{layer-1}, filterbanks{layer}, biasvectors{layer});
   
    % Layer 5: ReLU
    layer = 5;
    layer_outputs{layer} = apply_relu(layer_outputs{layer-1});
    
    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 5: ReLU');

    % Layer 6: Maxpool
    layer = 6;
    layer_outputs{layer} = apply_maxpool(layer_outputs{layer-1});
    
    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 6: Maxpool');

    layer = 7;
    layer_outputs{layer} = apply_convolve(layer_outputs{layer-1}, filterbanks{layer}, biasvectors{layer});

    layer = 8;
    layer_outputs{layer} = apply_relu(layer_outputs{layer-1});

    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 5: ReLU');

    layer = 9;
    layer_outputs{layer} = apply_convolve(layer_outputs{layer-1}, filterbanks{layer}, biasvectors{layer});

    layer = 10;
    layer_outputs{layer} = apply_relu(layer_outputs{layer-1});

    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 5: ReLU');

    layer = 11;
    layer_outputs{layer} = apply_maxpool(layer_outputs{layer-1});

    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 6: Maxpool');

    layer = 12;
    layer_outputs{layer} = apply_convolve(layer_outputs{layer-1}, filterbanks{layer}, biasvectors{layer});

    layer = 13;
    layer_outputs{layer} = apply_relu(layer_outputs{layer-1});

    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 5: ReLU');

    layer = 14;
    layer_outputs{layer} = apply_convolve(layer_outputs{layer-1}, filterbanks{layer}, biasvectors{layer});

    layer = 15;
    layer_outputs{layer} = apply_relu(layer_outputs{layer-1});

    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 5: ReLU');

    layer = 16;
    layer_outputs{layer} = apply_maxpool(layer_outputs{layer-1});

    %visualize
    %%figure; imagesc(layer_outputs{layer}(:,:,1)); title('Layer 6: Maxpool');

    layer = 17;
    layer_outputs{layer} = apply_fullconnect(layer_outputs{layer-1}, filterbanks{layer}, biasvectors{layer});

    layer = 18;
    layer_outputs{layer} = apply_softmax(layer_outputs{layer-1});
    


    % Final Output: Softmax probabilities
    [maxprob, maxclass] = max(layer_outputs{18});
    predicted_label = classlabels{maxclass};
    fprintf('%d: Predicted Class: %s with Probability: %.4f\n',i, predicted_label, maxprob);
    
    %a for loop that will display the size of every layer
    %%for d = 1:length(layerResults)
        %%result = layerResults{d};

        %displays the size of the layer 
        %%fprintf('layer %d output is size %d x %d x %d\n', d, size(result,1),size(result,2), size(result,3));
        current_image = set(:,:,:,i);
    

    % Get the predicted class (class with the highest probability)
    [~, predicted_class] = max(layer_outputs{18});
    
    % Get the truth class for the current image
    ground_truth_class = trueclass(i);
    
    % Add into the classification matrix
    classification_matrix(ground_truth_class, predicted_class) = classification_matrix(ground_truth_class, predicted_class) + 1;
    end
    correct_classifications = trace(classification_matrix); % Sum of diagonal elements
    total_classifications = sum(classification_matrix(:)); % Sum of all elements
    accuracy = correct_classifications / total_classifications;

    % Display the classification matrix and the accuracy
    disp('Classification Matrix:');
    disp(classification_matrix);
    fprintf('Classification Accuracy: %.2f%%\n', accuracy * 100);
    
    
end


function outarray = apply_imnormalize(inarray)
    % Input is an NxMx3 image, and output is NxMx3
    outarray = double(inarray) ./ 255.0 - 0.5;
end

function outarray = apply_relu(inarray)
    % Input is NxMxD and output is the same size
    outarray = max(inarray, 0);
end

function outarray = apply_maxpool(inarray)
    % Input is 2Nx2MxD, and output is NxMxD
    [N, M, D] = size(inarray);
    outarray = zeros(N/2, M/2, D);
    for d = 1:D
        for i = 1:N/2
            for j = 1:M/2
                outarray(i, j, d) = max(max(inarray(2*i-1:2*i, 2*j-1:2*j, d)));
            end
        end
    end
end

function outarray = apply_convolve(inarray, filterbank, biasvals)
    % inarray: NxMxD1, filterbank: RxCxD1xD2, biasvals: length D2 vector
    % outarray is NxMxD2
    [N, M, D1] = size(inarray);
    [R, C, ~, D2] = size(filterbank);
    outarray = zeros(N, M, D2);
    
    for l = 1:D2
        for k = 1:D1
            outarray(:,:,l) = outarray(:,:,l) + imfilter(inarray(:,:,k), filterbank(:,:,k,l), 'conv', 'same');
        end
        outarray(:,:,l) = outarray(:,:,l) + biasvals(l);
    end
end

function outarray = apply_fullconnect(inarray, filterbank, biasvals)
    % inarray: NxMxD1, filterbank: NxMxD1xD2, biasvals: length D2 vector
    % outarray is 1x1xD2
    [N, M, D1] = size(inarray);
    D2 = size(filterbank, 4);
    outarray = zeros(1, 1, D2);
    
    for l = 1:D2
        outarray(1, 1, l) = sum(sum(sum(inarray .* filterbank(:,:,:,l)))) + biasvals(l);
    end
end

function outarray = apply_softmax(inarray)
    % Input is 1x1xD, and output is the same size
    D = size(inarray, 3);
    alpha = max(inarray, [], 'all');
    exp_values = exp(inarray - alpha);
    outarray = exp_values / sum(exp_values, 'all');
end

