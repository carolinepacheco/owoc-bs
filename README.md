# Superpixel-based online wagging one-class ensemble for feature selection in foreground/background separation

Last Page Update: **26/03/2018**


We present an Online Weighted Ensemble of One-Class SVMs able to select suitable features for each pixel to distinguish the foreground objects from the background. In addition, our framework uses a mechanism to update these importances features over time. Moreover, a efficient heuristic approach is used to background model maintenance. Experimental results on multispectral video sequences are shown to demonstrate the potential of the proposed approach.

HIGHLIGHTS

* An incremental version of the WOC algorithm, called IncrementalWeighted One-Class Support Vector Machine (IWOC-SVM).
*  An online weighted version of random subspace (OWRS) to increase the diversity of classifiers pool.
* A mechanism called Adaptive Importance Calculation (AIC) to suitably update the relative importance of each feature over time.
* A heuristic approach for IWOC-SVM model updating to improve speed.

BRIEF OVERVIEW OF THE PROPOSED FRAMEWORK
---------------------------------------------------
<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/OWOC-BS/master/docs/ensemble_proposed2.png" border="0" /></p>

<center> <small> B Brief overview of the proposed framework. A set of multispectral features jointly with well-known features (ie. color, texture, etc.) are extracted from the trainning image sequence. Next, a weighted version of random subspace creates a diversity of classifiers pool, each classifier represented by a weighted version of one-class SVM. A heuristic approach called Small Votes Instance Selection (SVIS) is used in the SVM model updating step. Only the best week classifiers are selected and combined to form a strong classifier. Finally, we use a mechanism called Adaptive Importance (AI) computation to update the importance of the classifiers pool over time. The whole framework described here works as online manner. </center>


ALGORITHM: ONLINE WEIGHTED ONE-CLASS ENSEMBLE FOR FEATURE SELECTION
---------------------------------------------------

A.  Generate multiple weak models


<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/OWOC-BS/master/docs/algorithm.png" border="0"/></p>

B.  Adaptive Importance (AI)


<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/OWOC-BS/master/docs/algorithm2.png" border="0"/></p>

C.  Background Detection


<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/OWOC-BS/master/docs/algorithm3.png" border="0"/></p>


EXPERIMENTAL RESULTS
---------------------------------------------------

Visual results

<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/OWOC-BS/master/docs/visual_result.png" border="0" /></p>
<center> <small>  Background subtraction results using the MSVS dataset – (a) original frame, (b) ground truth and (c) proposed method. The true positives (TP) pixels are in white, true negatives (TN) pixels in black, false positives (FP) pixels in red and false negatives (FN) pixels in green.  </center>

Quantitative results

<p align="center"><img src="https://raw.githubusercontent.com/carolinepacheco/OWOC-BS/master/docs/imp_features.png" border="0" /></p>
<center> <small>   Illustration of the visual features importance through video scenes from the MSVS dataset. For each pixel, certain features are ignored or  receive relatively low importance in favor of other more informative features.  </center>


Citation
--------
If you use this code for your publications, please cite it as:
```
@inproceedings{silva Caroline
author    = {Silva, Caroline and Bouwmans, Thierry and Frelicot, Carl},
title     = {Online Weighted One-Class Ensemble for Feature Selection in Background/Foreground Separation},
booktitle = {International Conference on Pattern Recognition (ICPR)},
year      = {2016},
url       = https://www.behance.net/gallery/63435921/Weighted-Random-Subspace-for-Feature-Selection}
```