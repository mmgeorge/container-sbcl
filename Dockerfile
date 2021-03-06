FROM debian:latest

ENV HOME /root

COPY ./install.lisp $HOME

RUN apt-get update && apt-get install -y make bzip2 wget git build-essential libuv1-dev

# Install sbcl
RUN wget 'http://prdownloads.sourceforge.net/sbcl/sbcl-1.5.0-x86-64-linux-binary.tar.bz2' \
         -O /tmp/sbcl.tar.bz2 && \
    mkdir /tmp/sbcl && \
    tar jxvf /tmp/sbcl.tar.bz2 --strip-components=1 -C /tmp/sbcl && \
    cd /tmp/sbcl && \
    ls -la && \    
    sh install.sh && \
    cd /tmp \
    rm -rf /tmp/sbcl 


# Install deps
RUN mkdir common-lisp
WORKDIR $HOME/common-lisp

RUN git clone https://github.com/mmgeorge/asdf.git && \
    git clone https://github.com/mmgeorge/cl-expect.git && \
    git clone https://github.com/mmgeorge/cl-libuv.git && \
    git clone https://github.com/mmgeorge/cl-async && \
    git clone https://github.com/mmgeorge/blackbird.git


# Install quicklisp, warm deps
WORKDIR $HOME
RUN wget https://beta.quicklisp.org/quicklisp.lisp && \
    sbcl --load install.lisp --non-interactive

