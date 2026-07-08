FROM rust:1.84-slim AS builder
WORKDIR /src
COPY . .
RUN cargo build --release

FROM debian:bookworm-slim
WORKDIR /app
RUN useradd -u 1001 -m nonroot
COPY --from=builder /src/target/release/rust-hyper /app/app
EXPOSE 8080
USER nonroot
CMD ["/app/app"]