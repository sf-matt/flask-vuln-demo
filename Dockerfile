FROM python:3.9-slim

ARG RUN_AS_NON_ROOT=false
WORKDIR /app
COPY app.py .

RUN pip install flask

# If requested, create a non-root user
RUN if [ "$RUN_AS_NON_ROOT" = "true" ]; then \
      useradd -u 1000 flaskuser && \
      chown -R flaskuser /app ; \
    fi

USER ${RUN_AS_NON_ROOT:+flaskuser}

CMD ["python", "app.py"]
