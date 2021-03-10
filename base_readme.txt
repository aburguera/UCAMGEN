SPECIFICATION
=============

CREATOR                                     : UCAMGEN (http://github.com/aburguera/UCAMGEN)
DATASET NAME                                : ##DATASETNAME##
WORLD IMAGE FILE NAME                       : ##WORLDFNAME##
NUMBER OF IMAGES                            : ##NIMAGES##
WORLD IMAGE RESOLUTION (WROWS x WCOLUMNS)   : ##WORLDRESOLUTION##
OUTPUT IMAGES RESOLUTION (OROWS x OCOLUMNS) : ##OUTPUTRESOLUTION##
HORIZONTAL CAMERA OPENING (ALPHA)           : ##HOPENING## RAD
IMAGE TO WORLD CONVERSION                   : ##IMG2WORLD##
WORLD TO IMAGE CONVERSION                   : ##WORLD2IMG##

STRUCTURE
=========

* IMAGES (FOLDER)    : Contains ##NIMAGES## images named from IMAGE0001.png to IMAGE##ZNIMAGES##.png. Each IMAGEi.png has been grabbed from a virtual viewport called VIEWPORTi. The viewport coordinates are relative and have the scale of the world image.
* OVERLAP.csv (FILE) : Symmetrical overlap matrix in CSV format. The cell (i,j) states the percentage of overlap between the viewports VIEWPORTi and VIEWPORTj from which IMAGEi.png and IMAGEj.png were generated respectively. The percentage is computed as round(100*A/B) where A and B are the areas of the intersection and the union, respectively, of the two mentioned viewports.
* IMGRPOS.csv (FILE) : Relative motion between all viewports in CSV format. The cell (i,j) represents the relative motion from VIEWPORTi to VIEWPORTj. The motion is expressed as X#Y#O#H where X and Y denote displacement in X and Y, O denotes change in heading and H denotes change in altitude. Displacements are expressed in viewport units and angles are expressed in radians. Please note that the matrix is NOT symmetrical, though cell(i,j)=inverse_transform(cell(j,i))
* IMGRPOSX.csv(FILE) : The X component of the IMGRPOS matrix. Redundant. Provided to make it easy to read it.
* IMGRPOSY.csv(FILE) : The Y component of the IMGRPOS matrix. Redundant. Provided to make it easy to read it.
* IMGRPOSO.csv(FILE) : The O component of the IMGRPOS matrix. Redundant. Provided to make it easy to read it.
* IMGRPOSH.csv(FILE) : The H component of the IMGRPOS matrix. Redundant. Provided to make it easy to read it.
* ODOM.csv    (FILE) : Relative motion between consecutive viewports in CSV format. The i-th column stores the motion from VIEWPORTi-1 to VIEWPORTi. The first column stores the absolute pose of VIEWPORT1. Each column stores [deltaX,deltaY,deltaO,deltaH] which are the change in X, Y, orientation and altitude.
* POSES.csv   (FILE) : Absolute pose of all viewports stored in the same orther in which they were acquired. The format is the same as ODOC.csv except that poses are absolute here. Note that ODOM.csv and POSES.csv actually contain redundant information.


CITATION
========

If you use this dataset, please check the UCAMGEN site (http://github.com/aburguera/UCAMGEN) for information about how to cite us.

NOTES
=====

To convert from output image coordinates to viewport coordinates please multiply times : (2*altitude*tan(ALPHA/2))/OCOLUMNS = ##IMG2WORLD##
To convert from viewport coordinates to output image coordinates please multiply times : OCOLUMNS/(2*altitude*tan(ALPHA/2)) = ##WORLD2IMG##