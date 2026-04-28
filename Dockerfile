FROM eclipse-temurin:17-jdk-jammy
LABEL authors="YARA"

ENV ANDROID_SDK_ROOT /opt/android-sdk
ENV SDK_URL "https://dl.google.com/android/repository/commandlinetools-linux-11076708_latest.zip"

RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    git \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools && \
    wget -q ${SDK_URL} -O sdk.zip && \
    unzip -q sdk.zip -d ${ANDROID_SDK_ROOT}/cmdline-tools && \
    mv ${ANDROID_SDK_ROOT}/cmdline-tools/cmdline-tools ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
    rm sdk.zip

ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools

RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" "platforms;android-33" "build-tools;33.0.0"

WORKDIR /project