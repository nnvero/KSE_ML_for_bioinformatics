### Dataset Diagnostics

The dataset contains 23845 observations and 515 columns: 3 metadata columns (source, label, Value) and 512 deep learning feature embeddings. 
Labels are heavily dominated by classes I (11987) and C (11591) at approximately the same proportions, the minority class is S with only 276 observations. The classes are also highly unbalanced across studies. The jimt source accounts for 91.6% of all data (21848 samples), containing only classes C and I. While class S is almost exclusively present in study18 (198 / 276) and mtt (58 / 276). This introduces a possible bias for classification if the technical batch effect takes place - the model may account for possibly strong technocal batch effect rather than true biological signal.

#### Diagnostic PCA

Computing top 50 principal components shows that variance explained by individual components starts at 0.16 for PC1 and rapidly drops to near zero values by the 20th PC. Cumulative variance across 50 components does not exceed 0.61, indicating that variance is distributed across a high-dimensional space.

<img src="images/PCs.png" width="800">

When colored by class 'label', 2D PCA shows no clear separation between C and I - data points overlap heavily. This may be due to PCA's linear transformations fail to capture non-linear (as expected) biological relationships present in data.
When colored by source, strong batch separation is observed - technical variance dominates.

<img src="images/PCA.png" width="800">

To check if 2D global representations and label-source imbalances deteriorated the view, I isolated the jimt source. PCA within jimt still failed to separate classes, again suggesting that the relationship between features and labels is likely non-linear. Applying non-linear t-SNE and UMAP locally within this single source worked significantly better.

<img src="images/jimt-PCA.png" height="200">
<img src="images/jimt-UMAP&tSNE.png" height="200">

### Dimensionality Reduction

- PCA forms a single continuous cloud. C and I points are  intermingled,  minority class S dispersed along the uppertail. 
- t-SNE resolves some distinct sub-cluster and some boundaries. I forms a dominant region on the right , C concentrates on the left with a substantial overlap zonein the middle.
- UMAP isolated two smaller outlying clusters at the top and bottom right, which correspond directly to minority batches and class S. The primary central island contains almost exclusively jimt data, indicating that technical batch still has stronger signal than the biological diference.

<img src="images/dim-red-by-label.png" width="800">
<img src="images/dim-red-by-source.png" width="800">

### Supervised Classification - KNN and SVM

KNN and SVM (with RBF kernel) were trained on an 80/20 stratified split, scaling performed within training data.
- KNN with k of 5 achieved 91% accuracy and weighted F1-score of 0.91. Precision and recall were strong for well represented classes (over 0.9), while minority F1-score reached only 0.5 due to poor class representation.
- SVM performed slightly better in terms of overall accuracy - 0.92 - and the same F1-score of 0.91. Precision for majority classes was also high, but minority class scores dropped down - recall of 0.24, F1-score of 0.35.

<img src="images/KNN&SVM.png" width="800">
<img src="images/confusion-matrix.png" width="400">

### Unsupervised Clustering

K-means and Agglomerative Hierarchical Clustering were performed using K=3 to match the number of actual labels.

Silhouette scores were close both methods (K-means 0.28; Hierarchical Clustering 0.25) and indicated weak separation into 3 clusters. Low ARI and NMI (<0.03 and <0.06 reprectively) confirmed that clusters do not match actual class labels

Both K-Means and Agglomerative Clustering partition the large central UMAP island into halves (Clusters 0 and 1) based on spatial distance and assign distinct outlying island to Cluster 2. Overall, unsupervised algorithms cluster primarily by technical batch.

<img src="images/unsupervised-UMAP.png" height="250">
<img src="images/UMAP-by-label.png" height="250">