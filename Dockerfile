# Build: docker build -t go-docker .
FROM golang:1.16 AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app

# Prod
FROM alpine:3.14
WORKDIR /app
COPY --from=build /app/app .
EXPOSE 3333
CMD ["./app"]
