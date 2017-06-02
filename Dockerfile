FROM pcm32/pks-predictor-deps:1.1-SNAPSHOT
MAINTAINER Pablo Moreno <pmoreno@ebi.ac.uk>

COPY cladification/ks_hmmer_models /cladification/ks_hmmer_models
COPY cladification/other_domains /cladification/other_domains
COPY cladification/pks_mol_files /cladification/pks_mol_files
COPY cladification/aa_mol_files /cladification/aa_mol_files


RUN ["java", "-cp", "/java-runner/PKSPredictorRunner.jar:/java-runner/Common-1.0-SNAPSHOT.jar", "exec.PreferenceSetter", "PythonPath:;HMMERPath:/usr/bin;FuzzProPath:/usr/bin;ScriptPath:/python-pks/PKSPredictor/src/;HMMERModelPath:/cladification/ks_hmmer_models/PKSAllPlusClades_ConsSignal70.hmm;UseCluster:;TmpPath:;HMMEROtherModelsPath:/cladification/other_domains/otherModels;NRPS2Path:/NRPSPredictor2;MonomerMolsPath:/cladification/pks_mol_files/;AminoAcidsMolsPath:/cladification/aa_mol_files/"]
RUN ["java","-cp","/java-runner/Common-1.0-SNAPSHOT.jar","encrypt.Encrypter","alph4num3r1c"]
