FROM ubuntu:focal

RUN apt update && apt install -y \
	python \
	python3-pip

RUN pip install uncompyle6 --no-cache-dir

WORKDIR /root
