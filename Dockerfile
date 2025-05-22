FROM python:3.9-slim

ARG RUN_AS_NON_ROOT=false
WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

COPY . .

# Create user and assign permissions if requested
RUN if [ "$RUN_AS_NON_ROOT" = "true" ]; then \
      useradd -u 1000 flaskuser && \
      chown -R flaskuser /app ; \
    fi

CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0"]