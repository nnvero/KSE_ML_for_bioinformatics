# Exploratory analysis
### Metadata

The original shape of the dataset before cleaning and filtering was 1080 rows and 82 columns, 5 of which were
metadata ('MouseID', 'Genotype', 'Treatment', 'Behavior', 'class') and the rest 77 - proteins. All metadata did not contain missing values. The distribution in terms of 'Genotype', 'Treatment' classes is approximately even - 570/510. 'class' contains 8 categories depending on the genotype (Control/Ts65Dn), whether a mouse had stimulation to learn (CS/SC), the drug (Memantine/Saline) injected and the outcome (learning/ no learning). The distribution between the classes is well balanced, as they are represented with approximately the same number of replicates ranging from 105 to 150.

### Unique ID and replicates

The inspection if unique ID 'MouseID' revealed that for each mouse there is a number of technical replicates, corresponding to 5 different dilutions for each protein. For each dilution there were 3 measurements. The dataset contains 72 mice - the number of replicates (15, 3 per each of 5 dilutions) and metadata were consistent across all organisms.

### Missing values & Cleaning
As for unexpected values in proteins columns, there were 1396 missing values and 1 negative value. I assumed that the distribution if NAs might not be even among all mice and proteins. Moreover, not necessarily the protein column or the organism may be problematic, but a certain dilutions with very high or low concentration may cuase technical difficulties in terms of measurent and generate more NAs than the other dilutions with moderate concentration. To check this assumption, I have created the following plots, that show number and proportion of missing values per protein and per mouse:

![alt text](images/image.png)


![alt text](images/image-1.png)

![alt text](images/image-2.png)

There are only several problematic proteins with NA% > 5. Rem