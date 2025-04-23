FROM grafana/xk6:0.9.2 as builder
WORKDIR /build
RUN xk6 build --with github.com/szkiba/xk6-dashboard@v0.4.4
RUN chmod +x k6

FROM alpine:3.14
RUN adduser -D -u 12345 -g 12345 k6

ENV BASE_URL http://0.0.0.0:3000
ENV HTTP_USERNAME test
ENV HTTP_PASSWORD test

WORKDIR /tests
COPY loadtest.js .

COPY --from=builder /build/k6 /usr/local/bin/k6

EXPOSE 5665
USER k6

CMD k6 run --linger --out dashboard loadtest.js
