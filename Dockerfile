FROM golang:1.26-alpine AS builder
WORKDIR /app
COPY go.mod .
COPY cmd/ cmd/
RUN go build -o server ./cmd

FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/server .
EXPOSE 8080
CMD ["./server"]