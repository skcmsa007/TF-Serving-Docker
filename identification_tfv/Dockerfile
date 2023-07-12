FROM tensorflow/serving

FROM python:3.8-slim

RUN mkdir identification_tfv

WORKDIR /identification_tfv

ADD . /identification_tfv

ARG TOKEN
ARG VAULT_IP
RUN echo ${TOKEN}
RUN echo ${VAULT_IP}

#RUN apt install nano -y

#RUN apt install build-essential -y
RUN apt-get update
RUN apt-get install -y gnupg
RUN apt-get install -y curl
RUN pip install grpcio
RUN pip install grpcio-tools

# RUN echo "deb [arch=amd64] http://storage.googleapis.com/tensorflow-serving-apt stable tensorflow-model-server tensorflow-model-server-universal" | tee /etc/apt/sources.list.d/tensorflow-serving.list

# RUN curl https://storage.googleapis.com/tensorflow-serving-apt/tensorflow-serving.release.pub.gpg | apt-key add -

# RUN apt-get update 
# RUN apt-get install tensorflow-model-server
#instance requrment
RUN apt-get install wget unzip zip -y
RUN wget http://storage.googleapis.com/tensorflow-serving-apt/pool/tensorflow-model-server-2.7.0-rc1/t/tensorflow-model-server/tensorflow-model-server_2.7.0-rc1_all.deb
RUN dpkg -i tensorflow-model-server_2.7.0-rc1_all.deb
RUN apt install ./tensorflow-model-server_2.7.0-rc1_all.deb
RUN apt-get update 
RUN pip install --upgrade awscli

RUN pip install dvc[s3]


RUN chmod u+x dvcmodel.sh

RUN ./dvcmodel.sh $TOKEN $VAULT_IP
RUN rm dvcmodel.sh
CMD ["tensorflow_model_server","--port=8600","--rest_api_port=8064", "--enable_batching=true", "--batching_parameters_file=/identification_tfv/batch.config","--model_name=identification","--model_base_path=/identification_tfv/models/identification_model_25th_July_22/identification_model_25th_July_22","--tensorflow_session_parallelism=16"]
