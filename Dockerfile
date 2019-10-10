FROM alpine:3.10.2

WORKDIR /app
RUN apk add --update --upgrade python3
COPY app.py VERSION .
ENTRYPOINT ["python3", "-u", "app.py"]

ARG BUILD_DATE
ARG VCS_REF
ARG BUILD_VERSION

LABEL org.label-schema.name="mbigras/signals"
LABEL org.label-schema.description="Experiment with container signal handling"
LABEL org.label-schema.vcs-url="https://github.com/mbigras/signals"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.build-date=$BUILD_DATE
LABEL org.label-schema.vcs-ref=$VCS_REF
LABEL org.label-schema.version=$BUILD_VERSION
