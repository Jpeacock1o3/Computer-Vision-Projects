# Computer Vision Projects: CNN and 3D Scene Analysis

This repository contains two projects from the CMPEN/EE 454 computer vision course. The first project involves implementing a Convolutional Neural Network (CNN) for image classification. The second project focuses on 3D scene analysis using techniques like camera projection and triangulation.

***

## Project 1: CNN for Object Recognition

This project implements the forward pass of a Convolutional Neural Network (CNN) to classify images. The goal is to understand how a series of simple image operations can lead to complex object recognition. This implementation uses pre-trained filter and bias values, so it does not include the "learning" or backpropagation phase.

### Core Operations

The CNN is built from several key computational blocks, all implemented in MATLAB:

* **Image Normalization**: `apply_imnormalize` scales input image pixel values to a range of approximately -0.5 to 0.5.
* **ReLU (Rectified Linear Unit)**: `apply_relu` is a thresholding function that sets all negative input values to zero.
* **Max Pooling**: `apply_maxpool` reduces the spatial dimensions of an array by taking the maximum value from `2x2` blocks in each channel.
* **Convolution**: `apply_convolve` applies a bank of linear filters and biases to the input array to produce an output array, maintaining the spatial dimensions.
* **Fully Connected**: `apply_fullconnect` applies a filter bank where each filter is the same size as the input image, producing a single scalar value per filter. This is similar to a dot product operation.
* **Softmax**: `apply_softmax` converts a vector of real numbers into a probability distribution, where all values are between 0 and 1 and sum to 1.

### How It Works

The project implements an **18-layer CNN** that processes 32x32 color images from the **CIFAR-10 dataset** and outputs probabilities for 10 different object classes. The network applies a specific sequence of the core operations listed above.

The process starts with image normalization, followed by a series of convolution, ReLU, and max pooling layers. A final fully connected layer condenses the features into a vector of 10 values, which the softmax layer then converts into class probabilities.

### Performance Evaluation

The performance of the CNN was evaluated by:
* Classifying all 10,000 test images from the provided dataset.
* Generating a **10x10 confusion matrix** to see which classes were often confused for one another.
* Calculating the overall **classification accuracy**.
* Plotting the **top-k accuracy** to see how often the correct class was among the top 'k' predictions.

***

## Project 2: 3D Scene Analysis from 2D Images

This project explores the principles of camera projection, triangulation, and epipolar geometry. Using two synchronized and calibrated camera views from a motion capture (mocap) lab, the goal is to analyze a 3D scene from its 2D images.

### Key Tasks

1.  **Projecting 3D to 2D**: A function was created to project known 3D mocap points into their corresponding 2D pixel locations in both camera images. The projected points were then visualized on the images to confirm they correctly overlaid the person's body.

2.  **Triangulating 2D to 3D**: Using the corresponding 2D points from the projection task, triangulation was implemented to recover the original 3D coordinates. The accuracy of this was verified by comparing the recovered points to the original mocap data.

3.  **Measuring the 3D Scene**: By manually selecting corresponding points in both images, the triangulation function was used to make new 3D measurements. This included:
    * Defining the floor plane and verifying it was near Z=0.
    * Estimating the height of the doorway and the person.
    * Locating other objects in the scene, like a camera on a tripod.

4.  **Computing the Fundamental Matrix (F)**: The Fundamental matrix, which describes the geometric relationship between the two camera views, was calculated in three ways:
    * **From Camera Calibration**: Derived mathematically from the known camera parameters.
    * **Eight-Point Algorithm**: Computed using manually selected point correspondences, both with and without Hartley preconditioning.

5.  **Evaluating F Matrices**: The accuracy of the three computed F matrices was quantitatively measured using the **Symmetric Epipolar Distance (SED)**. This was done using the 39 known point correspondences from the mocap data. The results confirmed that the F matrix derived from calibration was the most accurate and demonstrated the benefit of using Hartley preconditioning.
