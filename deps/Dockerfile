FROM tutum/tomcat:7.0
MAINTAINER Pablo Moreno <pmoreno@ebi.ac.uk>

RUN mkdir /python-pks
RUN mkdir -p /java-code/PKSPredictor
RUN mkdir /java-runner
RUN mkdir /NRPSPredictor2
WORKDIR /java-code/PKSPredictor

# python-software-properties
# python-software-properties
RUN apt-get update && apt-get install -y --no-install-recommends git maven libc6-i386 hmmer=3.1b1-3 emboss \
    python-biopython zip && \
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
    apt-get purge -y maven git zip && \
    apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /

RUN mkdir -p /tomcat/conf/Catalina/localhost
ADD tomcat-setup/PKSPredictorREST.xml /tomcat/conf/Catalina/localhost/PKSPredictorREST.xml
ADD tomcat-setup/PKSPredictorWeb.xml /tomcat/conf/Catalina/localhost/PKSPredictorWeb.xml

#ADD jars/PKSPredictorWeb.war /tomcat/webapps/trans-AT-PKS.war 
#ADD jars/PKSPredictorREST.war /tomcat/webapps/trans-AT-PKS#rest.war
#ADD jars/PKSPredictorRunner-1.0-SNAPSHOT.jar /java-runner/PKSPredictorRunner.jar
#ADD jars/Common-1.0-SNAPSHOT.jar /java-runner/Common-1.0-SNAPSHOT.jar

#RUN ["java", "-cp", "/java-runner/PKSPredictorRunner.jar", "exec.PreferenceSetter", "PythonPath:;HMMERPath:/usr/bin;FuzzProPath:/usr/bin;ScriptPath:/python-pks/PKSPredictor/src/;HMMERModelPath:/external/HMMmodel/PKSAllPlusClades_ConsSignal70_CladApril2013;UseCluster:;TmpPath:/external/tmp/"]
#RUN ["java","-cp","/java-runner/Common-1.0-SNAPSHOT.jar","encrypt.Encrypter","alph4num3r1c"]
#RUN ["mkdir","-p","/tomcat/conf/Catalina/localhost"]


#ADD jars/PKSPredictorREST.xml /tomcat/conf/Catalina/localhost/PKSPredictorREST.xml
#ADD jars/PKSPredictorWeb.xml /tomcat/conf/Catalina/localhost/PKSPredictorWeb.xml
# we need to set the preferences automatically
# add the shell script file to run python processes only
# add directory /external/HMMmodel/ where the python/tomcat app will find the hmm files, this is when the docker image is executed, as this dirs should be
# part of the external OS. This applies for the HMM models, queries (/external/query), results (/external/results) and tmp (/external/tmp).
# -v /src/webapp:/opt/webapp

# Mark one folders as imported from the host.
#VOLUME ["/export/"]

# Expose port 80 to the host
EXPOSE 8080

