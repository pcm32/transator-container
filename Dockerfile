FROM alpine:3.8
ARG TRANSATOR_BRANCH
ENV TRANSATOR_BRANCH=${TRANSATOR_BRANCH:-release/2.0}
RUN apk update && apk add openjdk8 maven wget && \
    mkdir -p /transator-java && \
    wget -q -O - https://github.com/pcm32/transator-java/archive/$TRANSATOR_BRANCH.tar.gz | tar xzf - --strip-components=1 -C /transator-java && \
    mvn clean install -f /transator-java/pom.xml -DskipTests && \
    mvn clean package -f /transator-java/pom.xml -DskipTests

FROM tomcat:9-jre11-slim
MAINTAINER Pablo Moreno <pmoreno@ebi.ac.uk>

RUN mkdir /python-pks
RUN mkdir /java-runner
RUN mkdir /NRPSPredictor2

 
COPY --from=0 /transator-java/PKSPredictorWeb/target/PKSPredictorWeb.war $CATALINA_HOME/webapps/trans-AT-PKS.war
COPY --from=0 /transator-java/PKSPredictorREST/target/PKSPredictorREST.war $CATALINA_HOME/webapps/trans-AT-PKS#rest.war
COPY --from=0 /transator-java/Common/target/Common-2.0.jar /java-runner/Common-2.0.jar
COPY --from=0 /transator-java/PKSPredictorRunner/target/PKSPredictorRunner-2.0.jar /java-runner/PKSPredictorRunner.jar

RUN apt-get update && apt-get install -y --no-install-recommends libc6-i386 hmmer emboss wget \
    python-biopython unzip && \
    wget -O NRPSPredictor2.zip http://www.ebi.ac.uk/~pmoreno/NRPSpredictor2_20111113.zip && unzip -d /NRPSPredictor2/ NRPSPredictor2.zip && \
     rm NRPSPredictor2.zip && \
     apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# 
# WORKDIR /
# 
# RUN apt-get update && apt-get install -y --no-install-recommends unzip && \
#     wget "https://drive.google.com/uc?export=download&id=0B7S2ZMhdzWwbc0FWdWlMYVVHQkU" -O cladification.zip && \
#     unzip cladification.zip && rm cladification.zip && \
#     apt-get purge -y unzip && \
#     apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
# 
RUN mkdir -p /tomcat/conf/Catalina/localhost
ADD tomcat-setup/PKSPredictorREST.xml /tomcat/conf/Catalina/localhost/PKSPredictorREST.xml
ADD tomcat-setup/PKSPredictorWeb.xml /tomcat/conf/Catalina/localhost/PKSPredictorWeb.xml
# 
# # we need to set the preferences automatically
RUN ["java", "-cp", "/java-runner/PKSPredictorRunner.jar:/java-runner/Common-2.0.jar", "exec.PreferenceSetter", "PythonPath:;HMMERPath:/usr/bin;FuzzProPath:/usr/bin;ScriptPath:/python-pks/PKSPredictor/src/;HMMERModelPath:/cladification/ks_hmmer_models/PKSAllPlusClades_ConsSignal70.hmm;UseCluster:;TmpPath:;HMMEROtherModelsPath:/cladification/other_domains/otherModels;NRPS2Path:/NRPSPredictor2;MonomerMolsPath:/cladification/pks_mol_files/;AminoAcidsMolsPath:/cladification/aa_mol_files/"]
RUN ["java","-cp","/java-runner/Common-2.0.jar","encrypt.Encrypter","alph4num3r1c"]
# Expose port 80 to the host
EXPOSE 8080
# 
