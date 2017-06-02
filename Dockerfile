FROM tutum/tomcat:7.0
MAINTAINER Pablo Moreno <pmoreno@ebi.ac.uk>

RUN mkdir /python-pks
RUN mkdir -p /java-code/PKSPredictor
RUN mkdir /java-runner
RUN mkdir /NRPSPredictor2

WORKDIR /java-code/PKSPredictor

RUN apt-get update && apt-get install -y --no-install-recommends git maven libc6-i386 hmmer=3.1b1-3 emboss \
    python-biopython unzip && \
    git clone --depth 1 --single-branch --branch develop https://github.com/pcm32/PKSPredictor-Core /python-pks/PKSPredictor && \
    git clone --depth 1 --single-branch --branch develop https://github.com/pcm32/PKSPredictor /java-code/PKSPredictor && \
    mvn install -DskipTests && \
    wget -O NRPSPredictor2.zip http://www.ebi.ac.uk/~pmoreno/NRPSpredictor2_20111113.zip && unzip -d /NRPSPredictor2/ NRPSPredictor2.zip && \
    rm NRPSPredictor2.zip && \
    cp /java-code/PKSPredictor/PKSPredictorWeb/target/PKSPredictorWeb.war /tomcat/webapps/trans-AT-PKS.war && \
    cp /java-code/PKSPredictor/PKSPredictorREST/target/PKSPredictorREST.war /tomcat/webapps/trans-AT-PKS#rest.war && \
    cp /java-code/PKSPredictor/PKSPredictorRunner/target/PKSPredictorRunner-1.1-SNAPSHOT.jar /java-runner/PKSPredictorRunner.jar && \
    cp /java-code/PKSPredictor/Common/target/Common-1.1-SNAPSHOT.jar /java-runner/Common-1.0-SNAPSHOT.jar && \
    rm -rf /java-code /root/.m2 && \
    apt-get purge -y maven git unzip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /

RUN apt-get update && apt-get install -y --no-install-recommends unzip && \
    wget "https://drive.google.com/uc?export=download&id=0B7S2ZMhdzWwbc0FWdWlMYVVHQkU" -O cladification.zip && \
    unzip cladification.zip && rm cladification.zip && \
    apt-get purge -y unzip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /tomcat/conf/Catalina/localhost
ADD tomcat-setup/PKSPredictorREST.xml /tomcat/conf/Catalina/localhost/PKSPredictorREST.xml
ADD tomcat-setup/PKSPredictorWeb.xml /tomcat/conf/Catalina/localhost/PKSPredictorWeb.xml

# we need to set the preferences automatically
RUN ["java", "-cp", "/java-runner/PKSPredictorRunner.jar:/java-runner/Common-1.0-SNAPSHOT.jar", "exec.PreferenceSetter", "PythonPath:;HMMERPath:/usr/bin;FuzzProPath:/usr/bin;ScriptPath:/python-pks/PKSPredictor/src/;HMMERModelPath:/cladification/ks_hmmer_models/PKSAllPlusClades_ConsSignal70.hmm;UseCluster:;TmpPath:;HMMEROtherModelsPath:/cladification/other_domains/otherModels;NRPS2Path:/NRPSPredictor2;MonomerMolsPath:/cladification/pks_mol_files/;AminoAcidsMolsPath:/cladification/aa_mol_files/"]
RUN ["java","-cp","/java-runner/Common-1.0-SNAPSHOT.jar","encrypt.Encrypter","alph4num3r1c"]

# Expose port 80 to the host
EXPOSE 8080

