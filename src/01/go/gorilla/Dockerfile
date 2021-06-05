FROM golang:1.16.5-alpine3.13 as build
RUN mkdir /build
ADD . /build
WORKDIR /build
RUN go build -o web .

FROM alpine:latest
WORKDIR /app
COPY --from=build /build/web .
EXPOSE 3000
CMD ["/app/web"]

