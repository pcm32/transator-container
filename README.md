# TransATor

## Contents

- [About TransATor](#about-TransATor)
- [Tutorial](#tutorial)
- [FAQs](#faqs)
- [Running locally](#running-locally)
- [How to cite TransATor](#how-to-cite-transator)
- [Contacts](#contacts)
 
## About TransATor

TransATor is based on the correlation between the phylogenetic origin of the keto-acylsynthase (KS) domain and its substrate specificty. We recommend to upload the entire amino acid information of a given gene cluster which will result in a complete annotation of core biosynthetic enzymes. Individual KS domains spanning at least the region between the EDAGY and HGTGT motif are, however, sufficient for reliable substrate predictions. 

![Figure 1](https://docs.google.com/uc?id=0B3GjpBpPCNBcM0hnMkdaV3VqNG8)
Figure 1: Phylogenetic tree showing KS sequences clades.

All 657 trans-AT PKS KS sequences of all annotated trans-AT PKS gene clusters were retrieved from public databases and aligned using Muscle. The alignment was refined using MAFT. A RAxML phylogentic tree was constructed and manually grouped into 48 clades according to their substrate specificty (see Fig. 1). HMM models were generated for each individual clade. In addition, alignments were constructed from individual enzymatic domains commonly present in trans-AT PKS and NRPS biosynthetic gene clusters. Moreover, FUZZPRO patterns are used to distinguish elongating from non-elongating (KS0) KSs, to determine the stereospecificity of KR domains and to distinguish PS from DH domains. The NRPSpredictor2 was incorporated to verify the specificity of amino acids incorporated by NRPS modules.

![Figure 2](https://docs.google.com/uc?id=0B3GjpBpPCNBcTEU0aXVwV1JESWs)


In a first step, a given sequence is annotated based on the comparison with the indivual HMM models for KS substrate specificties and all other present core enzymatic domains (see Fig. 2). Based on these annotations, the polyketide core structure is assembled from the determined KS substrate specificity. KS-monomers, representing the alpha-gamma position of a biosynthetic intermediate are connected and the structure is verified by the presence or absence of essential enzymatic domains for a certain monomer to be formed (e.g. a branching domain for glutarimide-containing polyketides or a PS for pyran ring-containing polyketides). The structure is then refined by the additon of amino acid side chains, cyclization patterns or the incorporation of stereochemical information. In cases in which the enzymatic machinery does not terminate with an NRPS module or a non-elongating KS, the reductive state of the beta-carbon of the last incorporated building block is determined by the so-called co-linearity rule used to predict the strcutures of textbook cis-AT PKS derived polyketides. (see Fig. 3).   

![Figure 3](https://docs.google.com/uc?id=0B3GjpBpPCNBcOTVjZHZsWlhkbjA)

### Placement of TransATor into the landscape of bioinformatic tools

TransATor is a genome mining tool designed for the structure prediction of trans-AT PKS derived polyketides. TransATor can be used for multiple scientific questions. First, transATor faciliates in-silico dereplication studies both on gene cluster and more importantly molecular level. TransATor can be used for the priorization for novel, unusual polyketide scaffolds and the in-silico linkage of orphan gene clusters to known polyketides. Most importantly, transATor was designed to guide the isolation and structure elucidation process of novel trans-AT PKS derived polyketides. Moreover, transATor can be used to generate and refine biosynthetic models.

## Tutorial

Upload your data in proper FASTA format (Fig. 4). Fig. 5 shows the output of the bacillaene trans-AT PKS biosynthetic machinery as an example. On top the predicted polyketide core structure is displayed. For the predicted structure only the top HMM hit of the respecitive KS sequence is taken into consideration. Below, the gene cluster annotation is displayed. The uploaded sequence is displayed as a line with annotations based on HMM models (boxes) being displayed below the line and FUZZPRO patterns (diamonds) on top of the line representing the sequence. Each annotation contains information on the enzymatic domain, its substrate specificity, e-value and localisation within the input sequence. Hovering across the annotation will display this information. For KS sequences, the top 5 hits are displayed. While the structure is generated from the top hit only, it might be worth while comparing the e-values of the other hits and, if necessary, also take other monomers for the corresponding position in the predicted molecule into consideration. Output files can be exported as images.

## FAQs

### Can I run trans-ATor locally as a stand-alone program?

Yes. A stand-alone version of trans-ATor is available as a Docker container, which runs on Linux, macOS and Windows operating systems. See [running locally](#running-locally) to know how to run it. 

### Why does the output page remain blank?

In case your sequence was not uploaded in proper FASTA format, the output page will remain blank. You can convert your data into proper FASTA format using e.g.  [MultiFasta builder](http://www.dnabaser.com/help/tools-converters/MultiFASTA%20Builder/index.htm) (batch conversion), [ReadSeq at EBI](http://www.ebi.ac.uk/Tools/sfc/readseq/) or
[ReadSeq at NIH](http://www-bimas.cit.nih.gov/molbio/readseq/).


## Running locally

The only supported way of running TransATor locally is by using the available docker container. 
Provided that your machine has docker installed, please run:

```
docker run -p 8080:8080 quay.io/pcm32/transator:2.0-rc1
```

This will start the container and show logs in your terminal window. To access the web application, go in your browser to 
http://localhost:8080/trans-AT-PKS/. There you can enter a query to run on TransATor.

## Installing locally without docker

This is not supported, but if you really need to do it, looking at the [Dockerfile](Dockerfile) on this repo will give you all the steps needed
for you to install TransATor directly. Some steps will vary from platform to platform (like how you install emboss or hmmer). 
Make sure to use the same versions as available in the container, for reproducibility and avoiding bugs.

## Source code availability

TransATor is composed of various parts:

- Sequence annotation module: takes care of reading a fasta input, running HMMER and fuzzpro with relevant motifs, and parsing results
to produce the provided sequence annotated with relevant domains/sequence features. Source code for this part is available at https://github.com/pcm32/TransATor-core
(see [Dockerfile](Dockerfile) for exact branches/tags to be used).
- Cheminformatics & web modules: Provides the web interface for TransATor that accepts query sequences, runs the sequence annotation
module and then with its results, uses the Chemistry Development Kit (CDK) to create a first automatic solution for the polyketide expected. The source code for this
is avaulable at https://github.com/pcm32/TransATor-java (see [Dockerfile](Dockerfile) for exact branches/tags to be used).

# How to cite transATor:



# Contacts

transATor was developed by [Pablo Moreno](http://www.ebi.ac.uk/about/people/pablo-moreno) and [Eric Helfrich](http://www.micro.biol.ethz.ch/people/person-detail.html?persid=193667), within the groups of [Christoph Steinbeck](http://www.ebi.ac.uk/about/people/christoph-steinbeck) at EBML-EBI and [Jörn Piel](http://www.micro.biol.ethz.ch/research/piel.html) at ETH Zurich, respectively.
