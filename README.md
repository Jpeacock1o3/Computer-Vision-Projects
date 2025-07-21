# Computer Vision Projects: CNN and 3D Scene Analysis

This repository contains two projects from the CMPEN/EE 454 computer vision course. The first project involves implementing a Convolutional Neural Network (CNN) for image classification. The second project focuses on 3D scene analysis using techniques like camera projection and triangulation.

***

## Project 1: CNN for Object Recognition

[cite_start]This project implements the forward pass of a Convolutional Neural Network (CNN) to classify images[cite: 3]. [cite_start]The goal is to understand how a series of simple image operations can lead to complex object recognition[cite: 4]. [cite_start]This implementation uses pre-trained filter and bias values, so it does not include the "learning" or backpropagation phase[cite: 6].

### Core Operations

The CNN is built from several key computational blocks, all implemented in MATLAB:

* [cite_start]**Image Normalization**: `apply_imnormalize` scales input image pixel values to a range of approximately -0.5 to 0.5[cite: 31, 32].
* [cite_start]**ReLU (Rectified Linear Unit)**: `apply_relu` is a thresholding function that sets all negative input values to zero[cite: 35, 36].
* [cite_start]**Max Pooling**: `apply_maxpool` reduces the spatial dimensions of an array by taking the maximum value from `2x2` blocks in each channel[cite: 37, 39].
* [cite_start]**Convolution**: `apply_convolve` applies a bank of linear filters and biases to the input array to produce an output array, maintaining the spatial dimensions[cite: 44, 46].
* [cite_start]**Fully Connected**: `apply_fullconnect` applies a filter bank where each filter is the same size as the input image, producing a single scalar value per filter[cite: 118, 119]. [cite_start]This is similar to a dot product operation[cite: 140].
* [cite_start]**Softmax**: `apply_softmax` converts a vector of real numbers into a probability distribution, where all values are between 0 and 1 and sum to 1[cite: 163].

### How It Works

[cite_start]The project implements an **18-layer CNN** that processes 32x32 color images from the **CIFAR-10 dataset** and outputs probabilities for 10 different object classes[cite: 167, 173, 211]. [cite_start]The network applies a specific sequence of the core operations listed above[cite: 168].

[cite_start]The process starts with image normalization, followed by a series of convolution, ReLU, and max pooling layers[cite: 200, 201]. [cite_start]A final fully connected layer condenses the features into a vector of 10 values, which the softmax layer then converts into class probabilities[cite: 202].

### Performance Evaluation 📊

The performance of the CNN was evaluated by:
* [cite_start]Classifying all 10,000 test images from the provided dataset[cite: 267].
* [cite_start]Generating a **10x10 confusion matrix** to see which classes were often confused for one another[cite: 267].
* [cite_start]Calculating the overall **classification accuracy**[cite: 263, 270].
* [cite_start]Plotting the **top-k accuracy** to see how often the correct class was among the top 'k' predictions[cite: 273, 275].

***

## Project 2: 3D Scene Analysis from 2D Images

[cite_start]This project explores the principles of camera projection, triangulation, and epipolar geometry[cite: 331]. [cite_start]Using two synchronized and calibrated camera views from a motion capture (mocap) lab, the goal is to analyze a 3D scene from its 2D images[cite: 332, 334].

### Key Tasks

1.  [cite_start]**Projecting 3D to 2D**: A function was created to project known 3D mocap points into their corresponding 2D pixel locations in both camera images[cite: 357]. [cite_start]The projected points were then visualized on the images to confirm they correctly overlaid the person's body[cite: 359, 360].

2.  [cite_start]**Triangulating 2D to 3D**: Using the corresponding 2D points from the projection task, triangulation was implemented to recover the original 3D coordinates[cite: 365]. [cite_start]The accuracy of this was verified by comparing the recovered points to the original mocap data[cite: 371].

3.  [cite_start]**Measuring the 3D Scene**: By manually selecting corresponding points in both images, the triangulation function was used to make new 3D measurements[cite: 377]. This included:
    * [cite_start]Defining the floor plane and verifying it was near Z=0[cite: 381, 382].
    * [cite_start]Estimating the height of the doorway and the person[cite: 386, 387].
    * [cite_start]Locating other objects in the scene, like a camera on a tripod[cite: 388, 389].

4.  **Computing the Fundamental Matrix (F)**: The Fundamental matrix, which describes the geometric relationship between the two camera views, was calculated in three ways:
    * [cite_start]**From Camera Calibration**: Derived mathematically from the known camera parameters[cite: 391].
    * [cite_start]**Eight-Point Algorithm**: Computed using manually selected point correspondences, both with and without Hartley preconditioning[cite: 402, 406].

5.  [cite_start]**Evaluating F Matrices**: The accuracy of the three computed F matrices was quantitatively measured using the **Symmetric Epipolar Distance (SED)**[cite: 413]. [cite_start]This was done using the 39 known point correspondences from the mocap data[cite: 416, 418]. [cite_start]The results confirmed that the F matrix derived from calibration was the most accurate and demonstrated the benefit of using Hartley preconditioning[cite: 421, 422].