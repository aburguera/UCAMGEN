# Underwater Camera Dataset Generator (UCAMGEN)

This code makes it possible to create synthetic datasets of a bottom-looking camera (usually underwater but not limited to) moving with 2.5 DOF. The images are partial views of a large image called "world image".

The program has been developed using Matlab R2020b. Other Matlab versions may not run it properly.

* Author : Antoni Burguera (antoni dot burguera at uib dot es) - 2021

If you use this software, please cite the following paper:

Paper reference: to be posted soon. Please contact us.

## Understanding the system

The main modules are the following. Please check the comments in the source code to better understand them.

* Camera  : Simulates a virtual camera over the world image. Implemented by the cam_* files. Please check and execute cam_test to learn how the camera works.
* Robot   : Simulates a virtual robot able to move with 2.5DOF. Implemented by the rob_* files. Please check and execute rob_test to learn how the robot works.
* Mission : Basic functionalities to provide the robot with goal points. Implemented by the mis_* files. Please check and execute mis_test to learn how the mission works.
* Dataset : Build and export datasets. Implemented by the dat_* files. Please check and execute main.m to learn how the dataset works.

There are also several auxiliary files. Check the comments in their source code to understand them. Some of these auxiliary files are not used in the provided test and main programs. For example, fuse_imagepair or dat_plotimagepair, which are useful to display pairs of images with a known roto-translation between them.

## Testing the system

Just execute main.m and wait.

## Using the system

To use the system there are three main tasks:

* Prepare your world image. It should be a sufficiently large image so that the virtual robot can move over it and grab images of enough resolution.
* Prepare your parameter definition function. Just check dat_getsampleparams.m and modify it or create a new equivalent function with your parameters. The meaning of the parameters is explained in that function and within the code. One of these parameters is the file name of the world image.
* Execute main.m. Please be sure that your parameter definition function is called within main.m instead of dat_getsampleparams in case you created a new one.

Then you will have to wait. Please take into account that the execution time can be very large if displayMissionExecution is set to true within the parameter definition function. It is advisable to set it to true just to check the mission and to false to create the dataset. Also, the time to compute the overlap and the motion matrices is O(N^2) where N is the number of images.

After finishing, the dataset will be within the folder specified in the parameter folderName. A README file will also be created explaining the contents of the dataset.

If the program raises en error while COMPUTING VIEWPORTS, this means that one viewport partially lies outside the world image. Try modifying the mission or reducing the altitude. If the program suddenly stops (without an error) while COMPUTING VIEWPORTS is performed, this is probably due to an unachievable mission. Try to increase the mission tolerance.

## Requirements

To execute this software Matlab R2020b is required. The program has not been tested with other (older or newer) versions of Matlab.

## Disclaimer

The code is provided as it is. It may work in your computer, it may not work. It may even crash it or create a paradox that could ultimately unravel the very fabric of the space-time continuum and destroy the entire universe. Just be careful and try to understand everything before using it. If you have questions, please carefully read the code. If this doesn't help, contact us. If you want to blame us for some reason, do not contact us.

## Acknowledgement

* SAMPLE\_WORLD.jpg : Water vector created by brgfx (https://www.freepik.com/vectors/water)