FROM circleci/android:api-28-ndk

# https://github.com/tomaka/rust-android-docker/blob/master/Dockerfile

RUN sudo apt-get install -yq sudo curl wget git file g++ cmake pkg-config \
                        libasound2-dev bison flex unzip ant openjdk-8-jdk \
                        lib32stdc++6 lib32z1

RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
ENV PATH /home/circleci/.cargo/bin:$PATH
RUN $ANDROID_NDK_HOME/build/tools/make-standalone-toolchain.sh --platform=android-28 --arch=arm64 --install-dir=/home/circleci/NDK/arm64
COPY cargo-config /home/circleci/.cargo/config
RUN rustup target add aarch64-linux-android
RUN cargo install cargo-apk