FROM python:2-slim

RUN mkdir -p /usr/sr/app
WORKDIR /usr/src/app

COPY cfn-signal requirements.txt /usr/src/app/
RUN pip install -r requirements.txt

CMD ["/usr/src/app/cfn-signal"]

