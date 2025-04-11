FROM ghcr.io/cirruslabs/flutter:latest

WORKDIR /app

COPY pubspec.yaml pubspec.lock ./

RUN flutter pub get

COPY . .


RUN flutter test


# RUN flutter build apk --split-per-abi

