FROM python:3.8.5

RUN pip install --upgrade pip && pip install setuptools psycopg2-binary sqlalchemy pyhive elasticsearch-dbapi ibm_db_sa jupyter pandas numpy sklearn scipy boto3 graphviz jupyter_http_over_ws dask pyarrow modin

RUN mkdir -p /opt/app/data && groupadd --system --gid=1000 app\
    && useradd --system --no-log-init --gid app --uid=1000 app -m

COPY entrypoint.sh /opt/app/entrypoint.sh

RUN mkdir /home/app/.jupyter && chmod +x /opt/app/entrypoint.sh \
    && chown -R app:app /opt/app \
    && chown -R app:app /home/app

ENV NOTEBOOK_PASS "sha1:92cf1ff5134d:eecd093c46b3b5b98285ab0238ebe929e640b2a8"
ENV SESSION_LENGTH "4h"

EXPOSE 8888

WORKDIR /opt/app/data

USER app

ENTRYPOINT ["/opt/app/entrypoint.sh"]

CMD ["job"]
