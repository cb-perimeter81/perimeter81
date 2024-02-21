FROM python:3.12

RUN pip install pipenv

RUN mkdir -p ./app
COPY app.py Pipfile Pipfile.lock ./app
ADD ./templates ./app/templates
WORKDIR ./app

RUN pipenv install --system --deploy

EXPOSE 8888
CMD ["gunicorn", "app:app", "-b", "0.0.0.0:8888", "--enable-stdio-inheritance", "--log-level", "debug"]
