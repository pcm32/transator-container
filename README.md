# TransATor

## Contents

- [About TransATor](#about-TransATor)
- [Tutorial](#tutorial)
- [FAQs](#faqs)
- [Running locally](#running-locally)
- [How to cite TransATor](#how-to-cite-transator)
- [Source code availability](#source-code-availability)
- [Contacts](#contacts)
 
## About TransATor

Trans-acyltransferase polyketide synthases (trans-AT PKSs) are giant multi-domain enzymes that are responsible for the biosynthesis of structurally complex and pharmaceutically important polyketides. Trans-AT PKSs differ significantly from textbook cis-AT PKSs in terms of evolutionary origin, module architecture and enzymatic function. As a consequence, the rules used to predict textbook cis-AT PKS-derived polyketide structures cannot be applied to trans-AT PKSs. Bioinformatic studies on trans-AT PKSs have revealed a close correlation between the phylogenetic origin of the ketosynthase domain and the biosynthetic intermediate it recognizes. Based on this correlation, we developed the Trans-AT PKS Polyketide Predictor (TransATor) as a web application for trans-AT PKS genome mining studies. TransATor is a versatile bioinformatic tool that can be used to generate and refine biosynthetic models and to conduct in-silico dereplication studies. Moreover, we report the TransATor-guided isolation and structure elucidation of trans-AT PKS-derived polyketides. TransATor is a novel genome mining tool for the prioritization and identification of polyketide producers with potential biotechnological and pharmaceutical value.

Phylogenetic analyses of trans-AT PKSs revealed that KSs form clades that tightly correlate with the chemical structure of their substrates, here referred to as ketide clades. We chemically assigned and phylogenetically analyzed all 655 KS sequences from the 54 trans-AT PKS BGCs with characterized metabolites (status October 2016), (Fig. 1) resulting in a tree that contains 90 ketide clades. 

![Figure 1](https://github.com/PielLab/transator-wiki/blob/master/fig1.png)
_**Figure 1:** Phylogenetic separation of trans-AT PKS KS domains into ketide clades. Cladogram of 655 trans-AT PKS KS domains from characterized trans-AT PKS BGCs. cis-AT PKS KS domains from the erythromycin PKS were used as outgroup. DB: double bonds; KS0: non-elongating KS; 3PG starter: 3-phosphoglycerta starter. (For more information see Helfrich et al. 2018)_

Using these ketide clade assignments, we developed TransATor (Fig. 2). With a PKS protein sequence in FASTA format as input, the software identifies every defined KS clade and all other common PKS domains by comparison to custom-built Midden Markov Models (HMMs). EMBOSS fuzzpro patterns are used to additionally predict the absolute hydroxyl stereochemistry introduced by KR domains. NRPSpredictor2 was implemented to account for NRPS-PKS hybrid annotations. Ultimately, a Java program generates the predicted polyketide structure based on the annotated core PKS proteins making use of the Chemistry Development Kit (CDK) (Fig. 2). First, the core structure is generated based on the ketide classification of all KS sequences. Then, amino acid side chains are added, as determined by NRPSpredictor2. Since the trans-AT PKS correlation rule is based on the correlation of a KS sequence and the modification introduced into the nascent polyketide by the module upstream of a KS, ketide moiety predictions are not possible in the absence of a downstream KS after the final module or in front of NRPS- or cis-AT PKS modules. In such cases, co-linearity between the architecture of the respective module and the structure of the incorporated moiety is assumed. TransATor can be remotely accessed through this web interface written in Java/JSP, which relies on BioJS components to display the KS clade, domain annotations, and stereochemical information. An interactive HTML5 page is used for the user-friendly visualization of the transATor output (Fig. 3).

[!Figure 2](https://github.com/PielLab/transator-wiki/blob/master/fig2.png)

_**Figure 2:** TransATor workflow. Outline of the TransATor pipeline for protein-based analysis of trans-AT PKS BGCs. Core PKS domains are annotated and KS substrate specificities predicted based on HMMs. EMBOSS fuzzpro patterns are used to predict the absolute configuration of hydroxylated carbon atoms. CDK is used to render the polyke¬tide structure based on the PKS annotation. AH: acyl-hydrolase, CR: crotonase, ER: enoyl-reductase, O-MT: O-methyl-transferase, AL: acyl-ligase, GNAT: Gcn5-related N-acetyltransferase, B: branching domain, MT: methyl-transferase, KR: ketoreductase, KS0 non-elongating KS, DH: dehydratase, PS: pyran synthase, A: adenylation domain, Cyc: cyclase, Ox: oxidase, small white circle: ACP. L: l-configured hydroxyl group, D: d-configured hydroxyl group. AMT: aminotransferase. C: condensation domain._


Upload the protein sequence of your PKS of interest as a single FASTA file. Sequences in proper fasta format can either be directly pasted into the black box or upload your sequence from a file using the Browse option (Figure 3). You can convert your data into proper FASTA format using e.g. MultiFasta builder (batch conversion), ReadSeq at EBI or ReadSeq at NIH. If individual KS domains are used to for substrate predictions, use at least the region between the EDAGY and HGTGT motif.

[!Figure 3](https://github.com/PielLab/transator-wiki/blob/master/fig3.png)
_**Figure 3:** TransATor web interface. File upload._

Figure 4 shows the output of the bacillaene trans-AT PKS as an example. On top the predicted polyketide core structure is displayed. For the predicted structure only the top HMM hit for the respective KS sequence is taken into consideration. The predicted chemical structure is shown as an image and can be exported in SMILE format. To estimate the level of confidence for each monomer assembled to the final predicted structure a grey scale is used for the structural representation of the predicted polyketide.

[!Figure 4](https://github.com/PielLab/transator-wiki/blob/master/fig4.png)
_**Figure 4:** Example TransATor result._

Below (Figure 5), the PKS annotation is displayed in the Viewer panel. The uploaded sequence is displayed as a line with annotations based on HMM models (boxes) being displayed below the line and FUZZPRO pattern (diamonds) -based annotation indicating absolute hydroxyl stereochemistry predictions on top of the line representing the sequence. Each annotation contains information on the enzymatic domain, its substrate specificity, e-value and localization within the input sequence. Hovering across the annotation will display this information. For KS sequences, the top five hits are displayed. While the structure is generated from the top hit only, it might be worthwhile comparing the e-values of the other hits and, if necessary, also take other monomers for the corresponding position in the predicted molecule into consideration. 

[!Figure 5](https://github.com/PielLab/transator-wiki/blob/master/fig5.png)
_**Figure 5:** Example TransATor result. TransATor-based PKS/NRPS annotation output._

The Raw (Figure 6) panel display only the top five hits of the KS substrate prediction. The predicted structure can be used to dereplication studies, prioritization, in-silico annotation of known polyketides to orphan biosynthetic gene clusters and guide the isolation and structure elucidation process. 


[!Figure 6](https://github.com/PielLab/transator-wiki/blob/master/fig6.png)
_**Figure 6:** Example TransATor result. KS annotation panel._

# Placement of TransATor into the landscape of bioinformatic tools

TransATor is a genome mining tool designed for the structure prediction of trans-AT PKS derived polyketides. TransATor can be used for multiple scientific questions. First, transATor faciliates in-silico dereplication studies both on gene cluster and more importantly molecular level. TransATor can be used for the priorization for novel, unusual polyketide scaffolds and the in-silico linkage of orphan gene clusters to known polyketides. Most importantly, transATor was designed to guide the isolation and structure elucidation process of novel trans-AT PKS derived polyketides. Moreover, transATor can be used to generate and refine biosynthetic models,

# FAQs

## Why does the output page remain blank?

In case your sequence was not uploaded in proper FASTA format, the output page will remain blank or look like this:

[[https://github.com/PielLab/transator-wiki/blob/master/fig7.png]]

## How can I convert my data into proper fasta format?

You can convert your data into proper FASTA format using e.g. 
[MultiFasta Builder](http://www.dnabaser.com/help/tools-converters/MultiFASTA%20Builder/index.html)
(batch conversion), [ReadSeq at EBI](http://www.ebi.ac.uk/Tools/sfc/readseq/) or [ReadSeq at NIH](http://www-bimas.cit.nih.gov/molbio/readseq/).

## Why is no structure displayed and how can I solve this problem?

Possible reasons for this error message might be:

* The file you uploaded is not in proper fasta format.
* The uploaded file might not contain all PKS enzymes (some clades require modules upstream for cyclization or rearrangements)
* The order of PKS enzymes is not co-linear with the gene cluster architecture.
* A KS in the middle of the PKS was annotated into a starter ketide clade.
* A shifted double bond upstream of a canonical double bond was predicted.
* Multiple, sequential NRPS modules are not supported.
* TransATor encountered as yet unpredictable biochemical novelty.
* Module architectures that are not part of the termination rule training set.

You might be able to solve the problem by:
* (Re)-converting your sequence into proper fasta format.
* Uploading the complete PKS sequence.
* Reorganizing the order of PKS enzymes in your fasta file with the help of the annotation panel
* Removing the module(s) that cause(s) the error(s) and resubmitting your sequence

## Can I run trans-ATor locally as a stand-alone program?

Yes. A stand-alone version of trans-ATor is available as a Docker container, which runs on Linux, macOS and Windows operating systems. 

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
- Alignments and motifs: The TransATor-cladification module at https://github.com/PielLab/transator-cladification includes the fasta files, alignments and motifs used by TransATor-core module to annotate the sequences with the relevant KS clades (and other relevant domains/motifs).


# TransATor: What comes next?

We recommend to spend some time on dereplication of the predicted structure. This can be achieved with databases such as: MarinLit, Reaxys, Chemspider, AntiMarin, Dictionary of natural products or related databases. Below, you can find an example output for bacillaene (database: dictionary of natural products): 

[[https://github.com/PielLab/transator-wiki/blob/master/fig8.png]]
[[https://github.com/PielLab/transator-wiki/blob/master/fig9.png]]

After dereplication, the next step is prioritization. Once a polyketide is selected for isolation, you can guide your isolation process by mass, chemical composition, UV active residues, or moieties with characteristic NMR shifts. Finally, the predicted structure can guide you through the structure elucidation process.


# How to cite transATor:

TransATor: A Genome Mining Tool for the Identification and Structure Prediction of Trans-AT PKS-Derived Polyketides
Eric J. N. Helfrich, Reiko Ueoka, Alon Dolev, Michael Rust, Roy A. Meoded, Agneya Bhushan, Rodrigo Costa, Muriel Gugger, Christoph Steinbeck, Pablo Moreno and Jörn Piel (submitted)


# Contacts

transATor was developed by [Pablo Moreno](http://www.ebi.ac.uk/about/people/pablo-moreno) and [Eric Helfrich](http://www.micro.biol.ethz.ch/people/person-detail.html?persid=193667), within the groups of [Christoph Steinbeck](http://www.ebi.ac.uk/about/people/christoph-steinbeck) at EBML-EBI and [Jörn Piel](http://www.micro.biol.ethz.ch/research/piel.html) at ETH Zurich, respectively.
