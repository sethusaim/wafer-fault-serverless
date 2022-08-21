FROM public.ecr.aws/lambda/python:3.8

WORKDIR /tmp

COPY . /tmp

RUN pip3 install -r requirements.txt 

CMD ["run.lambda_handler"]